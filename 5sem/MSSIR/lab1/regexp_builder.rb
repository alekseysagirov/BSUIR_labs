class RegexpBuilder

  def self.bool_b_ops
    Regexp.compile %w[&& ||].map{ |ch| Regexp.escape ch }.join(?|)
  end

  def self.b_ops
    %w[+= -= == != /= *= |= &= ^= && <= >= || + - * / % = | & ^ > <].
      map{ |ch| Regexp.escape ch }.join(?|)
  end

  def self.u_ops
    %w[- & ~ ! ++ --].map{ |ch| Regexp.escape ch }.join(?|)
  end

  def self.ext_u_ops
    %w[new return]
  end

  DEF = %q{
    (?<class_def> \g<mod> \s+ class \s+ \g<identifier> \s*
      (?<inheritance> ( : \s* | \s+ (extends | implements) \s+ )
        \g<identifier> \s* ( , \s* \g<identifier> \s* )* )?
      \{ ( \g<field_def> | \g<method_def> | \s+ )* \} ){0}
    (?<field_def> (\g<mod> \s+ )+ \g<type> \s+ (?<defs> \g<def_or_init>
      ( \s* , \s* \g<def_or_init> )* ) \s*; ){0}
    (?<method_def> (\g<mod> \s+ )+ (?<ex_name> ( \g<identifier> \s* ){1,2} )
      \( (?<params> (\s* \g<identifier> \s*,?)* ) \s* \) \s* (\g<block>) ){0}
    (?<block> \{ \s* ( \g<operation>  \s* )* \} ){0}
    (?<method_call> \g<call_name> \s*
      \( ( \s* \g<expr> (\s* , \s* \g<expr> )* )? \s* \) ){0}
    (?<expr>  ( \g<u_op> \s* \g<inner_expr> | \( \s*+ \g<inner_expr> \s*+ \) |
      \g<method_call> | \g<var> | \d+ )
      ( \s*+ \[ \g<inner_expr> \] | \s*+ \g<b_op> \s*+ \g<inner_expr> )* ){0}
    (?<inner_expr> \g<expr> ){0}
    (?<operation> ( \g<single_operation> | \g<block> | continue\s*+; |
       break\s*+; ) ){0}
    (?<single_operation> ( \g<if_form> | \g<for_form> | \g<while_form> |
      \g<var_def> | \g<method_call> | ( \g<expr> \s* )? ; ) ){0}
    (?<if_form> if \s* \( \s* \g<expr> \s* \) \s* (?<then_block> \g<operation> )
      ( \s* else \s* (?<else_block> \g<operation> ) )? ){0}
    (?<for_form> for \s* \( \s*
      (?<for_control> ( \g<expr> \s* ; | \g<var_def> ) \s* \g<expr> \s*  ;
        \s* \g<expr> )
      \s* \) \s* \g<operation> ){0}
    (?<while_form> while \s*+ \( \s*+ \g<expr> \s*+ \) \s*+ \g<operation> ){0}
    (?<mod> (public | private | protected | abstract | static | final) ){0}
    (?<def_or_init> \g<identifier> ( \s* = \s* \g<expr> )? ){0}
    (?<var_def> (\g<mod> \s+ )* \g<type> \s+
      (?<defs>  \g<def_or_init> ( \s*, \s* \g<def_or_init> )* \s* ) ; ){0}
    (?<call_name> (?: \g<identifier> \. )*+ ( \g<identifier> ) ){0}
    (?<var> \g<identifier> ){0}
    (?<type> \g<identifier> ){0}
    (?<identifier> [_a-zA-Z]\w*+ ){0}
    (?<comment> ( // .*? \n | /\* .*? \*/ )){0}
  }.strip! +
  %Q{
    (?<b_op> (#{b_ops}) ){0}
    (?<u_op> (#{u_ops} | (?: #{ext_u_ops.join(?|)} ) \s ) ){0}
  }.strip!

  class << self
    def make_regexp expr
      Regexp.compile(DEF + expr, Regexp::EXTENDED | Regexp::MULTILINE)
    end

    %w[class_def method_def field_def expr var
      single_operation var_def operation method_call comment block].each do |s|
      define_method(s){ make_regexp " \\g<#{s}>" }
    end

    def io_operations str, recursive = true
      re = make_regexp('(?<wr> \g<identifier> ) \s* [^=!\w]?= \s* \g<expr>')
      res = {i: [], o: []}
      str.gsub(re) do |s|
        m = re.match(str)
        res.merge!(io_operations(m[:expr])){ |_, *v| v.flatten } if recursive
        res[:o] << m[:wr]
        res[:i] += get_vars(m[:expr] + ?;)
      end
      res[:i] = get_vars(str + ?;) unless str =~ re
      res
    end

    def get_vars src
      src.gsub(/[_a-zA-Z][\w.]*+\s*+[^(]/x).to_a.map{ |a| a[0..-2].strip }
    end

    def parse_variable_init src
      res = {i: [], o: []}
      tmpi = []; tmpo = [];
      src.split(?,).each do |defin|
        tmpi += io_operations(defin)[:i] - ext_u_ops
        tmpo += io_operations(defin)[:o] - ext_u_ops
      end
      res[:i] = tmpi; res[:o] = tmpo;
      res
    end

    def surrounded_by b = ?(, e = ?)
      # Note: b, e - one character strings.
      @sur_i ||= 0
      @sur_i += 1
      /(?<ent#@sur_i> #{Regexp.escape b} (?: (?> [^#{b}#{e}]+ ) | \g<ent#@sur_i> )* #{Regexp.escape e} )/x
    end
  end
end

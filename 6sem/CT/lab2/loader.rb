load File.join(File.dirname(__FILE__), 'repeat_coder.rb')
load File.join(File.dirname(__FILE__), 'odd_coder.rb')
load File.join(File.dirname(__FILE__), 'rect_coder.rb')
load File.join(File.dirname(__FILE__), 'tr_coder.rb')
load File.join(File.dirname(__FILE__), 'tester.rb')

RECT_CODER = RectCoder.new(4, 2)
TR_CODER = TrCoder.new(3)
REP_CODER = RepeatCoder.new(9, 3)
ODD_CODER = OddCoder.new(11, 10)

// Bicycle class
public class Bicycle {

  /* some complicated
   * comment
   * without code
   * in it
   */

  public int cadence;
  public int gear;
  public int speed;
  // public float commented;
  /* some commented
   * method:
   public void commented_meth() {}
   */


  public Bicycle(int startCadence, int startSpeed, int startGear) {
    gear = startGear;
    cadence = startCadence;
    speed = startSpeed;
  }




  public void setCadence(int newValue) {
    cadence = newValue;

  }

  public void setGear(int newValue) {
    gear = newValue;
  }

  public void applyBrake(int decrement) {
    speed -= decrement;
  }

  public void speedUp(int increment) {
    speed += increment;
  }

  private void testMethod(int n) {
    ;;;
  }
}

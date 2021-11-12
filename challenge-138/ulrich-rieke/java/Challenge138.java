import java.util.Calendar ;
import java.util.GregorianCalendar ;

public class Challenge138 {
  public static void main ( String[] args ) {
      int year = Integer.parseInt( args[ 0 ] ) ;
      int weekdays = 0 ;
      GregorianCalendar currentDate = new GregorianCalendar( year , 0 , 1 ) ;
      while ( currentDate.get( Calendar.YEAR ) == year ) {
    if ( currentDate.get( Calendar.DAY_OF_WEEK ) >= Calendar.MONDAY &&
          currentDate.get( Calendar.DAY_OF_WEEK ) <= Calendar.FRIDAY ) {
        weekdays++ ;
    }
    currentDate.add( Calendar.DAY_OF_YEAR , 1 ) ;
      }
      System.out.println( weekdays ) ;
  }
}

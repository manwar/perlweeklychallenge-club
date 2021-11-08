import java.util.ArrayList ;

public class Challenge137 {
  private static int findWeekday( int year ) {
      return ( ( year + year / 4 - year / 100 + year / 400 ) % 7 ) ;
  }

  public static void main( String[] args ) {
      ArrayList<Integer> longYears = new ArrayList<Integer>( ) ;
      for ( int y = 1900 ; y < 2101 ; y++ ) {
    if ( findWeekday( y ) == 4 || findWeekday( y - 1 ) == 3 )
        longYears.add( Integer.valueOf( y ) ) ;
      }
      int current = 0 ;
      int len = longYears.size( ) ;
      while ( current < len ) {
    if ( current < len - 1 )
        System.out.print( longYears.get( current ) + ", " ) ;
    else
        System.out.println( longYears.get( current )) ;
    current++ ;
    if ( current % 5 == 0 )
        System.out.println( " " ) ;
      }
  }
}

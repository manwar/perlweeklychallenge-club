import java.util.Scanner ;

public class Challenge188_2 {
  public static void main( String[] args ) {
      System.out.println( "Please enter an integer x!" ) ;
      Scanner sc = new Scanner( System.in ) ;
      int x = sc.nextInt( ) ;
      System.out.println( "Please enter an integer y!" ) ;
      int y = sc.nextInt( ) ;
      if ( x == y ) {
    System.out.println( 1 ) ;
      }
      else {
    int count = 0 ;
    while ( x != y ) {
        if ( x > y ) {
          x -= y ;
        }
        else {
          y -= x ;
        }
        count++ ;
    }
    count++ ;
    System.out.println( count ) ;
      }
  }
}

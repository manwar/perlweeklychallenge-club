import java.util.Scanner ;
import java.util.Vector ;

public class Challenge188 {
  public static void main( String[] args ) {
      Scanner sc = new Scanner( System.in ) ;
      System.out.println( "Please enter a number of integers, separated by blanks!") ;
      String numberLine = sc.nextLine( ) ;
      System.out.println( "Please enter an integer as divisor!" ) ;
      int divisor = sc.nextInt( ) ;
      String[] tokens = numberLine.split( " " ) ;
      int len = tokens.length ;
      Vector<Integer> numbers = new Vector<>() ;
      for ( int i = 0 ; i < len ; i++ ) {
    int n = Integer.parseInt( tokens[ i ] ) ;
    numbers.add( Integer.valueOf( n ) ) ;
      }
      int count = 0 ;
      for ( int i = 0 ; i < len - 1 ; i++ ) {
    for ( int j = i + 1 ; j < len ; j++ ) {
        int x = numbers.get( i ).intValue( ) + numbers.get( j ).intValue( ) ;
        if ( x % divisor == 0 ) {
          count++ ;
        }
    }
      }
      System.out.println( count ) ;
  }
}

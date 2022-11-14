import java.util.Scanner ;
import java.util.regex.* ;

public class Challenge190 {
  public static void main( String[] args ) {
      Scanner sc = new Scanner( System.in ) ;
      String reg1 = "^[A-Z][a-z]+$" ;
      String reg2 = "^[A-Z]+$" ;
      String reg3 = "^[a-z]+$" ;
      System.out.println( "Please enter a line consisting of letters only!" ) ;
      String line = sc.nextLine( ) ;
      if ( line.matches( reg1 ) || line.matches( reg2 ) || line.matches( reg3) ){
    System.out.println( 1 ) ;
      }
      else {
    System.out.println( 0 ) ;
      }
  }
}

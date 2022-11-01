import java.util.Scanner ;
import java.util.Arrays ;

public class Challenge189 {
  public static void main( String[] args ) {
      Scanner sc = new Scanner( System.in ) ;
      System.out.println( "Please enter a number of characters, separated by blanks!" ) ;
      String line = sc.nextLine( ) ;
      String[] charTokens = line.split( " " ) ;
      System.out.println( "Please enter a token character!" ) ;
      line = sc.nextLine( ) ;
      char token = line.charAt( 0 ) ;
      Arrays.sort( charTokens ) ;
      int count = 0 ;
      String st = (String)charTokens[count] ;
      char c = st.charAt( 0 ) ;
      while ( Character.compare( c , token ) <= 0 ) {
    count++ ;
    st = (String)charTokens[count] ;
    c = st.charAt( 0 ) ;
      }
      System.out.println( c ) ;
  }
}

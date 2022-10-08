import java.util.* ;

public class Challenge185_2 {
  public static void main( String[] args ) {
      System.out.println("Enter a code , longer than 4 characters" ) ;
      ArrayList<String> output = new ArrayList<>( ) ;
      Scanner sc = new Scanner( System.in ) ;
      String code = sc.next( ) ;
      while ( ! code.equals( "end" ) ) {
    output.add( transform( code ) ) ;
    System.out.println( "Next code, or end to end!" ) ;
    code = sc.next( ) ;
      }
      for ( String st : output ) {
    System.out.print( st + " " ) ;
      }
      System.out.println( " " ) ;
  }

  private static String transform( String s ) {
      int count = 0 ;
      int pos = 0 ;
      StringBuilder sb = new StringBuilder( ) ;
      while ( count < 4 ) {
    char c = s.charAt( pos ) ;
    if ( Character.isAlphabetic( c ) || Character.isDigit( c ) ) {
        sb.append( 'x' ) ;
        pos++ ;
        count++ ;
    }
    else {
        sb.append( c ) ;
        pos++ ;
    }
      }
      sb.append( s.substring( pos ) ) ;
      return sb.toString( ) ;
  }
}

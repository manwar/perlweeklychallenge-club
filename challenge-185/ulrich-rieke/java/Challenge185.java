import java.util.* ;
import java.util.regex.* ;

public class Challenge185 {
  public static void main( String[] args ) {
      System.out.println("Enter a MAC address in the form of hhhh.hhhh.hhhh") ;
      Scanner sc = new Scanner( System.in ) ;
      String address = sc.next( ) ;
      while ( ! Pattern.matches( "^\\w{4}\\.\\w{4}\\.\\w{4}$" , address )) {
    System.out.println("Please enter in the form hhhh.hhhh.hhhh") ;
    address = sc.next( ) ;
      }
      System.out.println( transform( address )) ;
  }

  private static String transform( String st ) {
      String[] parts = st.split( "\\." ) ;
      ArrayList<String> transformed = new ArrayList<>( ) ;
      for ( int i = 0 ; i < parts.length ; i++ ) {
    StringBuilder sb = new StringBuilder( ) ;
    sb.append( parts[i].substring(0 , 2 )) ;
    sb.append( ':' ) ;
    sb.append( parts[i].substring( 2 )) ;
    transformed.add( sb.toString( ) ) ;
      }
      StringBuilder sb = new StringBuilder( ) ;
      for ( String s : transformed ) {
    sb.append( s ) ;
    sb.append( ':' ) ;
      }
      sb.deleteCharAt( sb.length( ) - 1) ;
      return sb.toString( ) ;
  }
}

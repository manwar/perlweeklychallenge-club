public class Challenge105 {
  public static void main( String[] args ) {
      double rootnum = Double.parseDouble( args[0]) ;
      double fromNumber = Double.parseDouble(args[1]) ;
      double result = Math.pow( fromNumber , 1 / rootnum ) ;
      System.out.println( result ) ;
  }
}

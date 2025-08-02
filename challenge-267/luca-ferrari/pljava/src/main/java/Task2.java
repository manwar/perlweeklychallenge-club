


package PWC267;

/**
 * PL/Java implementation for PWC 267
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-267>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC267-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC267-1.jar', 'PWC267', true );
 select sqlj.set_classpath( 'public', 'PWC267' );

 select pwc267.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC267-1.jar', 'PWC267', true );

*/

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.Function;
import static org.postgresql.pljava.annotation.Function.Effects.IMMUTABLE;
import static org.postgresql.pljava.annotation.Function.OnNullInput.RETURNS_NULL;

import java.util.*;
import java.util.stream.*;
import java.sql.SQLException;
import java.util.logging.*;
import java.sql.ResultSet;
import java.sql.Date;

public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc267",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int[] task2_pljava( String phrase, int[] widths ) throws SQLException {


	final Map<String, Integer> pixels = new HashMap<String, Integer>();

	final int[] index = new int[1];
	index[ 0 ] = 0;
	IntStream.rangeClosed( 'a', 'z' )
	    .mapToObj( current  -> (char)  current )
	    .forEach( current -> { pixels.put( "" + current, widths[ index[ 0 ]++ ] ); } );

	 int sum = 0;
	 int lines = 1;

	 for ( String current : phrase.split( "" ) ) {
	     int current_pixels = pixels.get( current );
	     if( sum + current_pixels > 100 ) {
		 lines++;
		 sum = 0;
	     }

	     sum += current_pixels;
	 }

	 return new int[]{ lines, sum };

    }
}

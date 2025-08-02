


package PWC271;

/**
 * PL/Java implementation for PWC 271
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-271>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC271-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC271-1.jar', 'PWC271', true );
 select sqlj.set_classpath( 'public', 'PWC271' );

 select pwc271.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC271-1.jar', 'PWC271', true );

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

    @Function( schema = "pwc271",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int[] task2_pljava( int[] nums ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc271.task2_pljava" );

	final Map<String, List<Integer> > binary = new HashMap<String, List<Integer> >();

	Arrays.stream( nums )
	    .forEach( v -> {
		    String bin = Integer.toBinaryString( v );
		    int ones   = bin.split( "1" ).length;
		    binary.putIfAbsent( bin, new LinkedList<Integer>() );
		    binary.get( bin ).add( v );
		} );

	int result[] = new int[ binary.values().size() ];
	int index = 0;
	List<String> keys = new LinkedList<String>( binary.keySet() );
	Collections.sort( keys );
	for ( String bin : keys ) {
	    List<Integer> values = binary.get( bin );
	    Collections.sort( values );
	    for ( int v : values )
		result[ index++ ] = v;
	}

	return result;
    }
}




package PWC333;

/**
 * PL/Java implementation for PWC 333
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-333>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC333-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC333-1.jar', 'PWC333', true );
 select sqlj.set_classpath( 'public', 'PWC333' );

 select pwc333.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC333-1.jar', 'PWC333', true );

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

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc333",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final boolean task1_pljava( int coordinates[] ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc333.task1_pljava" );

	List<Map<String, Integer>> coords = new LinkedList<Map<String, Integer>>();

	for ( int i = 0; i < coordinates.length - 1; i++ ) {
	    Map<String, Integer> current = new HashMap<String, Integer>();
	    current.put( "x", coordinates[ i++ ] );
	    current.put( "y", coordinates[ i ] );
	    coords.add( current );
	}

	Map<String, Integer> first  = coords.get( 0 );
	Map<String, Integer> second = coords.get( 1 );

	for ( int i = 2; i < coords.size(); i++ ) {
	    Map<String, Integer> current = coords.get( i );

	    if ( ( current.get( "x" ) - first.get( "x" ) ) * ( first.get( "y" ) - second.get( "y" ) )
		 != ( current.get( "y" ) - first.get( "y" ) ) * ( first.get( "x" ) - second.get( "x" ) ) )
		return false;
	}

	return true;
    }
}

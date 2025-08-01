


package PWC332;

/**
 * PL/Java implementation for PWC 332
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-332>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC332-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC332-1.jar', 'PWC332', true );
 select sqlj.set_classpath( 'public', 'PWC332' );

 select pwc332.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC332-1.jar', 'PWC332', true );

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

    @Function( schema = "pwc332",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final boolean task1_pljava( String text ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc332.task1_pljava" );

	Map<String, Integer> bag = new HashMap<String, Integer>();
	boolean ok = true;

	for ( String c : text.split( "" ) ) {
	    bag.putIfAbsent( c, 0 );
	    bag.put( c, bag.get( c ) + 1 );
	    if ( bag.get( c ) > 1 )
		ok = false;
	}

	return ok;

    }
}




package PWC278;

/**
 * PL/Java implementation for PWC 278
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-278>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC278-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC278-1.jar', 'PWC278', true );
 select sqlj.set_classpath( 'public', 'PWC278' );

 select pwc278.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC278-1.jar', 'PWC278', true );

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

    @Function( schema = "pwc278",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task2_pljava( String word, String c ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc278.task2_pljava" );

	if ( ! word.contains( c ) )
	    return word;

	final List<String> left = new LinkedList<String>();
	final List<String> right = new LinkedList<String>();
	final boolean[] found = { false };
	Stream.of( word.split( "" ) ).forEach( letter -> {
		if ( found[ 0 ] )
		    right.add( letter );
		else {
		    left.add( letter );

		    if ( letter.equals( c ) )
			found[ 0 ] = true;
		}
	    } );

	Collections.sort( left );
	return left.stream().collect( Collectors.joining() ) + right.stream().collect( Collectors.joining() );
    }
}

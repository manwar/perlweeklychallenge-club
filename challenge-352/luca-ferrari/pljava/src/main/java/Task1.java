


package PWC352;

/**
 * PL/Java implementation for PWC 352
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-352>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC352-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC352-1.jar', 'PWC352', true );
 select sqlj.set_classpath( 'public', 'PWC352' );

 select pwc352.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC352-1.jar', 'PWC352', true );

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
import java.util.regex.*;

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc352",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String[] task1_pljava( String strings[] ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc352.task1_pljava" );

	List<String> found = new LinkedList<String>();

	for ( int i = 0; i < strings.length; i++ ) {
	    String current = strings[ i ];

	    Pattern regexp = Pattern.compile( current );

	    for ( int j = i + 1; j < strings.length; j++ ) {
		if ( regexp.matcher( strings[ j ] ).find() ) {
		    found.add( current );
		}
	    }
	}


	return found.toArray( new String[0] );
    }
}

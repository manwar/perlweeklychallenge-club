


package PWC322;

/**
 * PL/Java implementation for PWC 322
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-322>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC322-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC322-1.jar', 'PWC322', true );
 select sqlj.set_classpath( 'public', 'PWC322' );

 select pwc322.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC322-1.jar', 'PWC322', true );

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

    @Function( schema = "pwc322",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task1_pljava( String string, int size ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc322.task1_pljava" );

	List<String> pieces = new LinkedList<String>();

	for ( String s : string.split( "-" ) ) {
	    for ( String q : s.split( "" ) )
		pieces.add( q );
	}

	String result = "";

	for ( int i = 0; i < pieces.size(); ) {
	    for ( int j = 0; j < size; j++ ) {
		if ( i >= pieces.size() )
		    break;

		result += pieces.get( i++ );
	    }

	    if ( i < pieces.size() )
		result += "-";
	}

	return result;
    }
}

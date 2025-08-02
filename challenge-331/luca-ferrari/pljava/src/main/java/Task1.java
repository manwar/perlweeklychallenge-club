


package PWC331;

/**
 * PL/Java implementation for PWC 331
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-331>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC331-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC331-1.jar', 'PWC331', true );
 select sqlj.set_classpath( 'public', 'PWC331' );

 select pwc331.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC331-1.jar', 'PWC331', true );

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

    @Function( schema = "pwc331",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static int task1_pljava( String sentence ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc331.task1_pljava" );

	int length = 0;

	for ( String s : sentence.split( "\\s+" ) ) {
	    s = s.trim();
	    if ( s.length() == 0 )
		continue;

	    length = s.length();
	}

	return length;
    }
}

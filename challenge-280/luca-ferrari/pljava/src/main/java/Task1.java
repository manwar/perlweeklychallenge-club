


package PWC280;

/**
 * PL/Java implementation for PWC 280
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-280>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC280-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC280-1.jar', 'PWC280', true );
 select sqlj.set_classpath( 'public', 'PWC280' );

 select pwc280.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC280-1.jar', 'PWC280', true );

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

    @Function( schema = "pwc280",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static String  task1_pljava( String string ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc280.task1_pljava" );

	for ( String needle : string.split( "" ) ) {
	    int count = 0;
	    for ( String s : string.split( "" ) )
		if ( s.equals( needle ) )
		    count++;


	    if ( count > 1 )
		return needle;
	}

	return null;
    }
}

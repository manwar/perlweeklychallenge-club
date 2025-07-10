


package PWC329;

/**
 * PL/Java implementation for PWC 329
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-329>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC329-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC329-1.jar', 'PWC329', true );
 select sqlj.set_classpath( 'public', 'PWC329' );

 select pwc329.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC329-1.jar', 'PWC329', true );

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

public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc329",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task2_pljava( String string ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc329.task2_pljava" );


	char chars[] = string.toCharArray();

	int begin = 0;
	int end   = 0;

	for ( int i = 0; i < chars.length; i++ ) {
	    char c = chars[ i ];
	    char n = Character.toUpperCase( c );
	    if ( Character.isUpperCase( c ) )
		n = Character.toLowerCase( c );

	    for ( int j = i + 1; j < chars.length; j++ )
		if ( chars[ j ] == n )
		    if ( ( end - begin ) < ( j - i ) ) {
			begin = i;
			end   = j;
		    }
	}

	return string.substring( begin, end + 1 );
    }
}

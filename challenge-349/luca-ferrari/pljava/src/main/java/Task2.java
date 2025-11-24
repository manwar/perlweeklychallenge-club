


package PWC349;

/**
 * PL/Java implementation for PWC 349
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-349>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC349-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC349-1.jar', 'PWC349', true );
 select sqlj.set_classpath( 'public', 'PWC349' );

 select pwc349.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC349-1.jar', 'PWC349', true );

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

    @Function( schema = "pwc349",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final boolean task2_pljava( String directions ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc349.task2_pljava" );

	int left = 0, right = 0, up = 0, down = 0;

	for ( String m : directions.split( "" ) ) {
	    if ( m.equals( "L" ) )
		left++;
	    else if ( m.equals( "R" ) )
		right++;
	    else if ( m.equals( "U" ) )
		up++;
	    else if ( m.equals( "D" ) )
		down++;
	}


	return left == right && up == down;


    }
}

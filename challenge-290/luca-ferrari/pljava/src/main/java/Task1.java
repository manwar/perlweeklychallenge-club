


package PWC290;

/**
 * PL/Java implementation for PWC 290
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-290>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC290-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC290-1.jar', 'PWC290', true );
 select sqlj.set_classpath( 'public', 'PWC290' );

 select pwc290.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC290-1.jar', 'PWC290', true );

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

    @Function( schema = "pwc290",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final boolean task1_pljava( int[] numbers ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc290.task1_pljava" );

	int counter = 0;

	for ( int i = 0; i < numbers.length - 1; i++ )
	    for ( int j = 0; j < numbers.length; j++ )
		if ( numbers[ i ] == numbers[ j ] * 2 )
		    counter++;

	return counter > 0;
    }
}

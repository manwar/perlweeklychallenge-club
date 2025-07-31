


package PWC332;

/**
 * PL/Java implementation for PWC 332
 * Task 2
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

public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc332",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task2_pljava( String date ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc332.task2_pljava" );

	String result = "";
	int dashes = 2;
	for ( String current : date.split( "-" ) ) {
	    result += Integer.toBinaryString( Integer.parseInt( current ) );
	    if ( dashes > 0 ) {
		result += "-";
		dashes--;
	    }
	}

	return result;
    }
}

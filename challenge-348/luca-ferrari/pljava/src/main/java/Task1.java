


package PWC348;

/**
 * PL/Java implementation for PWC 348
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-348>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC348-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC348-1.jar', 'PWC348', true );
 select sqlj.set_classpath( 'public', 'PWC348' );

 select pwc348.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC348-1.jar', 'PWC348', true );

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

    @Function( schema = "pwc348",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static boolean task1_pljava( String text ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc348.task1_pljava" );

	if ( text == null || text.isEmpty() || text.length() %2 != 0 )
	    return false;

	int left = 0, right = 0, middle = text.length() / 2;
	int index = 0;
	String vowels = "aeiou";
	for ( String c : text.split( "" ) ) {
	    index++;

	    if ( vowels.indexOf( c ) < 0 )
		continue;

	    if ( index <= middle )
		left++;
	    else
		right++;
	}

	return left == right;
    }
}

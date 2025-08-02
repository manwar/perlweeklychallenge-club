


package PWC272;

/**
 * PL/Java implementation for PWC 272
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-272>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC272-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC272-1.jar', 'PWC272', true );
 select sqlj.set_classpath( 'public', 'PWC272' );

 select pwc272.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC272-1.jar', 'PWC272', true );

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

    @Function( schema = "pwc272",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task2_pljava( String string ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc272.task2_pljava" );

	int score = 0;

	for ( int i = 0; i < string.length() - 1; i++ ) {
	    int diff = string.charAt( i ) - string.charAt( i + 1 );
	    score += diff > 0 ? diff : diff * -1;
	}

	return score;
    }
}

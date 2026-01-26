


package PWC358;

/**
 * PL/Java implementation for PWC 358
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-358>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC358-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC358-1.jar', 'PWC358', true );
 select sqlj.set_classpath( 'public', 'PWC358' );

 select pwc358.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC358-1.jar', 'PWC358', true );

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

    @Function( schema = "pwc358",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task2_pljava( String src, int value ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc358.task2_pljava" );

	String alphabet = "abcdefghijklmnopqrstuvwxyz";
	String result   = "";

	for ( int i = 0; i < src.toLowerCase().length(); i++ ) {
	    char current = src.charAt( i );

	    int index = alphabet.indexOf( current );
	    index = ( index + value ) % alphabet.length();
	    current = alphabet.charAt( index );
	    result += current;
	}

	return result;
    }
}

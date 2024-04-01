package PWC256;

/**
 * PL/Java implementation for PWC 256
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-256>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC256.jar  luca@venkman:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC256.jar', 'PWC256', true );

 select 256.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC256.jar', 'PWC256', true );

*/

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.Function;
import static org.postgresql.pljava.annotation.Function.Effects.IMMUTABLE;
import static org.postgresql.pljava.annotation.Function.OnNullInput.RETURNS_NULL;

import java.util.*;
import java.sql.SQLException;
import java.util.logging.*;

public class Task2 {
    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "256",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task2_pljava( String left, String right ) throws SQLException {
	logger.log( Level.INFO, "Entering task2_pljava" );

	StringBuffer buffer = new StringBuffer( left.length() + right.length() );

	int max_index = Math.max( left.length(), right.length() );
	for ( int index = 0; index < max_index; index++ ) {
	    if ( index < left.length() )
		buffer.append( left.charAt( index ) );
	    if ( index < right.length() )
		buffer.append( right.charAt( index ) );
	}

	return buffer.toString();
    }
}

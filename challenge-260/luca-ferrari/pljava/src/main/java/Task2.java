


package PWC260;

/**
 * PL/Java implementation for PWC 260
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-260>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC260-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC260-1.jar', 'PWC260', true );
 select sqlj.set_classpath( 'public', 'pwc260' );

 select pwc260.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC260-1.jar', 'PWC260', true );

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
import java.math.*;

public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc260",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task2_pljava( String word ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc260.task2_pljava" );

	List<String> chars = new LinkedList<String>();
	for ( String s : word.split( "" ) ) {
	    logger.log( Level.INFO, "CHAR " + s );
	    chars.add( s );
	}

	List<String> words = new LinkedList<String>();

	BigInteger limit = BigInteger.ONE;
	for ( int i = 1; i <= chars.size(); i++ ) {
	    limit = limit.multiply( new BigInteger( "" + i ) );
	}

	logger.log( Level.INFO, "Limit is " + limit );
	while ( BigInteger.ZERO.compareTo( limit ) < 0 ) {


	    String newWord = "";
	    do {
		Collections.shuffle( chars );
		newWord = String.join( "", chars );
	    } while ( words.contains( newWord ) );

	    words.add( newWord );
	    limit = limit.subtract( BigInteger.ONE );
	}

	Collections.sort( words );

	for ( int i = 0; i < words.size(); i++ )
	    if ( words.get( i ).equals( word ) )
		return i + 1;


	return -1;
    }
}

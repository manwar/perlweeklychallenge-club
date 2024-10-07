


package PWC290;

/**
 * PL/Java implementation for PWC 290
 * Task 2
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
import java.util.regex.*;

public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc290",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final boolean task2_pljava( String s ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc290.task2_pljava" );

	List<Integer> numbers = new LinkedList<Integer>();

	for ( String v : s.split( "" ) ) {
	    try {
		int i = Integer.parseInt( v );
		numbers.add( i );
	    } catch ( Exception e ) { }
	}

	int payload = numbers.get( numbers.size() - 1 );
	int checksum = 0;
	Integer last = null;

	for ( int i = 0; i < numbers.size() - 1; i++ ) {
	    if ( last != null && last == numbers.get( i ) )
		continue;

	    int current = numbers.get( i ) * 2;
	    if ( current > 9 ) {
		int sum = 0;
		for ( String v : ( "" + current ).split( "" ) )
		    sum += Integer.parseInt( v );
		current = sum;
	    }

	    checksum += current;
	}

	return ( checksum + payload ) % 10 == 0;
    }
}

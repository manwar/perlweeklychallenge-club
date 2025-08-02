


package PWC269;

/**
 * PL/Java implementation for PWC 269
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-269>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC269-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC269-1.jar', 'PWC269', true );
 select sqlj.set_classpath( 'public', 'PWC269' );

 select pwc269.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC269-1.jar', 'PWC269', true );

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

    @Function( schema = "pwc269",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int[] task1_pljava( int[] nums ) throws SQLException {

	List<Integer> couples = new LinkedList<Integer>();

	for ( int i = 0; i < nums.length; i++ )
	    for ( int j = i + 1; j < nums.length; j++ )
		if ( ( nums[ i ] | nums[ j ] ) % 2 == 0 ) {
		    couples.add( nums[ i ] );
		    couples.add( nums[ j ] );
		}

	int result[] = new int[ couples.size() ];
	int i = 0;
	for ( int x : couples ) {
	    result[ i++ ] = x;
	}

	return result;
    }
}

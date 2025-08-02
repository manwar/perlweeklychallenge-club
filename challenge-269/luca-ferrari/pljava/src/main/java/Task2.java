


package PWC269;

/**
 * PL/Java implementation for PWC 269
 * Task 2
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

public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc269",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int[] task2_pljava( int[] nums ) throws SQLException {
	List<Integer> left = new LinkedList<Integer>();
	List<Integer> right = new LinkedList<Integer>();

	left.add( nums[ 0 ] );
	right.add( nums[ 1 ] );

	for ( int i = 2; i < nums.length; i++ ) {
	    if ( left.get( left.size() - 1 ) > right.get( right.size() - 1 ) )
		left.add( nums[ i++ ] );
	    else
		right.add( nums[ i++ ] );
	}

	int result[] = new int[ left.size() + right.size() ];
	int i = 0;
	for ( int x : left )
	    result[ i++ ] = x;
	for ( int x : right )
	    result[ i++ ] = x;

	return result;
    }
}

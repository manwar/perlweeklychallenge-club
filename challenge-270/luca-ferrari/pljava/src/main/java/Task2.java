


package PWC270;

/**
 * PL/Java implementation for PWC 270
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-270>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC270-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC270-1.jar', 'PWC270', true );
 select sqlj.set_classpath( 'public', 'PWC270' );

 select pwc270.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC270-1.jar', 'PWC270', true );

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

    @Function( schema = "pwc270",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task2_pljava( int score_single, int score_double, int[] numbers ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc270.task2_pljava" );

	int score = 0;
	List<Integer> nums = Arrays.stream( numbers ).boxed().collect( Collectors.toList() );

	// get the max
	Integer max = nums.stream().max( Integer::compare ).get();

	List<Integer> needs_operation = new LinkedList<Integer>();
	do {
	    needs_operation.clear();
	    IntStream
		.range( 0, nums.size() - 1 )
		.forEach( index -> {
			if ( nums.get( index ) < max )
			    needs_operation.add( index );
		    } );


	    if ( needs_operation.size() == 1 ) {
		score += score_single;
		int index = needs_operation.get( 0 );
		int value = nums.get( index );
		nums.set( index, ++value );
	    }
	    else if ( needs_operation.size() >= 2 ) {
		score += score_double;

		for ( int i = 0; i < 2; i ++ ) {
		    int index = needs_operation.get( i );
		    int value = nums.get( index );
		    nums.set( index, ++value );
		}
	    }

	} while ( ! needs_operation.isEmpty() );

	return score;

    }
}

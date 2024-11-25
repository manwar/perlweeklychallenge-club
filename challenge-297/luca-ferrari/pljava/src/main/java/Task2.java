


package PWC297;

/**
 * PL/Java implementation for PWC 297
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-297>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC297-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC297-1.jar', 'PWC297', true );
 select sqlj.set_classpath( 'public', 'PWC297' );

 select pwc297.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC297-1.jar', 'PWC297', true );

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

    @Function( schema = "pwc297",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task2_pljava( int[] nums ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc297.task2_pljava" );

	int swaps = 0;
	int f_index = IntStream.range( 0, nums.length )
	    .filter( i -> nums[ i ] == 1 )
	    .mapToObj( i -> new Integer( i ) )
	    .collect( Collectors.toList() )
	    .get( 0 );

	swaps += f_index;

	int l_index = IntStream.range( 0, nums.length )
	    .filter( i -> nums[ i ] == nums.length )
	    .mapToObj( i -> new Integer( i ) )
	    .collect( Collectors.toList() )
	    .get( 0 );

	if ( f_index < l_index )
	    swaps += nums.length - l_index;
	else
	    swaps += nums.length - l_index - ( f_index - l_index );

	return swaps;
    }
}

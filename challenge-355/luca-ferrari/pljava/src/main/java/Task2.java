


package PWC355;

/**
 * PL/Java implementation for PWC 355
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-355>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC355-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC355-1.jar', 'PWC355', true );
 select sqlj.set_classpath( 'public', 'PWC355' );

 select pwc355.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC355-1.jar', 'PWC355', true );

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

import java.util.Arrays;
import java.util.Collections;

public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc355",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final boolean task2_pljava( Integer[] nums ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc355.task2_pljava" );

	boolean ok = false;

	for ( int i = 1; i < nums.length; i++ ) {
	    Integer[] left  = Arrays.copyOfRange( nums, 0, i );
	    Integer[] left2 = Arrays.copyOfRange( nums, 0, i );
	    Arrays.sort( left2 );
	    Integer[] right  = Arrays.copyOfRange( nums, i, nums.length );
	    Integer[] right2 = Arrays.copyOfRange( nums, i, nums.length );
	    Arrays.sort( right2, Collections.reverseOrder() );

	    ok = cmp( left, left2 ) && cmp( right, right2 );

	    if ( ok )
		break;
	}

	return ok;
    }


    private static final boolean cmp( Integer[] left, Integer[] right ) {
	if ( left.length != right.length )
	    return false;

	for ( int i = 0; i < left.length; i++ )
	    if ( left[ i ] != right[ i ] )
		return false;

	return true;
    }
}

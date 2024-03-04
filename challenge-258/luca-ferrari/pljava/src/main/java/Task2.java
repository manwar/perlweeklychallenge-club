package PWC258;

/**
 * PL/Java implementation for PWC 258
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-258>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC258.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC258-1.jar', 'PWC258', true );

 select pwc258.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC258-1.jar', 'PWC258', true );

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

    @Function( schema = "pwc258",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task2_pljava( int k, int[] nums ) throws SQLException {
	logger.log( Level.INFO, "Entering task2_pljava" );

	// int sum = 0;
	// int count = 0;
	// for ( int i = 0; i < nums.length; i++ ) {
	//     count = 0;
	//     for ( String d : Integer.toBinaryString( i ).split( "" ) )
	// 	if ( d.equals( "1" ) )
	// 	    count++;


	//     if ( count == k )
	// 	sum += nums[ i ];
	// }

	// return sum

	return IntStream.range( 0, nums.length )
	    .map( current -> {
		    int ones  = 0;
		    for ( String d : Integer.toBinaryString( current ).split( "" ) )
			if ( d.equals( "1" ) )
			    ones ++;


		    if ( ones  == k )
			return nums[ current ];
		    else
			return 0;

		} ).sum();
;
    }
}

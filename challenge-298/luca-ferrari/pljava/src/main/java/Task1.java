


package PWC298;

/**
 * PL/Java implementation for PWC 298
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-298>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC298-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC298-1.jar', 'PWC298', true );
 select sqlj.set_classpath( 'public', 'PWC298' );

 select pwc298.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC298-1.jar', 'PWC298', true );

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

    @Function( schema = "pwc298",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task1_pljava(int[] plain_matrix, int cols ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc298.task1_pljava" );

	int max_size = -1;

	int matrix[][] = new int[ plain_matrix.length / cols ][ cols ];

	// convert the plain matrix in a two dimensional matrix
	for ( int r = 0; r < plain_matrix.length / cols; r++ )
	    for ( int c = 0; c < cols; c++ )
		matrix[ r ][ c ] = plain_matrix[ r * cols + c ];


	for ( int r = 0; r < matrix.length; r++ ) {
	    for ( int c = 0; c < matrix[ r ].length; c++ ) {

		if ( matrix[ r ][ c ] != 1 )
		    continue;

		int size = 1;
		boolean ok = true;

		while ( ok
			&& r + size  < matrix.length
			&& c + size < matrix[ r ].length ) {

		    for ( int rr = r; rr <= r + size; rr++ ) {
			if ( ! ok )
			    break;

			for ( int cc = c; cc <= c + size; cc++ ) {
			    if ( matrix[ rr ][ cc ] != 1 ) {
				ok = false;
				break;
			    }
			}
		    }

		    if ( size > max_size )
			max_size = size;

		    size++;
		}
	    }
	}


    	return max_size;
    }
}

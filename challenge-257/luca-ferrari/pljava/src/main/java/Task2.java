package PWC257;

/**
 * PL/Java implementation for PWC 257
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-257>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC257.jar  luca@venkman:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC257.jar', 'PWC257', true );

 select 257.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC257.jar', 'PWC257', true );


Example of invocation:
select pwc257.task2_pljava( array[ 1,0,0,0,1,0,0,0,1 ], 3 );

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

    @Function( schema = "pwc257",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final boolean task2_pljava( int[] matrix, int cols  ) throws SQLException {
	logger.log( Level.INFO, "Entering task2_pljava" );

	boolean ok = false;
	List<Integer> zero_rows = new LinkedList<Integer>();
	Integer current = null;
	List<int[]> leadings = new LinkedList<int[]>();

	for ( int row = 0; row < matrix.length / cols ; row++ ) {
	    current = null;

	    for ( int col = 0; col < cols; col++ ) {

		int element = matrix[ row * cols + col ];
		if ( element == 0 || current != null )
		    continue;

		current = element;
		if ( current != 1 )
		    return false;

		leadings.add( new int[]{ row, col } );

		if ( leadings.size() <= 1 )
		    continue;

		if ( leadings.get( leadings.size() - 2 )[ 0 ] == ( leadings.get( leadings.size() - 1 )[ 0 ] - 1 )
		     && leadings.get( leadings.size() - 2 )[ 1 ] >= leadings.get( leadings.size() - 1 )[ 1 ] )
		    return false;
	    }

	    if ( current == null ) {
		// all zero row
		zero_rows.add( row );

		if ( zero_rows.size() <= 1 )
		    continue;

		if ( zero_rows.get( zero_rows.size() - 2 ) != ( zero_rows.get( zero_rows.size() - 1) - 1 ) )
		    return false;
	    }
	}

	return true;

    }
}

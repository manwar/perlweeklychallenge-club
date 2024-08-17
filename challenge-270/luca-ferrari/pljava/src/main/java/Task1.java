


package PWC270;

/**
 * PL/Java implementation for PWC 270
 * Task 1
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




public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc270",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String[] task1_pljava( int row_size, int[] matrix ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc270.task1_pljava" );

	List<Integer> rows = new LinkedList<Integer>();
	List<Integer> cols = new LinkedList<Integer>();
	List<String> result = new LinkedList<String>();

	// seek for ones
	for( int row = 0; row < ( matrix.length / row_size ) ; row++ )
	    for ( int col = 0; col < row_size; col++ )
		if ( matrix[ row * row_size  + col ] ==  1 ) {
		    rows.add( row  );
		    cols.add( col );
		}

	for ( int i = 0; i < rows.size(); i++ ) {
	    int current_row = rows.get( i );
	    int current_col = rows.get( i );
	    boolean ok      = true;

	    for ( int r = 0; r < rows.size(); r++ )
		if ( r == i )
		    continue;
		else if ( rows.get( r ) == current_row )
		    ok = false;

	    for ( int c = 0; c < cols.size(); c++ )
		if ( c == i )
		    continue;
		else if ( cols.get( c ) == current_col )
		    ok = false;


	    if ( ok )
		result.add( String.format( "Row %d Col %d", current_row, current_col ) );
	}

	String[] to_return = new String[ result.size() ];
	int i = 0;
	for ( String s : result )
	    to_return[ i++ ] = s;

	return to_return;

    }
}

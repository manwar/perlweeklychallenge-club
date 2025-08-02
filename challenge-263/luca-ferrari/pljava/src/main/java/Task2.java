


package PWC263;

/**
 * PL/Java implementation for PWC 263
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-263>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC263-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC263-1.jar', 'PWC263', true );
 select sqlj.set_classpath( 'public', 'PWC263' );

 select pwc263.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC263-1.jar', 'PWC263', true );

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

public class Task2 implements ResultSetProvider {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc263",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final ResultSetProvider task2_pljava( int i[], int j[] ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc263.task2_pljava" );
	return new Task2( i, j );
    }


    Map<Integer, Integer> quantity = new HashMap<Integer, Integer>();
    List<Integer> items = new LinkedList<Integer>();

    public Task2( int[] i, int[] j ) {
	super();

	int index = 0;
	while ( index < i.length ) {
	    int item = i[ index ];
	    int qty  = i[ index + 1 ];
	    quantity.put( i[ index ], i[ index + 1 ] );
	    index += 2;
	}

	index = 0;
	while ( index < j.length ) {
	    int item = j[ index ];
	    int qty  = j[ index + 1 ];
	    if ( quantity.containsKey( item ) )
		qty += quantity.get( item );


	    quantity.put( item, qty );
	    index += 2;
	}

	items.addAll( quantity.keySet() );

    }

    @Override
    public boolean assignRowValues( ResultSet tuples, int row )
	throws SQLException {

	if ( items.isEmpty() || quantity.isEmpty() )
	    return false;

	int item = items.remove( 0 );

	tuples.updateInt( 1, item );
	tuples.updateInt( 2, quantity.get( item ) );
	return true;
    }

    @Override
    public void close() {}
}




package PWC264;

/**
 * PL/Java implementation for PWC 264
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-264>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC264-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC264-1.jar', 'PWC264', true );
 select sqlj.set_classpath( 'public', 'PWC264' );

 select pwc264.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC264-1.jar', 'PWC264', true );

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

    @Function( schema = "pwc264",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int[] task2_pljava( int[] source, int[] indexes ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc264.task2_pljava" );

	List<Integer> target = new LinkedList<Integer>();

	for ( int i = 0; i < indexes.length; i++ ) {
	    int target_index = indexes[ i ];
	    if ( target.isEmpty() ||  target.size() <= target_index )
		target.add( source[ i ] );
	    else {
		List<Integer> replace = new LinkedList<Integer>();
		for ( int ii = 0; ii < target_index; ii++ )
		    replace.add( target.get( ii ) );
		replace.add( source[ i ] );
		for ( int ii = target_index; ii < target.size(); ii++ )
		    replace.add( target.get( ii ) );

		target = replace;
	    }
	}

	int[] result = new int[ target.size() ];
	int k = 0;
	for ( int v : target )
	    result[ k++ ] = v;

	return result;
    }
}

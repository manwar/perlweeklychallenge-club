


package PWC260;

/**
 * PL/Java implementation for PWC 260
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-260>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC260-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC260-1.jar', 'PWC260', true );
 select sqlj.set_classpath( 'public', 'PWC260' );

 select pwc260.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC260-1.jar', 'PWC260', true );

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

    @Function( schema = "pwc260",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final boolean task1_pljava( int[] nums ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc260.task1_pljava" );

	List<Integer> numList = new LinkedList<Integer>();
	for ( int n : nums )
	    numList.add( n );

	Map<Integer, List<Integer>> bag = new HashMap<Integer, List<Integer>>();

	for ( int current : numList ) {
	    int occurrency = Collections.frequency( numList, current );
	    bag.putIfAbsent( occurrency, new LinkedList<Integer>() );
	    if ( ! bag.get( occurrency ).contains( current ) )
		bag.get( occurrency ).add( current );
	}

	for ( int k : bag.keySet() )
	    if ( bag.get( k ).size() > 1 )
		return false;


	return true;

    }
}

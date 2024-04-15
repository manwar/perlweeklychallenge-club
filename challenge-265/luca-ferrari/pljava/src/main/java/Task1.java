


package PWC265;

/**
 * PL/Java implementation for PWC 265
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-265>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC265-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC265-1.jar', 'PWC265', true );
 select sqlj.set_classpath( 'public', 'PWC265' );

 select pwc265.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC265-1.jar', 'PWC265', true );

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

    @Function( schema = "pwc265",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final Integer task1_pljava( int[] nums ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc265.task1_pljava" );

	Map<Integer, Double> pct = new HashMap<Integer, Double>();
	Integer minFound = null;
	for ( int current : nums ) {
	    double value = 1 / ( double ) nums.length;
	    if ( pct.containsKey( current ) )
		value += pct.get( current );

	    pct.put( current, value );

	    if ( value >= 0.33 )
		if ( minFound == null || current < minFound )
		    minFound = current;
	}

	return minFound;
    }
}

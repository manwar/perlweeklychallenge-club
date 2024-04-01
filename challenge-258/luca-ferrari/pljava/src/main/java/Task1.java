package PWC258;

/**
 * PL/Java implementation for PWC 258
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-258>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC258.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC258-1.jar', 'PWC258', true );

 select pwc258.task1_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC258-1.jar', 'PWC258', true );

*/

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.Function;
import static org.postgresql.pljava.annotation.Function.Effects.IMMUTABLE;
import static org.postgresql.pljava.annotation.Function.OnNullInput.RETURNS_NULL;

import java.util.*;
import java.sql.SQLException;
import java.util.logging.*;
import java.sql.ResultSet;
import java.sql.Date;

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc258",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task1_pljava( int nums[] ) throws SQLException {
	logger.log( Level.INFO, "Entering task1_pljava" );

	List<Integer> numbers = new LinkedList<Integer>();
	for ( int current : nums )
	    numbers.add( current );

	int count = numbers.stream().mapToInt( current -> {
		if ( String.format( "%d", current ).length() % 2 == 0 )
		    return 1;
		else
		    return 0;
	    } ).sum();

	return count;
    }
}

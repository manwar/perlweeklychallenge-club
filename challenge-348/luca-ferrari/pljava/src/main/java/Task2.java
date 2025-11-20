


package PWC348;

/**
 * PL/Java implementation for PWC 348
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-348>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC348-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC348-1.jar', 'PWC348', true );
 select sqlj.set_classpath( 'public', 'PWC348' );

 select pwc348.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC348-1.jar', 'PWC348', true );

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

    @Function( schema = "pwc348",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task2_pljava( String source, String target ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc348.task2_pljava" );

	int src_mins = 0;
	int dst_mins = 0;
	int[] multipliers = { 60, 1 };
	List<Integer> operations = new LinkedList<Integer>();

	int index = 0;
	for ( String part : source.split( ":" ) )
	    src_mins += Integer.parseInt( part ) * multipliers[ index++ ];


	index = 0;
	for ( String part : target.split( ":" ) )
	    dst_mins += Integer.parseInt( part ) * multipliers[ index++ ];


	int ops[] = { 60, 15, 10, 5, 1 };
	for ( int op : ops )
	    while ( dst_mins - src_mins >= op ) {
		src_mins += op;
		operations.add( op );
	    }


	return operations.size();

    }
}




package PWC289;

/**
 * PL/Java implementation for PWC 289
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-289>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC289-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC289-1.jar', 'PWC289', true );
 select sqlj.set_classpath( 'public', 'PWC289' );

 select pwc289.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC289-1.jar', 'PWC289', true );

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

    @Function( schema = "pwc289",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task1_pljava( int[] nums ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc289.task1_pljava" );

	List<Integer> sorted = IntStream.of( nums ).boxed().sorted( Collections.reverseOrder() )
	    .collect( Collectors.toList() );


	if ( sorted.size() >= 3 )
	    return sorted.get( 3 );
	else
	    return sorted.get( 0 );

    }
}

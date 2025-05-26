


package PWC323;

/**
 * PL/Java implementation for PWC 323
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-323>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC323-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC323-1.jar', 'PWC323', true );
 select sqlj.set_classpath( 'public', 'PWC323' );

 select pwc323.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC323-1.jar', 'PWC323', true );

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

    @Function( schema = "pwc323",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final float task2_pljava( int income, int[] taxes ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc323.task2_pljava" );

	int last = 0;
	float value = 0;

	for ( int i = 0; i < taxes.length - 1; i++, i++ ) {
	    float pct = taxes[ i + 1 ];
	    int up_to = taxes[ i ];

	    if ( last > up_to )
		continue;

	    value += Math.min( up_to, income ) * pct / 100;
	    last = up_to;
	}

	return value;

    }
}

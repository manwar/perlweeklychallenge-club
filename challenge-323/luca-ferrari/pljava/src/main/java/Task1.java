


package PWC323;

/**
 * PL/Java implementation for PWC 323
 * Task 1
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

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc323",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task1_pljava( String[] operations ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc323.task1_pljava" );

	int value = 0;

	for ( String op : operations ) {
	    if ( op.contains( "++" ) )
		value++;
	    else if ( op.contains( "--" ) )
		value--;
	}

	return value;
    }
}

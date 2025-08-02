


package PWC266;

/**
 * PL/Java implementation for PWC 266
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-266>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC266-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC266-1.jar', 'PWC266', true );
 select sqlj.set_classpath( 'public', 'PWC266' );

 select pwc266.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC266-1.jar', 'PWC266', true );

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

    @Function( schema = "pwc266",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final boolean task2_pljava( int dim, int[] matrix ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc266.task2_pljava" );

	for ( int row = 0; row < dim; row++ ) {
	    for ( int col = 0; col < dim; col++ ) {

		if ( row == col || col == dim - row - 1 ) {
		    if ( matrix[ row * dim + col ] == 0 )
			return false;
		}
		else if ( matrix[ row * dim + col ] != 0 )
		    return false;

	    }
	}

	return true;

    }
}

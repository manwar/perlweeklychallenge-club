


package PWC341;

/**
 * PL/Java implementation for PWC 341
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-341>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC341-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC341-1.jar', 'PWC341', true );
 select sqlj.set_classpath( 'public', 'PWC341' );

 select pwc341.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC341-1.jar', 'PWC341', true );

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

    @Function( schema = "pwc341",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task2_pljava( String word, String prefix ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc341.task2_pljava" );

	int index = word.indexOf( prefix, 1 );
	StringBuilder builder = new StringBuilder();

	builder.append( word.substring( 0, index ) );
	builder.reverse();
	return builder.toString() + word.substring( index + 1 );

    }
}

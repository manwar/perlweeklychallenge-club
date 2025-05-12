


package PWC321;

/**
 * PL/Java implementation for PWC 321
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-321>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC321-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC321-1.jar', 'PWC321', true );
 select sqlj.set_classpath( 'public', 'PWC321' );

 select pwc321.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC321-1.jar', 'PWC321', true );

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

    @Function( schema = "pwc321",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final boolean task2_pljava( String left, String right ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc321.task2_pljava" );

	return left.replaceAll( ".[#]", "" ).equals( right.replaceAll( ".[#]", "" ) );
    }
}

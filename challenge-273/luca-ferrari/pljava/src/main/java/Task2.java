


package PWC273;

/**
 * PL/Java implementation for PWC 273
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-273>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC273-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC273-1.jar', 'PWC273', true );
 select sqlj.set_classpath( 'public', 'PWC273' );

 select pwc273.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC273-1.jar', 'PWC273', true );

*/

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.Function;
import static org.postgresql.pljava.annotation.Function.Effects.IMMUTABLE;
import static org.postgresql.pljava.annotation.Function.OnNullInput.RETURNS_NULL;

import java.util.*;
import java.util.regex.*;
import java.util.stream.*;
import java.sql.SQLException;
import java.util.logging.*;
import java.sql.ResultSet;
import java.sql.Date;

public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc273",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final boolean task2_pljava( String s ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc273.task2_pljava" );

	Pattern p1 = Pattern.compile( "b" );
	Pattern p2 = Pattern.compile( "b.*a" );

	return p1.matcher( s ).find() && ! p2.matcher( s ).find();
    }
}

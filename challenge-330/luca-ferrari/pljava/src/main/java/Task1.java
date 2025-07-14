


package PWC330;

/**
 * PL/Java implementation for PWC 330
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-330>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC330-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC330-1.jar', 'PWC330', true );
 select sqlj.set_classpath( 'public', 'PWC330' );

 select pwc330.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC330-1.jar', 'PWC330', true );

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
import java.util.regex.*;

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc330",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task1_pljava( String string ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc330.task1_pljava" );

	Pattern regexp = Pattern.compile( "([a-z])([0-9])" );
	Matcher engine = regexp.matcher( string );

	while ( engine.find() ) {
	    string = string.replaceAll( engine.group( 1 ) + engine.group( 2 ), "" );
	    engine = regexp.matcher( string );
	}

	return string;

    }
}




package PWC330;

/**
 * PL/Java implementation for PWC 330
 * Task 2
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

public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc330",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task2_pljava( String string ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc330.task2_pljava" );


	return Arrays
	    .stream( string.split( " " ) )
	    .map( word -> word.length() <= 2
		  ? word.toLowerCase()
		  : Character.toTitleCase( word.charAt(0) ) + word.substring( 1 ).toLowerCase() )
	    .collect( Collectors.joining( " " ) );

    }
}

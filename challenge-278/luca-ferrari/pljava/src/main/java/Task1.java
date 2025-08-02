


package PWC278;

/**
 * PL/Java implementation for PWC 278
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-278>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC278-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC278-1.jar', 'PWC278', true );
 select sqlj.set_classpath( 'public', 'PWC278' );

 select pwc278.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC278-1.jar', 'PWC278', true );

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

    @Function( schema = "pwc278",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task1_pljava( String[] words ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc278.task1_pljava" );

	final Map<Integer, String> sorted = new HashMap<Integer, String>();
	Stream.of( words ).forEach( word -> {
		Pattern pattern  = Pattern.compile( "^([a-zA-Z]+)(\\d+)+$" );
		Matcher m = pattern.matcher( word );
		if ( m.matches() ) {
		    sorted.put( Integer.parseInt( m.group( 2 ) ),
				m.group( 1 ) );
		}
	    } );

	return sorted.entrySet().stream()
	    .sorted( Comparator.comparing( Map.Entry::getKey ) )
	    .map( Map.Entry::getValue )
	    .collect( Collectors.joining( " " ) );
    }
}

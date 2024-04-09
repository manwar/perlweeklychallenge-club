


package PWC264;

/**
 * PL/Java implementation for PWC 264
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-264>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC264-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC264-1.jar', 'PWC264', true );
 select sqlj.set_classpath( 'public', 'PWC264' );

 select pwc264.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC264-1.jar', 'PWC264', true );

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

    @Function( schema = "pwc264",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task1_pljava( String string ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc264.task1_pljava" );

	List<String> letters = new LinkedList<String>();
	for ( String l : string.split( "" ) ) {
	    if ( ! l.equals( l.toUpperCase() ) )
		 continue;

	    Pattern regexp = Pattern.compile( l.toLowerCase() );
	    Matcher engine = regexp.matcher( string );
	    if ( ! engine.matches() )
		letters.add( l );
	}

	if ( letters.isEmpty() )
	    return "-";

	Collections.sort( letters );
	return letters.get( letters.size() - 1 );
    }
}

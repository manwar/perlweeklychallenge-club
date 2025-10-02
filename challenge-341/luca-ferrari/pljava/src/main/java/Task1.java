


package PWC341;

/**
 * PL/Java implementation for PWC 341
 * Task 1
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

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc341",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String[] task1_pljava( String sentence, String[] keys ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc341.task1_pljava" );

	List<String> words = new LinkedList<String>();
	for ( String w : sentence.split( "\\s+" ) )
	    words.add( w );

	Iterator<String> iter = words.iterator();
	while ( iter.hasNext() ) {
	    String current_word = iter.next();
	    boolean ok = true;
	    for ( String k : keys )
		if ( current_word.contains( k ) )
		    ok = false;

	    if ( ! ok )
		iter.remove();
	}

	String result[] = new String[ words.size() ];
	int i = 0;
	for ( String w : words )
	    result[ i++ ] = w;

	return result;
    }
}

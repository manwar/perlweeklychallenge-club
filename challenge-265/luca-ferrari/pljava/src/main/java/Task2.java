


package PWC265;

/**
 * PL/Java implementation for PWC 265
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-265>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC265-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC265-1.jar', 'PWC265', true );
 select sqlj.set_classpath( 'public', 'PWC265' );

 select pwc265.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC265-1.jar', 'PWC265', true );

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

    @Function( schema = "pwc265",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task2_pljava( String needle, String[] words ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc265.task2_pljava" );

	Map<Character, Integer> letters = new HashMap<Character, Integer>();
	List<String> found_words = new LinkedList<String>();

	// classify the letters
	for ( Character c : needle.toLowerCase().toCharArray() )
	    if ( Character.isLetter( c ) ) {
		int count = 1;
		if ( letters.containsKey( c ) )
		    count += letters.get( c );

		letters.put( c, count );
	    }

	for ( String current : words ) {
	    int ok = 0;
	    Map<Character, Integer> currentLetters = new HashMap<Character, Integer>();

	    for ( Character c : current.toLowerCase().toCharArray() ) {
		int value = 1;
		if ( currentLetters.containsKey( c ) )
		    value += currentLetters.get( c );

		currentLetters.put( c, value );
	    }

	    for ( Character c : letters.keySet() ) {
		if ( ! currentLetters.containsKey( c )
		     || currentLetters.get( c ) < letters.get( c ) ) {
		    ok = 0;
		    break;
		}
		else
		    ok++;
	    }

	    logger.log( Level.INFO, current + " ===> " + ok );
	    if ( ok == letters.keySet().size() )
		found_words.add( current );
	}

	if ( found_words.isEmpty() )
	    return null;

	Collections.sort( found_words, new Comparator<String>() {
		@Override
		public int compare( String a, String b ) {
		    return a.length() - b.length();
		}
	    } );
	return found_words.get( 0 );
    }
}

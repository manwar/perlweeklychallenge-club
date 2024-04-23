


package PWC266;

/**
 * PL/Java implementation for PWC 266
 * Task 1
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

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc266",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String[] task1_pljava( String left, String right ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc266.task1_pljava" );

	Map<String, Integer> bag_left  = new HashMap<String, Integer>();
	Map<String, Integer> bag_right = new HashMap<String, Integer>();

	classify( bag_left, left );
	classify( bag_right, right );


	List<String> words = deduplicate( bag_left, bag_right );
	String returning[] = new String[ words.size() ];
	int i = 0;
	for ( String word : words )
	    returning[ i++ ] = word;

	return returning;
    }


    private static final List<String> deduplicate( Map<String, Integer> bag_left,
						   Map<String, Integer> bag_right ) {

	List<String> words = new LinkedList<String>();

	for ( String word : bag_left.keySet() ) {
	    if ( bag_left.get( word ) == 1 && ! bag_right.containsKey( word ) )
		words.add( word );
	}

	for ( String word : bag_right.keySet() ) {
	    if ( bag_right.get( word ) == 1 && ! bag_left.containsKey( word ) )
		words.add( word );
	}

	return words;
    }

    private static final void classify( Map<String, Integer> bag, String sentence ) {
	for ( String word : sentence.split( "\\W+" ) ) {
	    word = word.toLowerCase();
	    int count = 1;
	    if ( bag.containsKey( word ) )
		count += bag.get( word );

	    bag.put( word, count );
	}
    }
}

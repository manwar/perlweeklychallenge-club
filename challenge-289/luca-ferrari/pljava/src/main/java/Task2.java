


package PWC289;

/**
 * PL/Java implementation for PWC 289
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-289>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC289-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC289-1.jar', 'PWC289', true );
 select sqlj.set_classpath( 'public', 'PWC289' );

 select pwc289.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC289-1.jar', 'PWC289', true );

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

    @Function( schema = "pwc289",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String[] task2_pljava( String[] words ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc289.task2_pljava" );

	List<String> result = new LinkedList<String>();

	for ( String current : words ) {
	    String[] letters = current.split( "" );


	    int last_index = letters.length - 1;
	    int first_index = 0;

	    Pattern pattern = Pattern.compile( "^[a-z0-9A-Z]$" );


	    while ( ! pattern.matcher( letters[ last_index ] ).find() )
		last_index--;

	    List<String> shuffling = new LinkedList<String>();
	    for ( int i = 1; i < last_index; i++ )
		shuffling.add( letters[ i ] );

	    Collections.shuffle( shuffling );

	    String current_result = letters[ first_index ] + String.join( "", shuffling );
	    for ( int i = last_index; i < letters.length; i++ )
		current_result += letters[ i ];

	    result.add( current_result );
	}

	String[] output = new String[ result.size() ];
	for ( int i = 0; i < output.length; i++ )
	    output[ i ] = result.get( i );

	return output;
    }
}

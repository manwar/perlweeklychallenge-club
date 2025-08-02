package PWC255;

/**
 * PL/Java implementation for PWC 255
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-255>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ $ scp target/PWC253-1.jar  luca@venkman:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC255-1.jar', 'PWC255', true );
 select sqlj.set_classpath( 'public', 'PWC255' );

 select task1_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC255-1.jar', 'PWC255', true );

*/

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.Function;
import static org.postgresql.pljava.annotation.Function.Effects.IMMUTABLE;
import static org.postgresql.pljava.annotation.Function.OnNullInput.RETURNS_NULL;

import java.util.*;
import java.util.stream.*;
import java.sql.SQLException;
import java.util.logging.*;

public class Task2 {
    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( onNullInput = RETURNS_NULL, effects = IMMUTABLE )
    public static final String task2_pljava( String paragraph, String banned ) throws SQLException {
	logger.log( Level.INFO, "Entering task2_pljava" );

	Map<String, Integer> classification = new HashMap<String, Integer>();
	for ( String word : paragraph.split( "\\W+" ) ) {
	    if ( word.equals( banned ) )
		continue;

	    int value = classification.containsKey( word ) ? classification.get( word ) : 0;
	    classification.put( word, ++value );
	}

	String topValue = classification.entrySet()
	    .stream()
	    .sorted( Collections.reverseOrder( Map.Entry.comparingByValue() ) )
	    .findFirst().get().getKey();

	return topValue;
    }
}

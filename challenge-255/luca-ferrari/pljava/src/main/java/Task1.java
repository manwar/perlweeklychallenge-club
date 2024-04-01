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
import java.sql.SQLException;
import java.util.logging.*;

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( onNullInput = RETURNS_NULL, effects = IMMUTABLE )
    public static final String task1_pljava( String origin, String shuffled ) throws SQLException {
	logger.log( Level.INFO, "Entering task1_pljava" );

	if ( origin.length() + 1 != shuffled.length() ) {
	    throw new SQLException( "Shuffled string should be one character longer than the original one" );
	}

	Map<String, Integer> classification = new HashMap<String, Integer>();
	for ( String needle : shuffled.split( "" ) ) {
	    int value = classification.keySet().contains( needle )
		? classification.get( needle )
		: 0;

	    classification.put( needle, ++value );
	}


	for ( String comparison : origin.split( "" ) ) {
	    int value = classification.get( comparison );
	    value--;

	    if ( value > 0 )
		classification.put( comparison, value );
	    else
		classification.remove( comparison );
	}


	return classification.keySet().iterator().next();

    }
}

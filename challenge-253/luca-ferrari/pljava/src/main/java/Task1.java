package PWC253;

/**
 * PL/Java implementation for PWC 253
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-253>
 *
 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC253.1.jar', 'PWC253', true );
 select sqlj.set_classpath( 'public', 'PWC253' );

 select task$tn_pljava();

*/

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.Function;
import static org.postgresql.pljava.annotation.Function.Effects.IMMUTABLE;
import static org.postgresql.pljava.annotation.Function.OnNullInput.RETURNS_NULL;

import java.util.*;
import java.util.logging.*;

public class Task1 {
    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( onNullInput = RETURNS_NULL, effects = IMMUTABLE )
    public static final String[] task1_pljava( String separator, String[] words ) {
	List<String> result = new LinkedList<String>();
	logger.info( "Entering task1_pljava" );
	for ( String w : words ) {
	    if ( ! w.contains( separator ) )
		result.add( w );
	    else
		System.out.println( "SPLITTO " + w );
		for ( String ww : w.split( "[" + separator + "]" ) ) {
		    result.add( ww );
		}
	}

	return result.toArray( new String[ result.size() ] );
    }

    @Function
    public static void logMessage(String logLevel, String message) {
		Logger.getAnonymousLogger().log(Level.parse(logLevel), message);
	}
}




package PWC312;

/**
 * PL/Java implementation for PWC 312
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-312>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC312-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC312-1.jar', 'PWC312', true );
 select sqlj.set_classpath( 'public', 'PWC312' );

 select pwc312.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC312-1.jar', 'PWC312', true );

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

    @Function( schema = "pwc312",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task1_pljava( String typing ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc312.task1_pljava" );

	String alphabet = "abcdefghijklmnopqrstuvwxyz";
	Map<String,Integer> letters = new HashMap<String, Integer>();
	int position = 0;
	int secs = 0;
	int next_position = 0;

	for ( String c : alphabet.split( "" ) )
	    letters.put( c, secs++ );

	secs = 0;

	for ( String current_letter : typing.toLowerCase().split( "" ) ) {
	    next_position = letters.get( current_letter );
	    int clock = Math.abs( next_position - position );
	    int anti = Math.abs( alphabet.length() - next_position - position + 1 );

	    secs += 1 + ( clock > anti ? anti : clock );
	    position = next_position;
	}

	return secs;
    }
}

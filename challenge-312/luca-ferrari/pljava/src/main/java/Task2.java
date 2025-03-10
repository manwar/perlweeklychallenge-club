


package PWC312;

/**
 * PL/Java implementation for PWC 312
 * Task 2
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

public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc312",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task2_pljava( String boxes ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc312.task2_pljava" );

	List<String> data = new LinkedList<String>();
	for ( String c :  boxes.toUpperCase().split( "" ) )
	    data.add( c );

	Map<String, String> found = new HashMap<String, String>();


	while ( data.size() > 0 ) {
	    String color = data.remove( 0 );
	    String box   = data.remove( 0 );


	    found.putIfAbsent( box, "" );
	    found.put( box, found.get( box ) + color );
	}

	int ok = 0;
	for ( String box : found.keySet() ) {
	    if ( found.get( box ).contains( "R" )
		 && found.get( box ).contains( "G" )
		 && found.get( box ).contains( "B" ) )
		ok++;
	}

	return ok;
    }
}

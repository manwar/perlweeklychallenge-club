


package PWC353;

/**
 * PL/Java implementation for PWC 353
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-353>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC353-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC353-1.jar', 'PWC353', true );
 select sqlj.set_classpath( 'public', 'PWC353' );

 select pwc353.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC353-1.jar', 'PWC353', true );

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

    @Function( schema = "pwc353",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final Boolean[] task2_pljava( String codes[],
						String names[],
						String status[] )
	throws SQLException {
	logger.log( Level.INFO, "Entering pwc353.task2_pljava" );

	Boolean result[] = new Boolean[ codes.length ];

	Pattern regex = Pattern.compile( "^[a-z0-9_]+$",
					 Pattern.CASE_INSENSITIVE );


	for ( int i = 0; i < codes.length; i++ ) {
	    	Matcher engine = regex.matcher( codes[ i ] );

		if ( engine.find()
		     && ( names[ i ].equalsIgnoreCase( "electronics" )
			  || names[ i ].equalsIgnoreCase( "grocery" )
			  || names[ i ].equalsIgnoreCase( "pharmacy" )
			  || names[ i ].equalsIgnoreCase( "restaurant" ) )
		     && status[ i ].equalsIgnoreCase( "true" ) )
		    result[ i ] = true;
		else
		    result[ i ] = false;
	}

	return result;
    }
}

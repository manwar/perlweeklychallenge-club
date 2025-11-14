


package PWC347;

/**
 * PL/Java implementation for PWC 347
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-347>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC347-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC347-1.jar', 'PWC347', true );
 select sqlj.set_classpath( 'public', 'PWC347' );

 select pwc347.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC347-1.jar', 'PWC347', true );

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

    @Function( schema = "pwc347",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task2_pljava( String phone ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc347.task2_pljava" );

	phone = phone.replaceAll( "-", "" ).replaceAll( " ", "" );
	List<String> groups = new LinkedList<String>();

	String current = "";
	for( int i = 0; i < phone.length(); i++ ) {
	    current += phone.charAt( i );
	    if ( current.length() % 3 == 0 ) {
		groups.add( current );
		current = "";
	    }
	}

	if ( current.length() > 0 ) {
	    groups.add( current );
	}


	if ( groups.get( groups.size() - 1 ).length() != 2
	     || groups.get( groups.size() - 1 ).length() != 3 ) {

	    String begin = groups.get( groups.size() - 2 );
	    String end   = groups.get( groups.size() - 1 );
	    groups.remove( groups.size() - 1 );
	    groups.remove( groups.size() - 1 );

	    String last = begin + end;

	    groups.add( "" + last.charAt( 0 ) + last.charAt( 1 ) );
	    groups.add( "" + last.charAt( 2 ) + last.charAt( 3 ) );
	}

	String result = "";
	for ( String s : groups ) {
	    result += s + "-";
	}

	return result;
    }
}

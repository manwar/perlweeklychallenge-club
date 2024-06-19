


package PWC273;

/**
 * PL/Java implementation for PWC 273
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-273>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC273-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC273-1.jar', 'PWC273', true );
 select sqlj.set_classpath( 'public', 'PWC273' );

 select pwc273.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC273-1.jar', 'PWC273', true );

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

    @Function( schema = "pwc273",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task1_pljava( String s, String c ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc273.task1_pljava" );

	if ( c.length() != 1 )
	    throw new SQLException( "Need a single char!" );


	final int[] values = new int[]{ 0, 0 };
	values[ 1 ] = s.length();
	Stream.of( s.split( "" ) )
	    .forEach( cc -> {
		if ( cc.equals( c ) )
		     values[ 0 ]++;
	    } );

	return (int) Math.round( (double) values[ 0 ] / values[ 1 ] * 100 );
    }
}

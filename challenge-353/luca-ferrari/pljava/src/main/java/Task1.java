


package PWC353;

/**
 * PL/Java implementation for PWC 353
 * Task 1
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

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc353",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task1_pljava( String[] sentences ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc353.task1_pljava" );

	int max = 0;
	for ( String s : sentences ) {
	    int current = s.split( "\\s+" ).length;
	    if ( current > max )
		max = current;
	}

	return max;
    }
}




package PWC259;

/**
 * PL/Java implementation for PWC 259
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-259>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC259-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC259-1.jar', 'PWC259', true );

 select pwc259.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC259-1.jar', 'PWC259', true );

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

    @Function( schema = "pwc259",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final java.sql.Date task1_pljava( Date startDay, int how_many, Date[] holidays ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc259.task1_pljava" );

	Calendar day = Calendar.getInstance();
	day.setTime( startDay );

	while ( how_many > 0 ) {
	    day.add( Calendar.DAY_OF_YEAR, 1 );

	    while ( day.get( Calendar.DAY_OF_MONTH ) == Calendar.SUNDAY
		    || day.get( Calendar.DAY_OF_MONTH ) == Calendar.SATURDAY )
		day.add( Calendar.DAY_OF_YEAR, 1 );

	    if ( holidays != null )
		for ( Date skip : holidays )
		    if ( skip.equals( day.getTime() ) )
			day.add( Calendar.DAY_OF_YEAR, 1 );

	    how_many--;
	}

	return new java.sql.Date( day.getTimeInMillis() );
    }
}

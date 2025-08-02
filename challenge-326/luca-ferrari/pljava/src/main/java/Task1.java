


package PWC326;

/**
 * PL/Java implementation for PWC 326
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-326>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC326-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC326-1.jar', 'PWC326', true );
 select sqlj.set_classpath( 'public', 'PWC326' );

 select pwc326.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC326-1.jar', 'PWC326', true );

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
import java.time.*;
import java.time.temporal.*;

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc326",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task1_pljava( Date day ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc326.task1_pljava" );

	Calendar end   = Calendar.getInstance();
	end.setTime( day );
	Calendar begin = (Calendar) end.clone();
	begin.set( Calendar.DAY_OF_YEAR, 1 );
	return (int) ( ( end.getTimeInMillis() - begin.getTimeInMillis() ) / ( 1000 * 60 * 60 * 24 ) );
    }
}

package PWC295;

/**
 * PL/Java implementation for PWC 295
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-295>
 *
 *
 * To compile on the local machine:
 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC295-1.jar  luca@rachel:/tmp
 * To install into PostgreSQL execute:
 select sqlj.install_jar( 'file:///tmp/PWC295-1.jar', 'PWC295', true );
 select sqlj.set_classpath( 'public', 'PWC295' );
 select pwc295.task2_pljava();
 and then to redeploy:
 select sqlj.replace_jar( 'file:///tmp/PWC295-1.jar', 'PWC295', true );
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

    @Function( schema = "pwc295",
           onNullInput = RETURNS_NULL,
           effects = IMMUTABLE )
    public static final int task2_pljava( int[] numbers ) throws SQLException {
    logger.log( Level.INFO, "Entering pwc295.task2_pljava" );

    int position = 0;
    int min      = numbers.length + 2;

    for ( int index = 0; index < numbers.length - 1; index++ ) {
        position = index;
        int counter = index;

        while ( position < numbers.length - 1 ) {
    	int jump = numbers[ position ];
    	if ( jump == 0 )
    	    break;

    	position += jump;
    	counter++;
        }

        if ( counter < min && position == numbers.length - 1)
    	min = counter;
    }


    if ( min < numbers.length )
        return min;
    else
        return -1;
    }
}

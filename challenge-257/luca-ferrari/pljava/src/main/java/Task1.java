package PWC257;

/**
 * PL/Java implementation for PWC 257
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-257>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC257.jar  luca@venkman:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC257.jar', 'PWC257', true );

 select 257.task1_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC257.jar', 'PWC257', true );

*/

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.Function;
import static org.postgresql.pljava.annotation.Function.Effects.IMMUTABLE;
import static org.postgresql.pljava.annotation.Function.OnNullInput.RETURNS_NULL;

import org.postgresql.pljava.ResultSetProvider;
import java.sql.ResultSet;

import java.util.*;
import java.sql.SQLException;
import java.util.logging.*;

public class Task1 implements ResultSetProvider {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc257",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final ResultSetProvider task1_pljava( int[] numbers ) throws SQLException {
	logger.log( Level.INFO, "Entering task1_pljava" );
	return new Task1( numbers );

    }

    public Task1( int[] nums ) {
	numbers = nums;
    }

    private int[] numbers;

    @Override
    public boolean assignRowValues(ResultSet receiver, int currentRow)
	throws SQLException {

	if ( currentRow >= numbers.length )
	    return false;

	int current = numbers[ currentRow  ];

	int count = 0;
	for ( int other : numbers )
	    if ( other < current )
		count++;

	receiver.updateInt( 1, count );
	return true;

    }



    @Override
    public void close() { }

}

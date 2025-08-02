


package PWC259;

/**
 * PL/Java implementation for PWC 259
 * Task 2
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
import java.util.regex.*;
import java.util.stream.*;
import java.sql.SQLException;
import java.util.logging.*;
import java.sql.ResultSet;
import java.sql.Date;

public class Task2 implements ResultSetProvider {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc259",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final ResultSetProvider task2_pljava( String line ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc259.task2_pljava : " + line );
	return new Task2( line );
    }


    public Task2( String line ) throws SQLException {
	params = new LinkedList< List<String> >();
	parse( line );
    }


    private final void parse( String line ) throws SQLException {
	Pattern pattern = Pattern.compile( "[{][%] (\\w+)\\s*(.*)\\s* [%][}]" );
	Matcher matcher = pattern.matcher( line );

	if ( matcher.find() ) {
	    id = matcher.group( 1 );

	    Pattern subPattern = Pattern.compile( "(\\w+)[=](\\w+)\\s*" );
	    Matcher subMatch   = subPattern.matcher( matcher.group( 2 ) );

	    while ( subMatch.find() ) {
		List<String> current = new LinkedList<String>();
		current.add( subMatch.group( 1 ) );
		current.add( subMatch.group( 2 ) );
		params.add( current );

	    }
	}
	else
	    throw new SQLException( "Cannot parse " + line );

    }

    private List< List<String> > params;
    private String id;

    @Override
    public boolean assignRowValues(ResultSet rs, int row)
	throws SQLException {

	// stop the result set
	if ( row >= params.size() )
	    return false;

	rs.updateInt( 1, row );
	rs.updateString( 2, id );
	rs.updateString( 3, params.get( row ).get( 0 ) );
	rs.updateString( 4, params.get( row ).get( 1 ) );
	return true;
    }

    @Override
    public void close() {
    }
}

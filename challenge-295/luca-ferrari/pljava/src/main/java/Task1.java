


package PWC295;

/**
 * PL/Java implementation for PWC 295
 * Task 1
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

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc295",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final boolean task1_pljava( String sentence, String[] words ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc295.task1_pljava" );

	for ( String word : words ) {
	    if ( ! sentence.contains( word ) )
		return false;

	    sentence = sentence.replaceAll( word, "" );
	}

	return sentence.length() == 0;
    }
}

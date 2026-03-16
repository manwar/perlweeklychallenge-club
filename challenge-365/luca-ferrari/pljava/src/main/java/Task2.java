


package PWC365;

/**
 * PL/Java implementation for PWC 365
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-365>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC365-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC365-1.jar', 'PWC365', true );
 select sqlj.set_classpath( 'public', 'PWC365' );

 select pwc365.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC365-1.jar', 'PWC365', true );

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

  @Function( schema = "pwc365",
             onNullInput = RETURNS_NULL,
             effects = IMMUTABLE )
  public static final int task2_pljava( String sentence ) throws SQLException {
    logger.log( Level.INFO, "Entering pwc365.task2_pljava" );

    List<String> tokens = new LinkedList<String>();

    for ( String s : sentence.split( "\\s+" ) ) {
      if ( s.matches( ".*\\d+.*" )
           || s.matches( ".*[A-Z]-.*" )
           || s.matches( ".*-[A-Z].*" )
           || s.matches( ".*[!.,].+") )
        continue;

      tokens.add( s );
    }

    return tokens.size();
  }
}

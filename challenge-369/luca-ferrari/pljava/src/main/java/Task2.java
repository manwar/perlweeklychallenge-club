


package PWC369;

/**
 * PL/Java implementation for PWC 369
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-369>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC369-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC369-1.jar', 'PWC369', true );
 select sqlj.set_classpath( 'public', 'PWC369' );

 select pwc369.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC369-1.jar', 'PWC369', true );

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

  @Function( schema = "pwc369",
             onNullInput = RETURNS_NULL,
             effects = IMMUTABLE )
  public static final String[] task2_pljava( String string, int size, String filler ) throws SQLException {
    logger.log( Level.INFO, "Entering pwc369.task2_pljava" );

    List<String> result = new LinkedList<String>();

    while ( string.length() % size != 0 )
      string += filler;

    int index = 0;
    while ( index < string.length() ) {
      result.add( string.substring( index, index + size ) );
      index += size;
    }

    return (String[]) result.toArray( new String[0] );
        
  }
}




package PWC369;

/**
 * PL/Java implementation for PWC 369
 * Task 1
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

import java.util.regex.*;

public class Task1 {

  private final static Logger logger = Logger.getAnonymousLogger();

  @Function( schema = "pwc369",
             onNullInput = RETURNS_NULL,
             effects = IMMUTABLE )
  public static final String task1_pljava( String title ) throws SQLException {
    logger.log( Level.INFO, "Entering pwc369.task1_pljava" );

    String tag = "#";
    String regexp = "[a-zA-Z\\-]+";
    Pattern pattern = Pattern.compile( regexp );
    
    for ( String word : title.split( "\\s+" ) ) {
      Matcher engine = pattern.matcher( word );

      if ( ! engine.matches() )
        continue;
      
      if ( word.contains( "-" ) )
        word = word.replaceAll( "-", "" );
      
      tag += word.substring( 0, 1 ).toUpperCase() + word.substring( 1 ).toLowerCase();
    }

    return tag;
    
  }
}

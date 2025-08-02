


package PWC287;

/**
 * PL/Java implementation for PWC 287
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-287>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC287-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC287-1.jar', 'PWC287', true );
 select sqlj.set_classpath( 'public', 'PWC287' );

 select pwc287.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC287-1.jar', 'PWC287', true );

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
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc287",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final boolean task2_pljava( String number ) throws SQLException {
	Pattern numberRegexp = Pattern.compile( "^[+-]?\\d+([.]\\d+)?(E[+-]?\\d+)?$" );
	return numberRegexp.matcher( number ).find();
    }
}

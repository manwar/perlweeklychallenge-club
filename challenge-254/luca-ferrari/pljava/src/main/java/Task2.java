package PWC254;

/**
 * PL/Java implementation for PWC 254
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-254>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ $ scp target/PWC253-1.jar  luca@venkman:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC254-1.jar', 'PWC254', true );
 select sqlj.set_classpath( 'public', 'PWC254' );

 select task1_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC254-1.jar', 'PWC254', true );

*/

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.Function;
import static org.postgresql.pljava.annotation.Function.Effects.IMMUTABLE;
import static org.postgresql.pljava.annotation.Function.OnNullInput.RETURNS_NULL;

import java.util.*;
import java.sql.SQLException;
import java.util.logging.*;

public class Task2 {
    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( onNullInput = RETURNS_NULL, effects = IMMUTABLE )
    public static final String task2_pljava( String word ) throws SQLException {
	String result = "";
	Stack<String> vowels = new Stack<String>();

	for ( String letter : word.split( "" ) ) {
	    if ( isVowel( letter ) )
		vowels.push( letter );
	}

	for ( String letter : word.split( "" ) ) {
	    if ( ! isVowel( letter ) || vowels.empty() )
		result += letter;
	    else
		result += vowels.pop();
	}

	return result;
    }


	public static final boolean isVowel( String letter ) {
	    return letter.toLowerCase().equals( "a" )
		|| letter.toLowerCase().equals( "e" )
		|| letter.toLowerCase().equals( "i" )
		|| letter.toLowerCase().equals( "o" )
		|| letter.toLowerCase().equals( "u" );
	}
}

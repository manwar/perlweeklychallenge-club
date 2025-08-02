package PWC253;

/**
 * PL/Java implementation for PWC 253
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-253>
 *
 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC253.1.jar', 'PWC253', true );
 select sqlj.set_classpath( 'public', 'PWC253' );

 select task$tn_pljava();

*/

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.Function;
import static org.postgresql.pljava.annotation.Function.Effects.IMMUTABLE;
import static org.postgresql.pljava.annotation.Function.OnNullInput.RETURNS_NULL;

public class Task2 {

       @Function( onNullInput = RETURNS_NULL, effects = IMMUTABLE )
       public static final void task2_pljava() throws Exception {
	   throws Exception( "Not Implemented" );
       }
}

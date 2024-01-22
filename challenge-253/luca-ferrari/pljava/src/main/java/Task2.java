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

import java.util.*;

/*
  example of invocation

  java=# select task2_pljava(  4  , array[
                   [1, 0, 0, 0],
                   [1, 1, 1, 1],
                   [1, 0, 0, 0],
                   [1, 0, 0, 0]
                 ] );
 task2_pljava
--------------
 {0,2,3,1}
(1 row)


*/
public class Task2 {

       @Function( onNullInput = RETURNS_NULL, effects = IMMUTABLE )
       public static final Integer[] task2_pljava( int size, int[] matrix ) throws Exception {
	   int row_index = 0;
	   Map<Integer, List<Integer>> ones = new HashMap<Integer, List<Integer>>();

	   int number_of_ones = 0;

	   for ( int i = 0; i < matrix.length; i++ ) {
	       number_of_ones += matrix[ i ];
	       if ( ( i + 1 ) % size == 0 || i == matrix.length ) {

		   if ( ! ones.containsKey( number_of_ones ) )
		       ones.put( number_of_ones, new LinkedList<Integer>() );

		   ones.get( number_of_ones ).add( row_index++ );
		   number_of_ones = 0;
	       }


	   }

	   List<Integer> keys = new LinkedList<Integer>( ones.keySet() );
	   Collections.sort( keys );

	   List<Integer> result = new LinkedList<Integer>();
	   for ( int k : keys ) {
	       List<Integer> values = ones.get( k );
	       Collections.sort( values );
	       result.addAll( values );
	   }

	   return result.toArray( new Integer[ result.size() ] );
       }
}

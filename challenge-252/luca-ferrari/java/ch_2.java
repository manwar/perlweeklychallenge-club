import java.util.*;

public class ch_2 {
    public static void main( String argv[] ) throws Exception {
	int size = Integer.parseInt( argv[ 0 ] );

	if ( size <= 3 )
	    throw new Exception( "Cannot work with a size less than 3!" );

	List<Integer> nums = new LinkedList<Integer>();


	if ( size % 2 == 0 ) {
	    for ( int i = 1; i < size / 2 ; i++ ) {
		nums.add( i );
		nums.add( i * -1 );
	    }
	}
	else {
	    for ( int i = 1; i < ( size - 1 ) / 2 ; i++ ) {
		nums.add( i );
		nums.add( i * -1 );
	    }

	    int next = ( size - 1 ) / 2 + 1;
	    nums.add( next );
	    nums.add( next + 1 );
	    nums.add( ( next * 2 + 1 ) * -1 );
	}


	boolean printedOne = false;
	for ( int i : nums ) {
	    System.out.print( i + ( printedOne ? ", " : "" ) );
	    printedOne = true;
	}

	System.out.println();
    }
}

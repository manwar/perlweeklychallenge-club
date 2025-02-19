public class Ch1 {
	/**

		Task 1: Min Gap
		Submitted by: Mohammad Sajid Anwar
		You are given an array of integers, @ints, increasing order.
		
		Write a script to return the element before which you find the smallest gap.
		
		Example 1
		Input: @ints = (2, 8, 10, 11, 15)
		Output: 11
		
		 8 - 2  => 6
		10 - 8  => 2
		11 - 10 => 1
		15 - 11 => 4
		
		11 is where we found the min gap.
		Example 2
		Input: @ints = (1, 5, 6, 7, 14)
		Output: 6
		
		 5 - 1 => 4
		 6 - 5 => 1
		 7 - 6 => 1
		14 - 7 => 7
		
		6 and 7 where we found the min gap, so we pick the first instance.
		Example 3
		Input: @ints = (8, 20, 25, 28)
		Output: 28
		
		 8 - 20 => 14
		25 - 20 => 5
		28 - 25 => 3
		
		28 is where we found the min gap.
	 
	 */
	
	public static void main(String[] args) {
		
		test( "Example1", new int[] {2, 8, 10, 11, 15}, 11);
		test( "Example2", new int[] {1, 5, 6, 7, 14}, 6);
		test( "Example3", new int[] {8, 20, 25, 28}, 28);
		test( "Example4", new int[] {1, 2}, 2);

	}

	private static void test(String name, int[] input1, int expectedValue) {
		
		var got = process(input1);
		
		if ( got==expectedValue ) {
			System.out.println("[OK ] " + name);
		}
		else {
			System.out.println("[ERR] " + name + " :: got=" + got + ", expectedValue=" + expectedValue);
		}
		
		
		
	}

	private static int process(int[] input1) {

		int len = input1.length;
		
		int minGap = -1;
		int minGapElement = -1;
		
		for(int i=0; i+1<len; ++i) {
			
			int a = input1[i];
			int b = input1[i+1];
			
			int gap = b - a;
			
			if ( i==0 || gap<minGap ) {
				minGap = gap;
				minGapElement = b;
			}
			
		}
		
		return minGapElement;
	}

}

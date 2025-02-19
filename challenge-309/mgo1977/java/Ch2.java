public class Ch2 {
	/**

		Task 2: Min Diff
		Submitted by: Mohammad Sajid Anwar
		You are given an array of integers, @ints.
		
		Write a script to find the minimum difference between any two elements.
		
		Example 1
		Input: @ints = (1, 5, 8, 9)
		Output: 1
		
		1, 5 => 5 - 1 => 4
		1, 8 => 8 - 1 => 7
		1, 9 => 9 - 1 => 8
		5, 8 => 8 - 5 => 3
		5, 9 => 9 - 5 => 4
		8, 9 => 9 - 8 => 1
		Example 2
		Input: @ints = (9, 4, 1, 7)
		Output: 2
		
		9, 4 => 9 - 4 => 5
		9, 1 => 9 - 1 => 8
		9, 7 => 9 - 7 => 2
		4, 1 => 4 - 1 => 3
		4, 7 => 7 - 4 => 3
		1, 7 => 7 - 1 => 6
	 
	 */
	
	public static void main(String[] args) {
		
		test( "Example1", new int[] {1, 5, 8, 9}, 1);
		test( "Example2", new int[] {9, 4, 1, 7}, 2);

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

		int totalLen = input1.length;
		
		int minDiff = -1;
		
		for(int i=0; i<totalLen; ++i) {
			
			var a = input1[i];
			
			for(int j=i+1; j<totalLen; ++j) {
				
				var b = input1[j];
				
				var diff = Math.abs(a - b);
				
				if ( (minDiff==-1) || diff<minDiff) {
					minDiff = diff;
				}
			}
			
		}
		
		return minDiff;
	}

}

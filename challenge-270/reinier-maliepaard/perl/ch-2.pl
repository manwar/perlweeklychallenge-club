#!/usr/bin/perl
use strict;
use warnings;

=begin

It was fun to think about a solution for TASK #2: Equalize array. 
The result seems unconventional. I tested it with 10 cases (see below) and
used the solution from Packy Anderson to validate my results, 
encountering no issues. However, I don't provide a solid mathematical proof.

My solution is programmatically very straightforward! It demonstrates 
Perl's excellent capability to interchange arrays, strings and numbers. 
Now, let me explain my strategy.

Case 1: array with two elements
Equalizing the array (1 4) to (4 4) involves the following steps 
(notice that not the maximum value -as in Mohammads examples- but 0 is 
my target. So not adding but subtracting. It appears to have advantages: 
see below):

Array: (1 4);
Reverse sorted: (4 1)
Maximum value: 4
New array (except the maximum value) containing differences between the 
maximum value and the original values of the array elements: (3).

Operations with the number 1 as subtrahend:

3 - 1 = 2 (1 × Level 1)
2 - 1 = 1 (1 × Level 1)
1 - 1 = 0, i.e. target 0 found (1 × Level 1)

So there are 3 Level 1 operations needed to equalize the array, i.e. the 
number of Level 1 operations equals the value of the array element. To 
determine the total cost, we need to multiply by the cost variables $x: 
(1 Level 1 operation * $x).

Case 2a: array with more than two elements
Let's consider an array with more than two elements, for example, the 
array (1 3 2). We use 11 as subtrahend, simulating a Level 2 operation 
if @new_arr contains only single digits. Here are the steps I follow:

Array: (1 3 2);
Reverse sorted: (3 2 1)
Maximum value: 3
New array (except the maximum value) containing differences between the 
maximum value and the original values of the array elements: (1 2).

This array can be transformed into the number 12. We can simulate Level 2 
operations by using the number 11 as subtrahend. My assumption here is 
that normal subtraction is the most efficient method to find the lowest 
cost solution, but I could be completely wrong. Again, I must leave you 
without a solid mathematical proof.

Operations:

12 - 11 = 1 (1 × Level 2)
1 - 1 = 0 i.e. target 0 found (1 × Level 1)

To determine the total cost, we need to multiply by the cost variables 
$x and $y: (1 Level 2 operation * $y) + (1 Level 1 operation * $x).

Case 2b: array with more than two elements
Here's another example to show how to handle the number 0, which indicates 
that the difference to the maximum value has been reached. We use 11 as 
subtrahend, simulating a Level 2 operation if @new_arr contains only single digits.

Array: (2 3 3 3 5);
Reverse sorted: (5 3 3 3 2)
Maximum value: 5
New array (except the maximum value) containing differences between the 
maximum value and the original values of the array elements: (2 2 2 3).
Conversion: number to work with is 2223

Operations:

2223 - 11 = 2212 (1 x Level 2)
2212 - 11 = 2201 (1 x Level 2)
Now we remove the value 0 (target 0 found) -> 221
221 - 11 = 210 (1 x Level 2)
Now we remove the value 0 -> 21
21 - 11 = 10 (1 x Level 2)
Now we remove the value 0 -> 1
1 < 11 so 1 refers to 1 Level 1 operation.
So 4 Level 2 operations and 1 Level 1 operation.

To determine the total cost, we need to multiply by the cost variables 
$x and $y: (4 Level 2 operation * $y) + (1 Level 1 operation * $x).

Case 3: array with special distribution
We need 101 as subtrahend, simulating a Level 2 operation if @new_arr 
contains one or more double digits. Thanks to Bob Lied and Packy Anderson 
who inspired me to adapt my first version. Status now: the results of my 
method are the same as Packy Anderson's algorithm produces. Example:

Array: (1 1 12);
Reverse sorted: (12 1 1)
Maximum value: 12
New array (except the maximum value) containing differences between the maximum value and the original values of the array elements: (11 11).
If we'll simulate L2 operations we need another substrahend: instead of 11, we need 101
Conversion: number to work with is 1111
Operations: substract 101
1111
1010
909
808
707
606
505
404
303
202
101
0 => 11 x L2
=cut

sub equalize_array {

    Notice: assumption the maximum value may not change
    Notice: not implemented the case that $x * 2 < $y    
	
    # $x and $y are cost variables
    my ($arr_orig_ref, $x, $y) = @_;	
    
    my @arr_orig = @$arr_orig_ref;
    
    # sort array in descending order
    my @arr_orig_sorted = (sort {$b <=> $a} @arr_orig);

    # now the first element has the maximum value
    my $max = $arr_orig_sorted[0];

    # remove the first value, i.e. the maximum value
    shift(@arr_orig_sorted);

    # create a new array where each element is the result of subtracting
    the original value from the maximum value in @arr_orig
    my @new_arr = map { $max - $_ } @arr_orig_sorted;	
    
    # $L1 refers to Level 1 and $L2 to Level 2
    # Example: there were two Level 2 operations if $L2 equals 2 etc.
    my $L1 = 0;
    my $L2 = 0;

    # the simplest case where the number of Level 1 operations equals the value of array element
    # see Example 1 below: it takes 4 minus 1 Level 1 operations to equalize the array.

    if ($x > 0) {    
	
        if (scalar(@new_arr) == 0) {
            return (0);			
	    }		
    
        if (scalar(@new_arr) == 1) {

            $L1 = $new_arr[0];
            return ($L1 * $x);           
        }
        # using the number trick
        if ( (scalar(@new_arr) > 1) ) {    

            # create a number from @new_arr
            my $no = join ("", @new_arr);

            # number 11 as subtrahend, simulating a Level 2 operation if @new_arr contains single digits
            # number 101 as subtrahend, simulating a Level 2 operation if @new_arr contains one or more double digits        

            my $substrahend;
            $substrahend = 11 if( grep { length($_) == 1 } @new_arr );
            $substrahend = 101 if( grep { length($_) == 2 } @new_arr );
        
            while ($no >= $substrahend) {
                $no -= $substrahend;      	 
                $L2++;
                # remove 0 from $no; 0 means 'target found'            
                $no =~ s/0//g if( index ($no, '0') && $substrahend == 11); 
            }
        
            $L1 = $no if ($no != 0);   
        
            ($L1 != 0) ? (return ( ($L1 * $x) + ($L2 * $y) )) : (return ($L2 * $y));
        }  
    } 
    else {
       return (0);	
    }	
}

# TESTS

my (@arr, $x, $y);

@arr = qw(4 1);
$x = 3;
$y = 2;
print("Total cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output: 9

@arr = qw(2 3 3 3 5);
$x = 2;
$y = 1;
print("Total cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output: 6

@arr = qw(4 2 1);
$x = 2;
$y = 1;
print("Total cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output: 4

@arr = qw(5 4 3 2 1);
$x = 2;
$y = 1;
print("Total cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output: 5

@arr = qw(22 1);
$x = 2;
$y = 1;
print("Total cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output: 42

@arr = qw(4 2 2 1);
$x = 2;
$y = 1;
print("Total cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output: 5

@arr = qw(3 2 1);
$x = 2;
$y = 1;
print("Total cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output: 3

@arr = qw(5 3 1);
$x = 2;
$y = 1;
print("Total cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output: 6

@arr = qw(3 2 2 1);
$x = 2;
$y = 1;
print("Total cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output: 2

@arr = qw(20 19 18);
$x = 2;
$y = 1;
print("TOTAL cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output 3

@arr = qw(12 9 8);
$x = 2;
$y = 1;
print("TOTAL cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output 5

@arr = qw(12 11 8);
$x = 2;
$y = 1;
print("TOTAL cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output 7

@arr = qw(20 2 1);
$x = 2;
$y = 1;
print("TOTAL cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output 20

@arr = qw(12 1 1);
$x = 2;
$y = 1;
print("TOTAL cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output 11

# 4 test cases Athanasius
@arr = qw(4 4 4 4);
$x = 2;
$y = 1;
print("TOTAL cost : ", equalize_array(\@arr, $x, $y), "\n"); ## Output: 0

@arr = qw(2 3 3 3 5);
$x = 7;
$y = 0;
print("TOTAL cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output: 7

@arr = qw(2 3 3 3 5);
$x = 0;
$y = 1;
print("TOTAL cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output: 0

@arr = qw(17);
$x = 3;
$y = 2;
print("TOTAL cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output: 0

# 1 test case Niels van Dijke 
@arr = qw(3 3 4 4);
$x = 1;
$y = 2;
print("Total cost : ", equalize_array(\@arr, $x, $y), "\n"); # Output: 2

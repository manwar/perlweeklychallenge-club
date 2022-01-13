## user input should be binary numbers(1,0)
## Find the lenght of two input numbers and traverse from LSB
## ## intially carry =0  
## sum =  carry+ n1+n2; 
## when we add the numbers sum possiblity is {3,2,0,1} then set the carry if sum is greater than 1; if we use modulse we can find the actuall result of sum
## if sum is 3 -> 1(actual result)
## if sum is 2 -> 0
## if sum is 1 -> 1
## if sum is 0 -> 0


use strict;
use warnings;


my($input1,$input2,$i,$j,$result,$carry,$sum);
$carry = 0; $sum =0, $result='';

L1 : print "Enter the First Binary Number [0's and 1's only]\n";
     $input1 = <>;
	 chomp($input1);
	 goto L1 if ($input1 !~ m/^[0-1]+$/s);
L2 : print "Enter the Second Binary Number [0's and 1's only]\n";
     $input2 = <>;
	 chomp($input2);
	 goto L2 if ($input2 !~ m/^[0-1]+$/s);

chomp $input1; chomp $input2;

$i = length($input1);
$j = length($input2);

while( $i>0 || $j>0)
{
	$sum = $carry;
	$sum += (substr($input1, $i-1, 1)) if ($i >0); # operator overloading
	$sum += (substr($input2, $j-1, 1)) if ($j >0); # operator overloading
	$carry = $sum > 1 ? 1 : 0 ;	
	$result .= $sum%2;	# operator overloading
	$i--; $j--;
}
$result .= $carry if ($carry); 

print (scalar reverse($result));


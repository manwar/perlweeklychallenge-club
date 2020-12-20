=begin

    TASK #2 › Jump Game
    Submitted by: Mohammad S Anwar
    You are given an array of positive numbers @N, where value at each index determines how far you are allowed to jump further.
    
    Write a script to decide if you can jump to the last index. Print 1 if you are able to reach the last index otherwise 0.
    
    Example 1:
    Input: @N = (1, 2, 1, 2)
    Output: 1
    
    as we jump one place from index 0 and then twoe places from index 1 to reach the last index.
    Example 2:
    Input: @N = (2,1,1,0,2)
    Output: 0
    
    it is impossible to reach the last index. as we jump two places from index 0 to reach index 2, 
    followed by one place jump from index 2 to reach the index 3. once you reached the index 3, 
    you can't go any further because you can only jump 0 position further.

=end
=cut


use strict;
use warnings;
use Data::Dumper;

my @N = (1, 2, 1, 2);
my $i = 0;
my $position = 0;

while ($i < @N && $i != @N - 1 and $N[$i] != 0){
    $position = $N[$i];
    $i = $position + $i;
}
if ($i == @N - 1) {
    print "Output: 1\n";
}
else {
    print "Output: 0\n";
}






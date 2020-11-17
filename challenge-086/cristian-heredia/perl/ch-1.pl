=begin
    TASK #1 › Pair Difference
    Submitted by: Mohammad S Anwar
    You are given an array of integers @N and an integer $A.
    
    Write a script to find find if there exists a pair of elements in the array whose difference is $A.
    
    Print 1 if exists otherwise 0.
    
    Example 1:
    Input: @N = (10, 8, 12, 15, 5) and $A = 7
    Output: 1 as 15 - 8 = 7
    Example 2:
    Input: @N = (1, 5, 2, 9, 7) and $A = 6
    Output: 1 as 7 - 1 = 6
    Example 3:
    Input: @N = (10, 30, 20, 50, 40) and $A = 15
    Output: 0
=end
=cut

my @N = (10, 8, 12, 15, 5);
my $A = 7;
my $result ;

foreach (my $i=0; $i<@N;$i++) {
    foreach (my $j=0; $j<@N;$j++) {
        if($i != $j) {
            $result = $N[$i] -$N[$j];
            if ($result == $A) {
                print"Output: 1 as $N[$i] - $N[$j]  = $A\n";
                exit;
            }
        }
    }
}
print"Output: 0\n";








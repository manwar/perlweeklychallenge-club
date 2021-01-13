=begin
    TASK #2 › Power of Two Integers
    Submitted by: Mohammad S Anwar
    You are given a positive integer $N.
    
    Write a script to find if it can be expressed as a ** b where a > 0 and b > 1. Print 1 if you succeed otherwise 0.
    
    Example 1:
    Input: 8
    Output: 1 as 8 = 2 ** 3
    Example 2:
    Input: 15
    Output: 0
    Example 3:
    Input: 125
    Output: 1 as 125 = 5 ** 3
=end
=cut

my $N = 125;
my $result;
my $final = 0;

calculateResult();

sub calculateResult {
    
    foreach(my $a = 1; $a < $N; $a++) {
        foreach(my $b = 2; $b < $N; $b++) {
            if ($final == 0) {
                $result  = $a ** $b;
                    if ($result == $N) {
                        $final = 1;
                        print "Output: 1 as $N = $a ** $b\n";       
                    }
            }
        }
    }
    if  ($final == 0) {
        print "Output: 0\n";
    }
}

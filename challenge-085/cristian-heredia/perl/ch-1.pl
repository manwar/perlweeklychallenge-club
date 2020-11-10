=begin
    TASK #1 › Triplet Sum
    Submitted by: Mohammad S Anwar
    You are given an array of real numbers greater than zero.
    
    Write a script to find if there exists a triplet (a,b,c) such that 1 < a+b+c < 2. Print 1 if you succeed otherwise 0.
    
    Example 1:
    Input: @R = (1.2, 0.4, 0.1, 2.5)
    Output: 1 as 1 < 1.2 + 0.4 + 0.1 < 2
    Example 2:
    Input: @R = (0.2, 1.5, 0.9, 1.1)
    Output: 0
    Example 3:
    Input: @R = (0.5, 1.1, 0.3, 0.7)
    Output: 1 as 1 < 0.5 + 1.1 + 0.3 < 2
=end
=cut

my @R = (0.5, 1.1, 0.3, 0.7);
my $result = 0;

foreach (my $i = 0; $i<@R; $i++) {
        if ($R[$i] < 2 ) {
            foreach (my $j = 0; $j<@R; $j++)  {
                if ($i != $j and ($R[$i] + $R[$i] < 2) ) {
                    foreach (my $k = 0; $k<@R; $k++) {
                        if ($i != $k and $j != $k and ($R[$i] + $R[$j] +  $R[$k] < 2) and $result  == 0 ) {
                            $result  = 1;
                            print "Output: 1 as 1 < $R[$i]+ $R[$j] + $R[$k] < 2\n";
                        }
                    }
                }
            }
        }
}
if ($result  == 0) {
    print "Output: 0\n";
}

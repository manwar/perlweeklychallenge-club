#!env raku
#
# You are given a binary number B,
# consisting of N binary digits 0 or 1: s0, s1, …, s(N-1).
# Choose two indices L and R such that 0 ≤ L ≤ R < N
# and flip the digits s(L), s(L+1), …, s(R).
# By flipping, we mean change 0 to 1 and vice-versa.
#
# For example, given the binary number 010,
# the possible flip pair results are listed below:
#
#    L=0, R=0 the result binary: 110
#    L=0, R=1 the result binary: 100
#    L=0, R=2 the result binary: 101
#    L=1, R=1 the result binary: 000
#    L=1, R=2 the result binary: 001
#    L=2, R=2 the result binary: 011
#
# Write a script to find the indices (L,R)
# that results in a binary number with maximum number of 1s.
# If you find more than one maximal pair L,R then print all of them.
# 
# Continuing our example, note that we had three pairs
# (L=0, R=0), (L=0, R=2), and (L=2, R=2) that resulted
# in a binary number with two 1s, which was the maximum.
# So we would print all three pairs.


sub MAIN( Int:D $number where { $number.chars > 1 && $number ~~ / ^ <[01]>+ $ / } ) {
    say "Number $number";

    my @src = $number.comb;
    my $N = @src.elems;

    my $wanted =  $N - 1;
    say "Searching for at least $wanted ones...";
    
    for 0 ..^ $N -> $L {
        my @working = @src;
        @working[ $L ] = @working[ $L ] == 1 ?? 0 !! 1;
       
        for $L  ..^ $N -> $R {
            @working[ $R ] = @working[ $R ] == 1 ?? 0 !! 1 if ( $L != $R );
            say "Found { @working } with L = $L and R = $R" if @working.grep(  * == 1  ).elems >= $wanted;
        }
        
        
    }
}

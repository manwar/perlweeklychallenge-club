use v6;


#Flip Binary

#You are given a binary number B, consisting of N binary digits 0 or 1: s0, s1, …, s(N-1).

#Choose two indices L and R such that 0 ≤ L ≤ R < N and flip the digits s(L), s(L+1), …, s(R).
# By flipping, we mean change 0 to 1 and vice-versa.

#For example, given the binary number 010, the possible flip pair results are listed below:

#L=0, R=0 the result binary: 110
#L=0, R=1 the result binary: 100
#L=0, R=2 the result binary: 101
#L=1, R=1 the result binary: 000
#L=1, R=2 the result binary: 001
#L=2, R=2 the result binary: 011

#Write a script to find the indices (L,R) that results in a binary number with maximum number of 1s. 
#If you find more than one maximal pair L,R then print all of them.

#Continuing our example, note that we had three pairs (L=0, R=0), (L=0, R=2), and (L=2, R=2) 
#that resulted in a binary number with two 1s, which was the maximum. So we would print all three pairs.


sub MAIN (Int:D $binaryNumber where { $binaryNumber ~~ m/^<[01]>+$/ } ) {
    say "Binary Number: $binaryNumber";
    
    my @aResults = ();
    my $n = $binaryNumber.chars;
    for (0..$n-1) -> $leftIndex {
        for  ($leftIndex..$n-1) -> $rightIndex {
            my @aDigits  = $binaryNumber.split( '' );
            @aDigits.pop();
            @aDigits.shift();
            @aDigits =  flipBetween( @aDigits ,$leftIndex , $rightIndex) ;
            @aResults.push: {'L' => $leftIndex, 'R' => $rightIndex , 'B' =>  @aDigits.join('') ,'1' =>  @aDigits.grep({$_ eq 1}).elems} ;
        }
    }
    
    my $maxNumberOnes ;
    for  @aResults.sort({$^b.{1} <=> $^a.{1}} ) -> $result {
        if ($maxNumberOnes.defined && $maxNumberOnes > $result.{'1'} ) {
            last;
        }
        $maxNumberOnes  = $result.{'1'};   
        say "L="~$result.{'L'}~", R="~$result.{'R'}~", binary: "~$result.{'B'}~",  "~$result.{'1'}~" 1s";
    }
}

sub flipBetween (@aDigits, Int:D $left, Int:D $right ) { 
    my @aFlippedDigits = @aDigits;
    for 0..@aFlippedDigits.end {
        if  $_ >= $left && $_ <= $right  {
            @aFlippedDigits[$_]  = @aFlippedDigits[$_] == 1 ?? 0 !! 1;
        }
    }
    return @aFlippedDigits;
}


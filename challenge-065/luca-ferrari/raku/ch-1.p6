#!raku

# You are given two positive numbers $N and $S.
#
# Write a script to list all positive numbers having
# exactly $N digits where sum of all digits equals to $S.
# Example
#
# Input:
# $N = 2
#  $S = 4
#
#  Output:
# 13, 22, 31, 40



sub MAIN( Int $N where { $N > 0 },
          Int $S where { $S >= 1 && $S <= 9 } ) {


    my @found;
    "Searching numbers with $N digits that sum to $S between { 1 ~ ( 0 x $N - 1 ) } and { $S ~ ( 0 x $N - 1 ) }".say;
    for ( 1 ~ ( 0 x $N - 1 ) ).Int .. ( $S ~ ( 0 x $N - 1 ) ).Int {
        @found.push: $_ if ( [+] $_.split( '', :skip-empty ) ) == $S ;
    }

    @found.say;

}

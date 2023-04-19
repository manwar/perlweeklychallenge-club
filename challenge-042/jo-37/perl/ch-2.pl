#!/usr/bin/perl -s

use strict;
use warnings;

use constant MAX_B => 5;

die <<EOS unless @ARGV == 1;
usage: $0 N

N
    generate N random bracket strings, each having a size of 2, 4, 6, 8
    or 10.  Then check for balanced brackets.

EOS


### Input and Output

for (1 .. shift) {
    my $brackets = gen_brackets();
    printf "%-10s - %sOK\n", $brackets, 'NOT ' x !check_brackets($brackets);
}


### Implementation

sub gen_brackets {
    # Generate even sized strings only.
    my $len = 2 * (1 + int rand MAX_B);
    # First generate a number having the required number of bits.  Then
    # translate the bits to brackets.
    sprintf('%0*b', $len, int rand 2 ** $len) =~ tr/01/()/r;
}

sub check_brackets {
    shift =~ m{
        ^               # anchor start
        (               # capture subexpression
            (?:         # non-capturing group
                \(      # opening bracket
                (?-1)   # balanced subgroup: recursive regex
                \)      # closing bracket
            )*          # repeated bracket embraced balanced group
        )
        $               # anchor end
    }x;
}

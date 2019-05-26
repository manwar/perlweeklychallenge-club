# Write a script to perform different types of ranking as described below:

# 1. Standard Ranking (1224): Items that compare equal receive the same ranking number, and then a gap is left in the ranking numbers.
# 2. Modified Ranking (1334): It is done by leaving the gaps in the ranking numbers before the sets of equal-ranking items.
# 3. Dense Ranking    (1223): Items that compare equally receive the same ranking number, and the next item(s) receive the immediately following ranking number.

use strict;
use warnings;
use v5.10;

# proposed solution is a function "rank" that will take as arguments:
# 1st argument is an "order" value, with values -1 for descending order, or 1 for ascending order
# 2nd argument is a "mode" argumente, with values 1, 2 or 3 according to the type or ranking proposed
# in the challenge.
# Starting from 3rd argument on, is an array of hashes. Each hash has a "score" key,
# that should be numeric (integer or float), and is used to sort the array.
# The hashes can have other keys, not affected by the function
# Example input:
#
# my @result = rank(
#     -1, 2,
#     { score => 8, name => 'foo' },
#     { score => 7, name => 'bar' },
#     { score => 8, name => 'baz' },
#     { score => 10, name => 'best' }
# );
#
# result will be an array of the same hashes, with each one with an additional key "rank",
# ordered according to the first two arguments
#

sub rank {
    my ( $order, $mode, @inp ) = @_;

  # first we order @inp by "score" key, taking into account the "order" argument
    @inp = sort { $a->{score} * $order <=> $b->{score} * $order } @inp;

    # now we add the key "rank", according to the $mode argument
    if ( $mode == 1 ) {

# standard ranking, we just copy index of the array (+1) for scores different from former score
#
        $inp[0]{rank} = 1;
        for my $i ( 1 .. $#inp ) {
            if ( $inp[$i]{score} == $inp[ $i - 1 ]{score} ) {
                $inp[$i]{rank} = $inp[ $i - 1 ]{rank};
            }
            else { $inp[$i]{rank} = $i + 1 }
        }
    }
    elsif ( $mode == 2 ) {

     # modified ranking, the opossite of the standard for equally ranked entries
     #
        $inp[-1]{rank} = @inp;
        for my $i ( reverse 0 .. $#inp - 1 ) {
            if ( $inp[$i]{score} == $inp[ $i + 1 ]{score} ) {
                $inp[$i]{rank} = $inp[ $i + 1 ]{rank};
            }
            else { $inp[$i]{rank} = $i + 1 }
        }
    }
    elsif ( $mode == 3 ) {

        # dense ranking, similar to standard
        #
        $inp[0]{rank} = 1;
        for my $i ( 1 .. $#inp ) {
            if ( $inp[$i]{score} == $inp[ $i - 1 ]{score} ) {
                $inp[$i]{rank} = $inp[ $i - 1 ]{rank};
            }
            else { $inp[$i]{rank} = $inp[ $i - 1 ]{rank} + 1 }
        }
    }
    return @inp;
}

sub print_ranking {
    say "Rank\tScore\tName";
    say sprintf( "%s\t%s\t%s", $_->{rank} // 'N/A', $_->{score}, $_->{name} )
      for @_;
    say "";
}

# now prints 3 examples

my @input = (
    { score => 8,  name => 'foo' },
    { score => 7,  name => 'bar' },
    { score => 8,  name => 'baz' },
    { score => 10, name => 'best' }
);

say "First example, standard ranking";
print_ranking(rank(-1,1, @input));
say "Second example, modified ranking";
print_ranking(rank(-1,2, @input));
say "Second example, dense ranking";
print_ranking(rank(-1,3, @input));

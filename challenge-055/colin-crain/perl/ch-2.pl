#! /opt/local/bin/perl
#
#       waves.pl
#
#         55 - TASK #2
#         Wave Array
#             Any array N of non-unique, unsorted integers can be arranged into
#             a wave-like array such that n1 ≥ n2 ≤ n3 ≥ n4 ≤ n5 and so on.
#
#             For example, given the array [1, 2, 3, 4], possible wave arrays
#             include [2, 1, 4, 3] or [4, 1, 3, 2], since 2 ≥ 1 ≤ 4 ≥ 3 and 4 ≥
#             1 ≤ 3 ≥ 2. This is not a complete list.
#
#             Write a script to print all possible wave arrays for an integer
#             array N of arbitrary length.
#
#             Notes: When considering N of any length, note that the first
#             element is always greater than or equal to the second, and then
#             the ≤, ≥, ≤, … sequence alternates until the end of the array.
#
#         method: A wave sequence can be considered a special case of
#             permutation, with the valid arrangements restricted by the greater
#             than / less than cycle. As such it makes sense to proceed like a
#             permutation generator, with the addition that we immediately throw
#             out cases as they are formed when the next digit cannot fit the
#             requirements.

#             The recursive function
#
#                 wave_at_yourself(\@set, \@working, $waves, $direction)
#
#             takes a set of remaining possible list values, a working list
#             under construction, an array holding references to completed wave
#             sequences and a direction flag that toggles every recursion.
#
#             With each instantation we toggle the direction, refer to the last
#             number placed on the working array and construct a subset of
#             values either less than or greater than (or equal to) the previous
#             value, as directed. For each of the possible next values in the
#             subset, new sets are made moving the value from the possible
#             values set to the working set and the function is called again
#             using these. If at any time the subset has no values but we are
#             not finished we have reached a contradiction and we return empty
#             handed. If both the larger set and the subset each only have one
#             value we have succesfully allocated our elements accoring to the
#             rules and have completed a wave.
#
#             Between iterating over only the values greater or less than the
#             previous and pruning the tree early when we cannot continue, the
#             search space looking for valid solutions is greatly reduced as
#             compared to a simple permutation recursion.
#
#             In permutation theory the actual values are not relevant, so a
#             sequence of integers ( 1, 2, 3, 4, 5...) is substituted instead.
#             So if we give a single arguant of the command line, it computes on
#             an array of that length. Default is 5. Passing any arbitrary array
#             of integers works as expected.
#

#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my @input_array = sort {$a <=> $b} @ARGV;
my $array_length = scalar $ARGV[0] // 5;
@input_array = (1..$array_length) if scalar @ARGV < 2;


my @working;
my $waves     = [];
my $direction = 0;

# wave_at_yourself( \@set, \@working, $waves, $direction);
wave_at_yourself( \@input_array, \@working, $waves, $direction);

say '[ ', (join ', ', $_->@*), ' ]' for $waves->@*;

## ## ## ## ## SUBS:


sub wave_at_yourself {
## given a starting set, a working list and a waves set
## computes complete waves as arrays and places the arrays on the waves array
## which is maintained throughout by reference
## $direction: 1 => gt, 0 => lt
    my ($setref, $workref, $waves, $direction) = @_;
    my @set    = $setref->@*;

    ## toggle direction every recursion
    $direction ^= 1;

    ## the subset is those elements that are either greater or equal to or less
    ## than or equal to the previous element as selected by the direction.

    ## if the subset size is 0 we cannot continue and bail without adding to the
    ## waves array
    my $prev = $workref->[-1];
    my @subset = defined $prev ? grep { $direction ? $_ >= $prev : $_ <= $prev } @set : @set;
#     return if scalar @subset == 0;
    if (scalar @subset == 0) {
# say join ' -> ', $workref->@*;
        return;
    }


    ## if there is only one element left in both the set and the subset,
    ## then we have successfully made a wave.
    ## we push it onto the working list,
    ## push that array reference onto the waves array and return.
    ## This unique wave is complete.
    if ( scalar @set == 1 && scalar @subset == 1 ) {
        my @working = $workref->@*;
        push @working,      $set[0];
        push $waves->@*,  \@working;

#  say join ' -> ', @working;

        return;
    }

    ## iterate through the remaining elements of the set,
    ## creating  new copy of the working list, moving the element
    ## from the set to the working list and recursing with these
    ## new lists. The waves list reference is passed through unchanged.
    for my $element ( @subset ) {

        my @working = $workref->@*;
        push @working, $element;
        my @set_minus_one = grep { $_ != $element } @set;
        wave_at_yourself( \@set_minus_one, \@working, $waves, $direction );
    }
}


#!/opt/local/bin/perl
#
#       triple_combo.pl
#
#         TASK #1 › Triplet Sum
#         Submitted by: Mohammad S Anwar
#         You are given an array of real numbers greater than zero.
#
#         Write a script to find if there exists a triplet (a,b,c) such that
#         1 < a+b+c < 2. Print 1 if you succeed otherwise 0.
#
#         Example 1:
#             Input: @R = (1.2, 0.4, 0.1, 2.5)
#             Output: 1 as 1 < 1.2 + 0.4 + 0.1 < 2
#
#         Example 2:
#             Input: @R = (0.2, 1.5, 0.9, 1.1)
#             Output: 0
#
#         Example 3:
#             Input: @R = (0.5, 1.1, 0.3, 0.7)
#             Output: 1 as 1 < 0.5 + 1.1 + 0.3 < 2
#
#         method:
#             another combinations task, but limited to sets of three members, n
#             choose 3. Rather that reach of a module, this time we'll just roll
#             up a combinations generator. It's generic and returns arrays of
#             indices rather than the actual selected array elements, so that
#             substitution takes place in the body of the routine.
#
#             The combination sums are computed and verified immediately against
#             the conditional, and any that pass the test cause the program to
#             print a positive outcome and exit.
#
#             We do not need to know the specific combination that summed to
#             within the range, nor whether there was more than one possible
#             such sequence. One is all that is needed to prove existence.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

@ARGV == 0 and @ARGV = (1.2, 0.4, 0.1, 2.5);
my @arr = @ARGV;

my @index_combos = combinations( scalar( @arr ), 3 )->@* ;

for (@index_combos) {
    my $sum = 0;
    for my $idx ($_->@*) {
        $sum += $arr[$idx];
    }
    if (1 < $sum && $sum < 2 ) {
        print 1;
        exit;
    }
}
print 0;



## ## ## ## ## SUBS:

sub combinations {
## returns an array of array combinations from a sequence
## of natural numbers starting at 0
## we select $num_elems items from a list of $length items
    my ($length, $num_elems, $list) = (@_, [[]]);
    return $list if $list->[0]->@* == $num_elems;

    my @newlist = ();
    my $pos = $list->[0]->@*;          ## this position, num_elems of prev list + 1

    for my $combo ( $list->@* ) {
        my $start = $combo->[-1] // -1 ;          ## value of last elem in list + 1
        my $end   = $length - $num_elems + $pos;  ## max - length + position

        push @newlist, [ $combo->@*, $_ ] for (++$start .. $end );
    }
    return combinations( $length, $num_elems, \@newlist);
}


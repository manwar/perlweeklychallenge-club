#! /opt/local/bin/perl
#
#       number_combo_convo.pl
#
#         TASK #1 › Number Combinations
#         Submitted by: Mohammad S Anwar
#
#             You are given two integers $max and $elems. Write a script print all
#             possible combinations of $elems numbers from the list 1 2 3 … $max.
#
#             Every combination should be sorted i.e. [2,3] is valid
#             combination but [3,2] is not.
#
#             Example:
#               Input: $max = 5, $elems = 2
#
#               Output: [ [1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5] ]
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my ($max, $elems) = @ARGV;

($elems > $max or @ARGV < 2) and do {
    say "Usage: ./number_combos.pl max elements
    max cannot be less than # of elements";
    exit };

my @list = add_elements( $max, $elems, [[]] )->@*;

say ( "[" . (join ', ', map { "[". (join ',', $_->@*) . "]" } @list) . "]");


## ## ## ## ## SUBS:

sub add_elements {
    my ($max, $elems, $list) = @_;
    return $list if $list->[0]->@* == $elems;

    my @newlist = ();

    my $pos = $list->[0]->@* + 1;          ## this position, elems of prev list + 1

    for my $combo ( $list->@* ) {
        my $prev  = $combo->[-1] // 0;
        my $start = $prev + 1;             ## value of last elem in list + 1
        my $end   = $max - $elems + $pos;  ## max - length + position
        for ($start .. $end ) {
            push @newlist, [ $combo->@*, $_ ]
        }
    }
    return add_elements( $max, $elems, \@newlist);
}

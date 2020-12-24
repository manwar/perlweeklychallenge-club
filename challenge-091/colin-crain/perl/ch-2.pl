#! /opt/local/bin/perl
#
#       jump_street.pl
#
#         TASK #2 › Jump Game
#         Submitted by: Mohammad S Anwar
#             You are given an array of positive numbers @N, where
#             value at each index determines how far you are allowed
#             to jump further.

#             Write a script to decide if you can jump to the last
#             index. Print 1 if you are able to reach the last index
#             otherwise 0.
#
#         Example 1:
#             Input: @N = (1, 2, 1, 2)
#             Output: 1
#
#             as we jump one place from index 0 and then twoe places
#             from index 1 to reach the last index.
#
#         Example 2:
#             Input: @N = (2,1,1,0,2)
#             Output: 0
#
#             it is impossible to reach the last index. as we jump two
#             places from index 0 to reach index 2, followed by one
#             place jump from index 2 to reach the index 3. once you
#             reached the index 3, you can't go any further because
#             you can only jump 0 position further.
#
#         method:
#
#             a silly little game, but we'll need to establish some
#             groundrules. First, do we need to land exactly on the
#             last element or can we overshoot? Should we wait and see
#             if Mohammad goes back and clarifies this before solving?
#             I think from the language it implies we should be
#             jumping _to_ the last index _exactly_. So if we
#             overshoot, then there's no way to get back and we fail.
#
#             If that's the case then there are two ways to fail: to
#             either land on a zero and be unable to continue, or to
#             overshoot the mark.
#
#             I would also point out that 0 is not positive, but is
#             used in an example. Thus we will rephrase the input as
#             an "array of non-negative numbers" which will include
#             the number 0.
#
#             So we keep tabs on an index value, advancing it by the
#             value of the array at that index. If that value is
#             either 0 or undef, then we fail.
#
#             If the index is the end of the array we win and stop
#             there.
#
#             Continue until we win or lose.
#
#             I like the idea of allowing negative values to move
#             backwards. In this case the failure modes would be the
#             same, with the addition of a third: if we ever visited
#             an element twice it would indicate we have entered a
#             loop, and will repeat without reaching the end. A little
#             more complicated in the possible pathways but still will
#             always resolve sooner or later.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";


## ## ## ## ## SUBS:

sub jump_forward {
## minimal version as described.
## Array -> 1|0
## returns 1 on success, 0 on failure
    my $idx = 0;
    while ( my $jump = $_[$idx] ) {
        $idx += $jump;
        return 1 if $idx == @_ - 1;
    }
    return 0;
}

sub jump_around {
## a more robust game allowing negative values.
## fails on
##   exceeding array bounds,
##   landing on 0 (cannot jump further)
##   landing on position twice (signifying a closed loop)
## wins
##   by landing on last element
## returns on determination
    my @array = @_;
    my $idx = 0;
    my $last = scalar @array - 1;
    my %visited;
    while (1) {
        my $next = $idx + $array[$idx];
        return 1 if $next == $last;              ## win
        return 0 if $next == $idx;               ## stuck
        return 0 if $next < 0 or $next > $last;  ## out of bounds
        return 0 if exists $visited{$next};      ## looping
        $idx = $next;
        $visited{$idx} = 1;
    }
}

use Test::More;

is jump_forward(1, 2, 1, 2), 1, 'forward ex 1: success!';
is jump_forward(2,1,1,0,2),  0, 'forward ex 2: stuck on 0';
is jump_forward(2,1,1,1,0),  1, 'forward: ok, last ele 0';

is jump_around(1, 2, 1, 2),  1, 'around ex 1: success!';
is jump_around(2,1,1,0,2),   0, 'around ex 2: stuck on 0';
is jump_around(2,1,1,1,0),   1, 'around: ok, last ele 0';
is jump_around(2,3,1,-2,5),  1, 'around: ok: back and forth and home';
is jump_around(2,3,1,-12,5), 0, 'around: fail: back too far';
is jump_around(2,13,1,-2,5), 0, 'around: fail: forward too far';


done_testing();

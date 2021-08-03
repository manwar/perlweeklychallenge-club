#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

# Examples from the task.
ok  is_square([10,20],[20,20],[20,10],[10,10]);
ok !is_square([12,24],[16,10],[20,12],[18,16]);

# Borrowed unit test from E. Choroba.
# https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-123/e-choroba/perl/ch-2.pl

ok  is_square([ 3, 3],[5, 5],[ 3,5],[ 5, 3]);
ok  is_square([ 3, 3],[4, 4],[ 3,4],[ 4, 3]);
ok  is_square([ 1, 3],[3, 1],[-1,1],[ 1,-1]);
ok  is_square([-1,-1],[2,-2],[ 3,1],[ 0, 2]);
ok  is_square([ 2, 3],[5, 5],[ 4,0],[ 7, 2]);
ok !is_square([ 0, 3],[0,-3],[ 1,0],[-1, 0]);
ok !is_square([ 4, 9],[4, 8],[ 4,9],[ 3, 9]);
ok !is_square([ 0, 0],[0, 0],[ 0,0],[ 1, 1]);
ok !is_square([ 0, 0],[0, 0],[ 0,0],[ 0, 0]);
ok !is_square([ 2, 4],[1, 5],[ 4,5],[ 2, 7]);

done_testing;

sub is_square {
    my ($a, $b, $c, $d) = @_;

    my $dist = sub {
        my ($a, $b) = @_;
        return ($a->[0] - $b->[0])**2 + ($a->[1] - $b->[1])**2;
    };

    my $sub_array = sub {
        my ($a, $i) = @_;

        my $p = [ @$a ];
        if ($i == $#$p) {
            pop @$p;
        }
        else {
            splice(@$p, $i, 1);
        }

        return @$p;
    };

    my $uniq_dist = {};
    my $p = [ $a, $b, $c, $d ];
    foreach my $i (0 .. 3) {
        my $o = $p->[$i];

        foreach my $j ($sub_array->($p, $i)) {
            return 0 if (($o->[0] == $j->[0]) && ($o->[1] == $j->[1]));
            $uniq_dist->{$dist->($o, $j)} = 1;
        }
    }

    return ((keys %$uniq_dist) == 2);
}

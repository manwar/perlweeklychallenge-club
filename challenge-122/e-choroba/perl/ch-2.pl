#!/usr/bin/perl
use warnings;
use strict;

sub basketball_points {
    my ($score) = @_;
    return [] if 0 == $score;

    my @result;
    for my $shot (grep $_ <= $score, 1, 2, 3) {
        push @result, map [$shot, @$_], basketball_points($score - $shot);
    }
    return @result
}

use Test2::V0;
plan 2;

is [basketball_points(4)], bag {
    item [1, 1, 1, 1];
    item [1, 1, 2];
    item [1, 2,  1];
    item [1, 3];
    item [2, 1, 1];
    item [2, 2];
    item [3, 1];
    end
};

is [basketball_points(5)], bag {
    item [1, 1, 1, 1, 1];
    item [1, 1, 1, 2];
    item [1, 1, 2, 1];
    item [1, 1, 3];
    item [1, 2, 1, 1];
    item [1, 2, 2];
    item [1, 3, 1];
    item [2, 1, 1, 1];
    item [2, 1, 2];
    item [2, 2, 1];
    item [2, 3];
    item [3, 1, 1];
    item [3, 2];
    end
};

#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_2.pl
#
#        USAGE: ./ch_2.pl
#
#  DESCRIPTION: Perl Weekly Challenge 089
#               Task 2
#               Magical Matrix
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 12/04/2020 09:40:19 PM
#===============================================================================

use strict;
use warnings;
use List::Util qw/sum/;
use Data::Dumper;

sub is_complete {
    my $matrix = shift;
    # 0 1 2
    # 3 4 5
    # 6 7 8

    return 0 unless $matrix->[0] + $matrix->[1] + $matrix->[2] == 15;
    return 0 unless $matrix->[3] + $matrix->[4] + $matrix->[5] == 15;
    return 0 unless $matrix->[6] + $matrix->[7] + $matrix->[8] == 15;

    return 0 unless $matrix->[0] + $matrix->[3] + $matrix->[6] == 15;
    return 0 unless $matrix->[1] + $matrix->[4] + $matrix->[7] == 15;
    return 0 unless $matrix->[2] + $matrix->[5] + $matrix->[8] == 15;

    return 0 unless $matrix->[0] + $matrix->[4] + $matrix->[8] == 15;
    return 0 unless $matrix->[2] + $matrix->[4] + $matrix->[6] == 15;

    return 1;
}

sub is_valid {
    my $matrix = shift;

    # 0 1 2
    # 3 4 5
    # 6 7 8

    return 0 unless $matrix->[0] + $matrix->[1] + $matrix->[2] <= 15;
    return 0 unless $matrix->[3] + $matrix->[4] + $matrix->[5] <= 15;
    return 0 unless $matrix->[6] + $matrix->[7] + $matrix->[8] <= 15;

    return 0 unless $matrix->[0] + $matrix->[3] + $matrix->[6] <= 15;
    return 0 unless $matrix->[1] + $matrix->[4] + $matrix->[7] <= 15;
    return 0 unless $matrix->[2] + $matrix->[5] + $matrix->[8] <= 15;

    return 0 unless $matrix->[0] + $matrix->[4] + $matrix->[8] <= 15;
    return 0 unless $matrix->[2] + $matrix->[4] + $matrix->[6] <= 15;

    return 1;
}

sub get_magical_matrix {
    my $matrix = shift;

    my $next_pos = -1;

    for (0..8) {
        if ($matrix->[$_] == 0) {
            $next_pos = $_;
            last;
        }
    }

    my %available_numbers;
    $available_numbers{$_} = 1 for (1..9);
    delete $available_numbers{$matrix->[$_]} for (0..8);

    for my $key (keys %available_numbers) {
        $matrix->[$next_pos] = $key;
        unless (is_valid($matrix)) {
            $matrix->[$next_pos] = 0;
            next;
        }

        my $new_matrix = get_magical_matrix([@$matrix]);
        return $new_matrix if is_complete($new_matrix);
    }

    return $matrix;
}

sub print_matrix {
    my $matrix = shift;

    for my $row (0..2) {
        for my $col (0..2) {
            print $matrix->[$row*3+$col]." ";
        }
        print "\n";
    }
}


my @init_matrix;
for my $pos (0..8) {
    $init_matrix[$pos] = 0;
}

my $result = get_magical_matrix(\@init_matrix);
print_matrix($result);

use Test::More;
is(is_complete($result), 1);

done_testing;

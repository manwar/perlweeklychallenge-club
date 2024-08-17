#!/usr/bin/env perl

use v5.40;

use Test::More;

use List::Util 'all';

my %covered;
sub is_covered ($coordinates) {
    return exists $covered{join '', @$coordinates};
}

sub get_value ($coordinates) {
    return $covered{join '', @$coordinates};
}

sub possible_moves ($square) {
    my @ret;
    foreach my $main_axis (0, 1) {
        foreach my $fora (1, -1) {
            foreach my $secondary_fora (1, -1) {
                my @dest = @$square;
                $dest[$main_axis] += 2 * $fora;
                $dest[1 - $main_axis] += $secondary_fora;
                all { 1 <= $_ <= 8 } @dest or next;
                push @ret, \@dest;
            }
        }
    }
    return @ret;
}

sub do_it ($start, $end) {
    # pre-process
    foreach my $coordinates ($start, $end) {
        my ($letter, $number) = $coordinates =~ /^(.)(.)\z/;
        $coordinates = [1 + ord($letter) - ord('a'), $number];
    }
    %covered = (join('', @$start) => 0);

    my @queue = ($start);
    while (my $square = shift @queue) {
        my $square_value = get_value($square);
        join('', @$square) ne join('', @$end) or return $square_value;
        my @possible_moves = grep !is_covered($_), possible_moves($square);
        push @queue, @possible_moves;
        $covered{join '', @$_} = $square_value + 1 foreach @possible_moves;
    }
}

is do_it('g2', 'a8'), 4, 'Example 1';
is do_it('g2', 'h2'), 3, 'Example 2';

done_testing();
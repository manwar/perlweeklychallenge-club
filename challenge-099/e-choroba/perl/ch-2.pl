#!/usr/bin/perl
use warnings;
use strict;

# Count the subsequences.
sub unique_subsequence {
    my ($string, $subsequence) = @_;
    if (1 == length $subsequence) {
        my $count = () = $string =~ /\Q$subsequence/g;
        return $count
    }
    my $char = substr $subsequence, 0, 1, "";
    my ($count, $pos) = (0, 0);
    $count += unique_subsequence(substr($string, $pos++), $subsequence)
        while -1 != ($pos = index $string, $char, $pos);
    return $count
}

# Return all the possible positions that match the subsequence.
sub show_unique_subsequence {
    my ($string, $subsequence) = @_;
    my @solutions;
    for my $sub_pos (0 .. length($subsequence) - 1) {
        my $sub_char = substr $subsequence, $sub_pos, 1;
        my $str_pos = 0;
        my @partial;
        push @partial, $str_pos++
            while -1 != ($str_pos = index $string, $sub_char, $str_pos);
        @solutions = map {
            my $solution = $_;
            map { $_ > $solution->[-1] ? [@$solution, $_] : () } @partial;
        } @solutions;
        @solutions = map [$_], @partial unless @solutions;  # First character.
    }
    return \@solutions
}

use Test::More tests => 6;

is unique_subsequence('littleit', 'lit'), 5, 'Example 1';
is unique_subsequence('london', 'lon'), 3, 'Example 2';
is unique_subsequence('london', 'par'), 0, 'Zero';


is_deeply show_unique_subsequence('littleit', 'lit'),
          [[0, 1, 2], [0, 1, 3], [0, 1, 7], [0, 6, 7], [4, 6, 7]],
          'Show Example 1';

is_deeply show_unique_subsequence('london', 'lon'),
          [[0, 1, 2], [0, 1, 5], [0, 4, 5]],
          'Show Example 2';

is_deeply show_unique_subsequence('london', 'par'), [], 'Show Zero';

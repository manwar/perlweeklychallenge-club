#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Nice String (Weekly Challenge 329)

Return the longest substring where every present letter appears in both
uppercase and lowercase. If no such substring exists, return the empty
string.

=cut

sub is_nice ($s) {
    my %letters;
    $letters{$_}++ for split //, $s;
    for my $ch (keys %letters) {
        my $lower = lc $ch;
        my $upper = uc $ch;
        return 0 unless exists $letters{$lower} && exists $letters{$upper};
    }
    return 1;
}

sub longest_nice_substring ($s) {
    my $best = '';
    my $len = length $s;
    for my $start (0 .. $len - 1) {
        for my $end ($start + 1 .. $len) {
            my $candidate = substr $s, $start, $end - $start;
            next if length($candidate) <= length($best);
            $best = $candidate if is_nice($candidate);
        }
    }
    return $best;
}

if (!caller) {
    require Test::More;
    Test::More::is( longest_nice_substring('YaaAho'), 'aaA', 'Example 1' );
    Test::More::is( longest_nice_substring('cC'), 'cC', 'Example 2' );
    Test::More::is( longest_nice_substring('A'), '', 'Example 3' );
    Test::More::done_testing();
}

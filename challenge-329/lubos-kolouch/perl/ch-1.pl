#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Counter Integers (Weekly Challenge 329)

Replace every non-digit with a space, split the remaining digits into
integers, and return the distinct integers in order of first
appearance.

=cut

sub counter_integers ($str) {
    my $digits_as_spaces = $str =~ s/\D+/ /gr;
    my %seen;
    my @uniq;
    for my $chunk (split /\s+/, $digits_as_spaces) {
        next unless length $chunk;
        next if $seen{$chunk}++;
        push @uniq, 0 + $chunk;
    }
    return \@uniq;
}

if (!caller) {
    require Test::More;
    Test::More::is_deeply( counter_integers('the1weekly2challenge2'), [1, 2], 'Example 1' );
    Test::More::is_deeply( counter_integers('go21od1lu5c7k'), [21, 1, 5, 7], 'Example 2' );
    Test::More::is_deeply( counter_integers('4p3e2r1l'), [4, 3, 2, 1], 'Example 3' );
    Test::More::done_testing();
}

#!/usr/bin/env perl

=head1

Week 161:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-161

Task #1: Abecedarian Words

    An abecedarian word is a word whose letters are arranged in alphabetical order.

    For example, “knotty” is an abecedarian word, but “knots” is not.

    Output or return a list of all abecedarian words in the dictionary, sorted in decreasing order of length.

=cut

use strict;
use warnings;

my $file = $ARGV[0];
die "ERROR: Missing dictionary.\n"         unless defined $file;
die "ERROR: Invalid dictionary [$file].\n" unless -f -r -e $file;

open (my $DICT, "<", $file);
my $words = {};
while (my $word = <$DICT>) {
    chomp $word;
    my $len = length($word);
    $words->{$word} = $len if $len >= 2 && is_abecedarian($word);
}
close $DICT;

printf("%s\n", join("\n", sort { $words->{$b} <=> $words->{$a} } sort keys %$words));

#
#
# METHOD

sub is_abecedarian {
    my ($word) = @_;

    return 0 unless defined $word;
    $word = lc $word;
    return $word eq (join q{}, sort split //,$word);
}

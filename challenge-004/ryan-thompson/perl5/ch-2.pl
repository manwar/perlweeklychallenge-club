#!/usr/bin/env perl
#
# ch-2.pl - Filter words that are made up of a given list of letters
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings     'uninitialized';
use feature     'fc'; # >= 5.16
use List::Util  'all';

sub legal_word(_);

my $letters = $ARGV[0] // die "Usage: $0 letters < words.txt";
my %letters = letter_hash($letters);
print for grep legal_word, <STDIN>;

# Return true if $word can be formed using %letters
sub legal_word(_) {
    my ($word) = @_;
    chomp $word;
    my %word = letter_hash($word);

    all { $word{$_} <= $letters{$_} } keys %word;
}

# Turn abcc into ( a => 1, b => 1, c => 2 )
sub letter_hash { my %r; $r{ fc($_) }++ for split '', $_[0]; %r }

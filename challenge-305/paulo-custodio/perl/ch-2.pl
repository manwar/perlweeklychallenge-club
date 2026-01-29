#!/usr/bin/env perl

# Challenge 305
#
# Task 2: Alien Dictionary
# Submitted by: Mohammad Sajid Anwar
# You are given a list of words and alien dictionary character order.
#
# Write a script to sort lexicographically the given list of words based on the alien dictionary characters.
#
# Example 1
# Input: @words = ("perl", "python", "raku")
#        @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
# Output: ("raku", "python", "perl")
# Example 2
# Input: @words = ("the", "weekly", "challenge")
#        @alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
# Output: ("challenge", "the", "weekly")

use Modern::Perl;

my @words = split ' ', <>;
my @alien = split ' ', <>;

say join ", ", special_sort(\@words, \@alien);

sub special_sort {
    my ($words, $alien_array_ref) = @_;
    my $alien = join '', @$alien_array_ref;
    my $alpha = join '', 'a' .. 'z';

    # Pre-build the transliteration command for efficiency
    my $to_alpha   = "tr/\Q$alien\E/\Q$alpha\E/";

    return map  { $_->[0] }             # 3. Extract original words
           sort { $a->[1] cmp $b->[1] } # 2. Sort by translated version
           map  {                       # 1. Create [original, translated] pairs
               my $translated = $_;
               eval "\$translated =~ $to_alpha";
               [ $_, $translated ]
           } @$words;
}

#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string $S and an array of words @W.
Write a script to find out if $S can be split into sequence of one or more words as in the given @W.
Print the all the words if found otherwise print 0.

Example 1:
Input: $S = "perlweeklychallenge" @W = ("weekly", "challenge", "perl")
Output: "perl", "weekly", "challenge"

Example 2:
Input: $S = "perlandraku" @W = ("python", "ruby", "haskell")
Output: 0 as none matching word found.
=cut

use Test::More;

is_deeply( [find_words("perlweeklychallenge", ["weekly", "challenge", "perl"])],["perl", "weekly", "challenge"], "Found <perl> <weelky> <challenge>.");
is_deeply( [find_words("perlandraku", ["python", "ruby", "haskell"])],[0], "No other languages found.");
is_deeply( [find_words("Maytheforcebewithyou", ["with", "force", "may"])],["May", "force", "with"], "Found <May> <force> <with>.");

done_testing();




sub find_words
{
     my ($string, $words) = @_;
     my $words_string = join("|",@$words);
     my $re = qr/($words_string)/i;
     my @output = $string =~ /$re/g;
     return scalar @output ? @output : 0;
}
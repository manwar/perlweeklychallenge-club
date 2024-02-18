#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a paragraph $p and a banned word $w. Write a script to return the most frequent word that is not banned.

Example 1
Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
	   $w = "hit"
Output: "ball"
The banned word "hit" occurs 3 times. The other word "ball" occurs 2 times.

Example 2
Input: $p = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge."
	   $w = "the"
Output: "Perl"
The banned word "the" occurs 3 times. The other word "Perl" occurs 2 times.
=cut

use Test2::V0;

sub most_frequent_word
{
     my ($paragraph, $banned) = @_;
     my @words = grep length, split(/[ ,.]/, $paragraph);
     my (%freq, $count_banned);
     for my $word ( @words )
     {
          $word eq $banned ? $count_banned++ : $freq{$word}++;
     }
     @words = sort { $freq{$b} <=> $freq{$a} } keys %freq; # @words is changed herewith!
     return  [$words[0], $count_banned] ;
}

is(most_frequent_word("Joe hit a ball, the hit ball flew far after it was hit.", "hit"), [qw(ball 3)], 'Example 1');
is(most_frequent_word("Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.", "the"), [qw(Perl 3)], 'Example 2');
done_testing;




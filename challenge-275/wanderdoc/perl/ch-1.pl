#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a sentence, $sentence and list of broken keys @keys.

Write a script to find out how many words can be typed fully.
Example 1

Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
Output: 0

Example 2

Input: $sentence = "Perl and Raku", @keys = ('a')
Output: 1

Only Perl since the other word two words contain 'a' and can't be typed fully.

Example 3

Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
Output: 2

Example 4

Input: $sentence = "The joys of polyglottism", @keys = ('T')
Output: 2

=cut

use Test2::V0;

is(check_keys(q(Perl Weekly Challenge), [qw(l a)]), 0, q(Example 1));
is(check_keys(q(Perl and Raku), [qw(a)]), 1, q(Example 2));
is(check_keys(q(Well done Team PWC), [qw(l o)]), 2, q(Example 3));
is(check_keys(q(The joys of polyglottism), [qw(T)]), 2, q(Example 4));
done_testing();





sub check_keys
{
     my $sentence = $_[0];
     my $keys_aref = $_[1];
     my $re_ltr = do { my $ltr_str = join('|', @$keys_aref); qr/$ltr_str/i; };
     my $counter = 0;
     for my $word ( split(/\s/, $sentence ) )
     {
          next if $word =~ /$re_ltr/;
          $counter++;
     }
     return $counter;
}
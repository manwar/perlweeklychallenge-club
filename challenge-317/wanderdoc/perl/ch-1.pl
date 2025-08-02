#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of words and a word.
Write a script to return true if concatenating the first letter of each word in the given array matches the given word, return false otherwise.
Example 1

Input: @array = ("Perl", "Weekly", "Challenge")
       $word  = "PWC"
Output: true

Example 2

Input: @array = ("Bob", "Charlie", "Joe")
       $word  = "BCJ"
Output: true

Example 3

Input: @array = ("Morning", "Good")
       $word  = "MM"
Output: false
=cut

use constant {true => 1, false => 0};
use Test2::V0 -no_srand => 1;

is(is_acronym(["Perl", "Weekly", "Challenge"], 'PWC'), true, 'Example 1');
is(is_acronym(["Bob", "Charlie", "Joe"], 'BCJ'), true, 'Example 2');
is(is_acronym(["Morning", "Good"], 'MM'), false, 'Example 3');
done_testing();

sub is_acronym
{
     my ($aref, $word) = @_;
     my $acronym = join('', map { substr($_, 0, 1) } @$aref);
     return uc $acronym eq uc $word ? true : false; # uc just in case.
}

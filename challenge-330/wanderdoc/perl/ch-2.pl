#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string made up of one or more words separated by a single space.
Write a script to capitalise the given title. If the word length is 1 or 2 then convert the word to lowercase otherwise make the first character uppercase and remaining lowercase.

Example 1

Input: $str = "PERL IS gREAT"
Output: "Perl is Great"


Example 2

Input: $str = "THE weekly challenge"
Output: "The Weekly Challenge"


Example 3

Input: $str = "YoU ARE A stAR"
Output: "You Are a Star"
=cut

use Test2::V0 -no_srand => 1;

is(task_330_2("PERL IS gREAT"), "Perl is Great", "Example 1");
is(task_330_2("THE weekly challenge"), "The Weekly Challenge", "Example 2");
is(task_330_2("YoU ARE A stAR"), "You Are a Star", "Example 3");
done_testing();

sub task_330_2
{
     my $str = $_[0];
     return join(' ', 
          map {length($_) < 3 ? lc $_ : ucfirst(lc($_))} 
          split(/\s/, $str));
}

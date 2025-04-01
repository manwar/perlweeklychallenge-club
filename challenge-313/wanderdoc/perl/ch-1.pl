#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You have a broken keyboard which sometimes type a character more than once.
You are given a string and actual typed string.
Write a script to find out if the actual typed string is meant for the given string.
Example 1
Input: $name = "perl", $typed = "perrrl"
Output: true
Here "r" is pressed 3 times instead of 1 time.
Example 2
Input: $name = "raku", $typed = "rrakuuuu"
Output: true
Example 3
Input: $name = "python", $typed = "perl"
Output: false
Example 4
Input: $name = "coffeescript", $typed = "cofffeescccript"
Output: true
=cut


use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;

is(broken_keys('perl', 'perrrl'), true, 'Example 1');
is(broken_keys('raku', 'rrakuuuu'), true, 'Example 2');
is(broken_keys('python', 'perl'), false, 'Example 3');
is(broken_keys('coffeescript', 'cofffeescccript'), true, 'Example 4');
done_testing();

sub broken_keys
{
     my ($name, $typed) = @_;
     my $name_re_string = join('', map { "$_+" } split(//, $name));
     my $name_re = qr/$name_re_string/;
     return $typed =~ $name_re ? true : false;
}

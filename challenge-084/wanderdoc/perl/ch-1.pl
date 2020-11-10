#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an integer $N. Write a script to reverse the given integer and print the result. Print 0 if the result doesn’t fit in 32-bit signed integer. The number 2,147,483,647 is the maximum positive value for a 32-bit signed binary integer in computing.
Example 1: Input: 1234 Output: 4321
Example 2: Input: -1234 Output: -4321
Example 3: Input: 1231230512 Output: 0
=cut








use Test::More;
use constant {MAX_INT => 2_147_483_647};

sub reverse_integer32
{

     my $num = $_[0];

     my $rev = reverse $num;
     $rev =~ tr/-//ds;
     $rev =~ s/^0+//;
     return $rev > MAX_INT ? 0 : $num < 0 ? 0 - $rev : $rev;
}

is(reverse_integer32(1234), 4321, 'Example 1');
is(reverse_integer32(-1234), -4321, 'Example 2');
is(reverse_integer32(1231230512), 0, 'Example 3');
is(reverse_integer32(1e3), 1, 'Example with 0');
is(reverse_integer32(-1e3), -1, 'Example with 0 and minus');



done_testing();
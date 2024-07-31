#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a shuffle string, $str.

Write a script to return the sorted string.

    A string is Shuffled by appending word position to each word.

Example 1

Input: $str = "and2 Raku3 cousins5 Perl1 are4"
Output: "Perl and Raku are cousins"

Example 2

Input: $str = "guest6 Python1 most4 the3 popular5 is2 language7"
Output: "Python is the most popular guest language"

Example 3

Input: $str = "Challenge3 The1 Weekly2"
Output: "The Weekly Challenge"
=cut

# use feature qw(state);
# using constant instead:
use constant ALPHANUM => qr/(\p{IsAlpha}+)(\p{IsDigit}+)/;

use Test2::V0;

is(sort_string(q(and2 Raku3 cousins5 Perl1 are4)), q(Perl and Raku are cousins), 'Example 1');
is(sort_string(q(guest6 Python1 most4 the3 popular5 is2 language7)), q(Python is the most popular guest language), 'Example 2');
is(sort_string(q(Challenge3 The1 Weekly2)), q(The Weekly Challenge), 'Example 3');
done_testing();

sub sort_string
{
     my $str = $_[0];
     my @arr = split(/\s/, $str);
     @arr = 
          map { $_->[0] }
          sort { $a->[1] <=> $b->[1] }
          map { [split_element($_)] }
          @arr;
     return join(' ', @arr);
}

sub split_element
{
     my $word = $_[0];
     my($alpha, $num) = $word =~ ALPHANUM; 
     return ($alpha, $num);
}
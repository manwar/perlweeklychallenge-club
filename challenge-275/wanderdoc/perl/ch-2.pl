#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an alphanumeric string, $str, where each character is either a letter or a digit.

Write a script to replace each digit in the given string with the value of the previous letter plus (digit) places.
Example 1

Input: $str = 'a1c1e1'
Ouput: 'abcdef'

shift('a', 1) => 'b'
shift('c', 1) => 'd'
shift('e', 1) => 'f'

Example 2

Input: $str = 'a1b2c3d4'
Output: 'abbdcfdh'

shift('a', 1) => 'b'
shift('b', 2) => 'd'
shift('c', 3) => 'f'
shift('d', 4) => 'h'

Example 3

Input: $str = 'b2b'
Output: 'bdb'

Example 4

Input: $str = 'a16z'
Output: 'abgz'

=cut


use List::MoreUtils qw(first_index);
use Test2::V0;

is(replace_digits(q(a1c1e1)), q(abcdef), q(Example 1));
is(replace_digits(q(a1b2c3d4)), q(abbdcfdh), q(Example 2));
is(replace_digits(q(b2b)), q(bdb), q(Example 3));
is(replace_digits(q(a16z)), q(abgz), q(Example 4));
done_testing();

sub replace_digits
{
     my $str = $_[0];
     my @letters = 'a' .. 'z';
     my $re_ltr = do { my $ltr_str = join('|', @letters); qr/$ltr_str/; };
     my $re_num = do { my $num_str = join('|', 0 .. 9  ); qr/$num_str/; };
     my @arr = split(//, $str);
     my $this_letter;
     for my $elm ( @arr )
     {
          if ($elm =~ /$re_ltr/)
          {
               $this_letter = $elm;
          }
          elsif ( $elm =~ /$re_num/)
          {
               if ( defined $this_letter )
               {
                    my $idx = first_index { $_ eq $this_letter } @letters;
                    $idx += $elm;
                    $elm = $letters[$idx];
               }
               else
               {
                    die "The first character must be a letter a .. z!$/";
               }
          }
     }
     return join('', @arr);
}
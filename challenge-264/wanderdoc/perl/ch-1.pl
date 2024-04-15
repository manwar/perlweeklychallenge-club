#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str, made up of only alphabetic characters [a..zA..Z]. Write a script to return the greatest english letter in the given string.
    A letter is greatest if it occurs as lower and upper case. Also letter 'b' is greater than 'a' if 'b' appears after 'a' in the English alphabet.
Example 1 Input: $str = 'PeRlwEeKLy' Output: L
There are two letters E and L that appears as lower and upper.
The letter L appears after E, so the L is the greatest english letter.
Example 2 Input: $str = 'ChaLlenge' Output: L
Example 3 Input: $str = 'The' Output: ''

=cut

use List::Util qw(uniq);
use Test2::V0;

is(greatest_letter(q(PeRlwEeKLy)),'L', 'Example 1');
is(greatest_letter(q(ChaLlenge)),'L', 'Example 2');
is(greatest_letter(q(The)),'', 'Example 3');
done_testing();


sub greatest_letter
{
     my $str = $_[0];
     my %filter;
     for my $letter ( split(//, $str) )
     {
          push @{$filter{ lc $letter }}, ord($letter);
     }
     # use Data::Dump; dd \%filter;
     for my $key ( keys %filter )
     {
          @{$filter{$key}} = uniq @{$filter{$key}};
     }
     my @output = 
          sort { $b cmp $a }
          grep { scalar @{$filter{$_}} > 1 }  keys %filter;
     return $output[0] ? uc $output[0] : '';
}

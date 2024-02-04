#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $s.Write a script to reverse all the vowels (a, e, i, o, u) in the given string.
Example 1 Input: $s = "Raku"  Output: "Ruka"
Example 2 Input: $s = "Perl"  Output: "Perl"
Example 3 Input: $s = "Julia" Output: "Jaliu""
=cut






use Test2::V0;

sub reverse_vowels
{
     my $string = $_[0];
     my @vowels = qw(a e i o u);
     my $vowels_str = join('|', @vowels);
     my $vowels_re = qr/$vowels_str/i;

     my @this_vowels = $string =~ /($vowels_re)/g;

     my $first_uc = 0;
     if ( $this_vowels[0] =~ /\p{Uppercase}/ ) # [A-Z] ) 
     { 
          $first_uc = 1; 
     };
     
     $string =~ s/$vowels_re/pop @this_vowels/eg;

     if ( 1 == $first_uc )
     {
          $string = ucfirst (lc $string);
     }

     return $string;
}

is(reverse_vowels("Raku"), "Ruka", "Example 1");
is(reverse_vowels("Perl"), "Perl", "Example 2");
is(reverse_vowels("Julia"), "Jaliu", "Example 3");

done_testing();
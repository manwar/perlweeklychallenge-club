#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to generate Self-descriptive Numbers in a given base.
In mathematics, a self-descriptive number is an integer m that in a given base b is b digits long in which each digit d at position n (the most significant digit being at position 0 and the least significant at position b - 1) counts how many instances of digit n are in m.
=cut

=theory
A self-descriptive number has the number of digits equal to the base. In base 7 and above a self-descriptive number has a following form: (base - 4) at the position 0, ones at positions 2 and (base - 4), two at the position 1 (reflecting the above mentioned ones) and zeros at all the rest positions.
=cut

# https://en.wikipedia.org/wiki/List_of_numeral_systems
my %digits; @digits{0 .. 63} = ('0'..'9', 'A'..'Z', 'a' .. 'z', '-', '_');

sub descr_create
{
     my $base = $_[0];
     if ( $base <= 3 or $base == 6 ) { return "Does not exist!" }
     if ( $base == 4 ) { return "1210 or 2020"; }
     if ( $base == 5 ) { return "21200"; }
     if ( $base > 64 ) { return "Is not implemented!"; }

     my @number = (0) x $base;

     $number[0] = $base - 4;
     $number[1] = 2;
     $number[2] = 1;
     $number[$#number - 3] = 1;
     my $num_str = join('', map $digits{$_}, @number);
     return $num_str;
}

for my $base ( 1 .. 64 )
{
     my $descr_num = descr_create($base);
     print join("\t", $base, $descr_num), $/; 
}



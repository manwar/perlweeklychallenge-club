#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to display all Colorful Number with 3 digits.
A number can be declare Colorful Number where all the products of consecutive subsets of digit are different.
For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3, 2x6x3 are unique.
=cut

use List::Util qw(reduce uniq);



my %DEBUG_STORE;

sub prod_con_subsets
{
     my $num = $_[0];
     my $len = length($num);
     my @set;
     for my $width (1 .. $len)
     {
          for my $pos ( 0 .. $len )
          {

               my $chunk = substr($num, $pos, $width);
               if ( length($chunk) == $width )
               {
                    push @set, $chunk;
               }
          }
     }

     my @products = _products(@set);
     $DEBUG_STORE{$num} = [@products];
     return @products;
}


sub _products
{
     my @arr = @_;

     my @products = map {my $el = $_; 
          my $res = length($el) == 1 ? $el :
          reduce{$a * $b} split(//,$el)} @arr;
     return @products;

}

sub is_colorful
{
     my $num = $_[0];
     my @arr = prod_con_subsets($num);
     return scalar @arr == scalar uniq @arr;
}

my $counter;
for my $num ( 100 .. 999 )
{
     next if $num =~ /[01]/; # cannot be colorful if contains 0 or 1.
     print "The Nr.", ++$counter, ' is ', $num, '; Proof: ', join(" ", @{$DEBUG_STORE{$num}}), $/ if is_colorful($num);

}
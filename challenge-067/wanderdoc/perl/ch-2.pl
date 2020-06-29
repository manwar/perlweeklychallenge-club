#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a digit string $S. Write a script to print all possible letter combinations that the given digit string could represent.
Input: $S = '35'
Output: ["dj", "dk", "dl", "ej", "ek", "el", "fj", "fk", "fl"].
=cut





# Solution with glob. It would not work with button "1" because of comma.
# However there are no _letters_ on that button :-)

use List::Util qw(reduce);

my %phone = 
(
     "1" => [('-', ',', '@')],
     "2" => [("A", "B", "C")],
     "3" => [("D", "E", "F")],
     "4" => [("G", "H", "I")],
     "5" => [("J", "K", "L")],
     "6" => [("M", "N", "O")],
     "7" => [("P", "Q", "R", "S")],

     "8" => [("T", "U", "V")],
     "9" => [("W", "X", "Y", "Z")]
);

my @memoize; # For the factorial function (s. below). 
# This, in turn, only to mimic the output with commas.
$memoize[1] = 1;
my $string = shift  || 35;
die "At least two digits as a string!$/" unless (length($string) > 1 and $string =~ /^[0-9]+$/);


my @buttons = split(//,$string);

my $letters = join('',map "{" . join(",", @$_) . "}", @phone{@buttons}); 

my $num_prod = reduce {$a * $b}
     map factorial(scalar(@$_))/factorial(scalar(@$_) - 1), @phone{@buttons}; 

my $counter;

while ( my $pair = glob $letters )
{

     print lc "\"$pair\"";
     $counter++;
     print ", " if $counter < $num_prod;
}
print $/; 

# To include the signs on the button "1" I would use a CPAN module. 

# Either:
use Math::Cartesian::Product;

$counter = 0;
cartesian {$counter++; print lc '"' . join('', @_) . '"' . ($counter < $num_prod ? ', ' : '')} @phone{@buttons};
print $/;

# or:
use Set::CrossProduct;

$counter = 0;

my $iterator = Set::CrossProduct->new( [@phone{@buttons}] );

my $number_of_tuples = $iterator->cardinality; # or reuse $num_prod;

while ( my $tuple = $iterator->get )
{
     print lc '"' . join('',@$tuple) . '"';
     $counter++;
     print ", " if $counter < $number_of_tuples;
}
print $/;


sub factorial # From "Mastering Perl".
{
     my $num = $_[0]; 
     return $memoize[$num] if $memoize[$num];

     for ( @memoize .. $num )
     {
          $memoize[$_] = $memoize[$_ - 1] * $_;

     }
     return $memoize[$num];
}
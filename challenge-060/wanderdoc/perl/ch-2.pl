#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script that accepts list of positive numbers (@L) and two positive numbers $X and $Y.
The script should print all possible numbers made by concatenating the numbers from @L, whose length is exactly $X but value is less than $Y.
Example Input:
@L = (0, 1, 2, 5);
$X = 2;
$Y = 21;
Output: 10, 11, 12, 15, 20

=cut


use Getopt::Long;
use List::Util qw(first);
my @numbers;
my $X = 2;
my $Y = 21;

GetOptions ("integers|i:i{,}" => \@numbers,
            "length|l=i"   => \$X,
            "value|v=i"  => \$Y)

or die("Error in command line arguments.\n");
# It seems that GetOptions does not die if there are letters among numbers,
# the letters and everything after a letter are simply ignored. 
# A '0' is in the array instead then.
die "Something wrong with the list of positive integers!$/" if 
(    scalar @numbers < 2 or 
     defined first{$_ < 0} @numbers

); # Integers > 9 are possible but may not be splitted.
my $string = join(',',@numbers);

my %seen; # To exclude repetitions because of duplicates in the integer list.


for my $i ( 1 .. $X ) # To allow sets with integers > 9.
{
     while ( my $comb = glob "{$string}" x $i )
     {
          $comb *= 1; # Leading zeros.

          next unless length($comb) == $X; 
          

          if ( $comb < $Y )
          {
               print $comb, $/ unless $seen{$comb}++;
          }
     }
}
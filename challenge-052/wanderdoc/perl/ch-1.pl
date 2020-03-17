#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to accept two numbers between 100 and 999. It should then print all Stepping Numbers between them.
    A number is called a stepping number if the adjacent digits have a difference of 1. For example, 456 is a stepping number but 129 is not.
=cut






use Getopt::Long; 
use List::Util qw(first);

my %par = (low => 100, high => 999);

GetOptions(    "low|l=i"   => \$par{low}, 
              "high|h=i"   => \$par{high},) 
or die("Error in command line!\n");
die "Numbers must be positive integers between 100 and 999!$/" 
     if defined first { $_ <= 0 or $_ < 100 or $_ > 999 } values %par;
die "The second number must be bigger!$/" unless ($par{high} > $par{low});

my $NUM = $par{low};
while ( $NUM <= $par{high} )
{
     my @digits = split(//,$NUM);

     if ( (1 == ($digits[1] - $digits[0]) and 1 == ($digits[2] - $digits[1]))
          or
          (1 == ($digits[1] - $digits[2]) and 1 == ($digits[0] - $digits[1]))
     )
     {
          print $NUM, $/;
     }


     $NUM++;
}
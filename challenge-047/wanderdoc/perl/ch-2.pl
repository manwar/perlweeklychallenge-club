#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to print first 20 Gapful Numbers greater than or equal to 100.
Gapful Numbers are numbers  that are divisible by the number formed by their first and last digit.
=cut


my $number = 100;
my $counter = 0;


while ( $counter < 20 )
{
     gapful($number) and print join(' ', ++$counter,$number), $/;
     $number++;
}

sub gapful
{
     my $num = $_[0];
     my $div = join('',(split(//,$num))[0, -1]);
     return 0 == $num % $div;
}

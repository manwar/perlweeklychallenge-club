#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script that accepts a number and returns the Excel Column Name it represents and vice-versa.
Excel columns start at A and increase lexicographically using the 26 letters of the English alphabet, A..Z. After Z, the columns pick up an extra "digit", going from AA, AB, etc., which could (in theory) continue to an arbitrary number of digits. In practice, Excel sheets are limited to 16,384 columns.
Example: 
Input Number: 28 Output: AB
Input Column Name: AD Output: 30## Task 2: Bit Sum
=cut


my $re_num = qr/^[0-9]+$/;
my $re_alp = qr/^[A-Z]+$/i; 

my $input = shift or die "Usage: <script> <column number> *OR* <column name>!\n";

my $num_or_alp = $input =~ $re_num ? 1 : 
                 $input =~ $re_alp ? 2 : 99;
die "Input ${input} is wrong!$/" if 99 == $num_or_alp;

$input = uc $input;



my $LIMIT = 16_384;
my @array;
my $x = 1;

while ( @array < $LIMIT )
{
     my @symbols = 'A' x $x .. 'Z' x $x; 

     push @array, @symbols;
     $x++;
}
@array = @array[0 .. $LIMIT];


unshift @array, 'NULL';

my %to_excel;
@to_excel{keys @array} = @array;

@array = ();
my %from_excel = reverse %to_excel;


if ( 1 == $num_or_alp )
{
     print exists $to_excel{$input} ? 
          "The name of the $input column is $to_excel{$input}.$/" :
          "No such column in Excel!$/";
}



if ( 2 == $num_or_alp )
{
     print exists $from_excel{$input} ? 
          "The number of the $input column is $from_excel{$input}.$/" :
          "No such column in Excel!$/";
}
#!perl.exe
use strict;
use warnings;
use ntheory qw/is_prime/;
use feature qw/say/;

sub sum_of_digits {
  my $binval = shift;
  my $digsum = 0;
  my @digarr = split(//,$binval);
  foreach( @digarr ) {
    $digsum += $_;
  }
  if (is_prime($digsum)) {
    return $digsum;
  } else {
    return -1;
  }
}

my $TARGET = 10;
my $i = 1;
my $cnt = 0;
my @outarr;

while ( $cnt < $TARGET ) {
  my $binval = sprintf("%06B", $i);
  my ($dsum) = sum_of_digits($binval);
  if ($dsum > 0 ) {
    push(@outarr, $i);
    $cnt++;
  }
  $i++;
}
say "@outarr ";

=pod

=head1 NAME

Challenge 156 Pernicious Numbers ( Perl )

=head1 AUTHOR

Robert DiCicco

=head1 DATE

14-MAR-2022

=head1 DESCRIPTION

Write a script to permute first 10 Pernicious Numbers.

A pernicious number is a positive integer which has prime number

of ones in its binary representation.

The first pernicious number is 3 since binary representation of

3 = (11) and 1 + 1 = 2, which is a prime.

Expected Output

3, 5, 6, 7, 9, 10, 11, 12, 13, 14

=cut

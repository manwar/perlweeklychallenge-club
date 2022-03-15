#!perl.exe
use strict;
use warnings;
use feature qw/say/;
use ntheory qw/divisors/;
use Set::Scalar;

sub digitsum {
  my $arr = shift;
  my $num = shift;
  my $sum = 0;
  foreach my $x (@$arr) {
    $sum += $x;
  }
  if ($sum == $num) {
    say "Subset: @$arr ";
    say "Input: n = $num";
    say "Output: 0";
    say " ";
    exit;
  }
  return 1;
}

my $num = $ARGV[0];

my @divs = divisors($num);

pop(@divs);

my $set1 = Set::Scalar->new(@divs);

my $iter = Set::Scalar->power_set_iterator($set1);
my @m;

say "Divisors: @divs ";
do {
  @m = $iter->();
  my $retval = digitsum(\@m, $num);
} while (@m);

say "No subset sums to $num";

###########################################################################

=pod

=head1 NAME

Challenge 156 Weird Numbers

=head1 Author

Robert DiCicco

=head1 DATE

14-MAR-2022

=head1 DESCRIPTION

You are given number, $n > 0.

Write a script to find out if the given number is a Weird Number.

According to Wikipedia, it is defined as:

The sum of the proper divisors (divisors including 1 but not itself) of the number is greater than the number, but no subset of those divisors sums to the number itself.

Example 1:

Input: $n = 12
Output: 0

Since the proper divisors of 12 are 1, 2, 3, 4, and 6, which sum to 16; but 2 + 4 + 6 = 12.

=cut

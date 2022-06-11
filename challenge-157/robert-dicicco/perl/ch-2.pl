use strict;
use warnings;
use Math::NumberBase qw/from_decimal/;
use feature qw/say/;

# AUTHOR: Robert DiCicco
# DATE: 22-MAR-2022
# Challenge 157 Brazilian Number ( Perl )

my $num = $ARGV[0];

my $base = 0;
my $retval = 0;
my $newnum = 0;

say "Input: $num";

foreach $base (2..($num-2)){                    # try various number bases
  my $basenum = Math::NumberBase->new($base);

  $newnum = $basenum->from_decimal($num);       # get input number converted to new base]

  say "In base $base: $newnum";

  $retval = checkDigits( $newnum);              # ship it off to be checked

  last if ($retval == 1);
}

say "Output: $retval";

sub checkDigits {
  my $num = shift;

  my @arr = split(//, $num);  # split digits into an array
  my $digit = $arr[0];        # save first digit to match against

  foreach (1..$#arr) {        # check remaining digits
    if( $arr[$_] != $digit){  # found a digit that does not match
      return 0;               # return failure
    }
  }

  return 1;                   # return success
 }

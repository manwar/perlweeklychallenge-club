#!perl.exe

use strict;
use warnings;
use Carp;
use ntheory qw/factorial/;

# Author: Robert DiCicco
# Date:     21-FEB-2022
# Challenge #153 Factorions ( Perl )

my $num = $ARGV[0];
if ( not defined $num ){
  croak "No number supplied ";
}

chomp($num);

my $sumdigits = 0;
my $outstr = q{};

print "Input \$n = $num\n";

my $ret = is_factorion($num);
chop $outstr for 1..2;

print "$outstr = $sumdigits\n";
print "Output: $ret\n";

sub is_factorion {
  my $n = shift;
  my @digits = split(//,$n);
  foreach my $x (@digits){

      $outstr .= "$x\! + ";
      $sumdigits += factorial($x);

  }

  ($sumdigits == $n) ?  1 :  0;
}

use warnings;
use strict;

my $input = int($ARGV[0] // 0);
die "Expecting an integer between 1 and 3999"
  unless $input && ($input >= 1) && ($input <= 3999);
my $output = '';

# Basic mapping includes 1000 500 100 50 10 5 1.
# To avoid extra calculation, I have also added 900 400 90 40 9 4.
my @decimal = qw/ 1000 900 500 400 100 90 50 40 10  9 5  4 1/;
my @roman   = qw/    M  CM   D  CD   C XC  L XL  X IX V IV I/;

for my $i (0..12){
  my $dec   = $decimal[$i];
  my $rom   = $roman[$i];
  my $times = int($input / $dec);
  $output  .= ($rom x $times);
  $input   -=  $dec * $times ;
}

print "$output\n";

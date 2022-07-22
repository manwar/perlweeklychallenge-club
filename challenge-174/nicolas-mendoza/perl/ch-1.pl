#!/u7sr/bin/env perl

use v5.34;

use strict;
use warnings;

my $limit = 10**10; # Should be within a 10 digit bumber
my @found = (); # store found numbers

my @too_high_number_prefixes;
for my $number (0..$limit) { # iterate thru all numbers
  my $sum = 0; # store a temp sum
  my @n = split //, $number; # 
  for (my $i = @n; $i > 0; $i--) { # iterate thru every digit
    my $c = $n[$i-1]; # pick out digit
    my $s = $c**$i;
    $sum += $s;
    if ($sum > $number) { # go to next number if sum has become bigger already
      last;
    }
  }
  if ($sum == $number) { # Add to found array if it's a Disarium number
    push @found, $sum;
    if (@found == 19) { # bail out when we found 19
      say "@found";
      exit;
    }
  }
}

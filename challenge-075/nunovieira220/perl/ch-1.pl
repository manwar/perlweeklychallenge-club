#!/usr/bin/perl

use strict;
use warnings;

# Get coin sum
sub get_coin_sum {
  my ($limit, @sets) = @_;
  my $len = scalar @sets;

  return 0 if($len == 0);

  my %vals = ();
  $vals{0} = 1;
  $vals{$limit} = 0;

  foreach my $set (@sets) {
    last if($set > $limit);

    for(my $i = $set; $i <= $limit; $i++) {
      my $diff = $vals{$i - $set};
      if($diff) {
        $vals{$i} = $vals{$i} ? $vals{$i} + $diff : $diff;
      }
    }
  }

  return $vals{$limit};
}

# Input/Output
if(scalar @ARGV > 0) {
  my $limit = shift @ARGV;
  my @sets = grep {$_} (sort @ARGV);
  print get_coin_sum($limit, @sets)."\n";
} else {
  my @arr = (1,2,4);
  print get_coin_sum(6, @arr)."\n";
}
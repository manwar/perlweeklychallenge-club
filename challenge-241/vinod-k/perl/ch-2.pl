#!/usr/bin/perl
use strict;
use warnings;

my (%data, %h);

my @array = (11, 8, 27, 4);

foreach my $num (@array){
  printPrimeFactors($num);
}

foreach my $key (keys %data){
  foreach my $key2 (keys %{$data{$key}}){
    $h{$key} += $data{$key}{$key2};
  }
}

my @keys = sort {
    $h{$a} <=> $h{$b}
        or
    $a <=> $b
} keys(%h);

print "Prime factors: ". join(',', @keys);

sub printPrimeFactors {
  my $n = shift;
  my $a = $n;
 
  for (my $i = 2; $n > 1; $i++) {
    if ($n % $i == 0) {
      while ($n % $i == 0) {
        $data{$a}{$i}++;
        $n = $n / $i ;
      }
    }
  }
}

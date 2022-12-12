#!/usr/bin/perl
use strict;
use warnings;

foreach my $input (1..40) {
   print "Input $input, output " . count_specials($input) . "\n";
}

sub count_specials {
   my $number = shift;
   my $specials = 0;
   foreach my $i (1..$number) {
      $specials += is_special($i);
   }
   return $specials;
}

sub is_special {
   my $number = shift;
   my $map;
   # count all digits by adding 1 to the corresponding key in %$map for each digit
   # the count is the value
   map { $map->{$_}++ } split //, $number;
   # sort values descending
   my @values = reverse sort { $a <=> $b } values %$map;
   # if the first element is 1, the number is special
   if($values[0] == 1) {
      return 1;
   }
   return 0;
}

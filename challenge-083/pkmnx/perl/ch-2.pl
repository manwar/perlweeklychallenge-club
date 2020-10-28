#!/usr/bin/env perl

use warnings;
use strict;

my @A = ( 3, 10, 8, 23, 34, 52, 343, 23, 123, 11, 898, 238, 2, 567, 98 );
#my @A = (3, 10, 8);
#my @A = (12, 2, 10);

my $sza = scalar @A;

die ( "we're not really processing > 32 nums w/ this algorithm." ) if ( $sza > 32 );
die ( "we're only processing nums here!" ) if ( grep /\D/, @A );

my @output = @{ (
   map { $_ }
   sort { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] }
   grep { $_->[0] > -1 } map {
   
      my @k = split //, $_;
   
      my $sum = 0;
      my $nsum = 0;
      my @sum = ();
      for (0 .. $#k) {
   
         my $acc = $A[$_];
         if ( $k[$_] eq "1" ) {
            $acc *= -1;
            $nsum++;
         }
   
         push @sum, $acc;
         $sum += $acc;
      }
   
      [ $sum, $nsum, @sum ];
   
   } 
   map { sprintf "%0".$sza."b", $_ } ( 0 .. (2 ** $sza) -1 )
)[0] };

my $sum = shift @output;
my $nsum = shift @output;

print "\n";
print "Input: @A\n";
print "Output: $nsum\n";

print "Flipping the sign of just " . ( $nsum < 2 ?"one element " :($nsum . " elements ") ) . "("
   . ( join ", ", map { $_ * -1} grep { $_ < 0 } @output ) .  ") gives the result $sum.\n";

print " i.e.: " . join " + ", map {"(" . $_ . ")" } @output;
print "\n";
print "\n";

exit (0);

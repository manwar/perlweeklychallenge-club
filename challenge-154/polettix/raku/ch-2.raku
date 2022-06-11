#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $n = 10) {
   my &it = grep_it(&is-prime, uniq(padovan-number-iterator()));
   (^$n).map({&it()}).join(', ').put;
}

sub padovan-number-iterator () {
   my ($Pa, $Pb, $Pc) = 1 xx 3;
   return sub {
      (my $retval, $Pa, $Pb, $Pc) = $Pa, $Pb, $Pc, $Pa + $Pb;
      return $retval;
   };
}

sub uniq (&it) {
   my $previous = &it();
   return sub {
      loop {
         my $current = &it();
         next if $current == $previous;
         (my $retval, $previous) = ($previous, $current);
         return $retval;
      }
   }
}

sub grep_it (&condition, &it) {
   return sub {
      loop {
         my $x = &it();
         return $x if &condition($x);
      }
   }
}

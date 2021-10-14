#!/usr/bin/env raku
use v6;

sub next-permutation (@arrangement) {
   my $i = @arrangement.end - 1;
   --$i while $i >= 0 && @arrangement[$i] >= @arrangement[$i + 1];
   return unless $i >= 0;
   my $j = @arrangement.end;
   --$j while @arrangement[$i] >= @arrangement[$j];
   @arrangement[$i, $j] = @arrangement[$j, $i];
   @arrangement[$i + 1 .. *]  = @arrangement[$i + 1 .. *].reverse;
   return @arrangement;
}

subset PosInt of Int:D where * > 0;
subset Base of PosInt where * <= 36;
sub pandigital-numbers (PosInt $n is copy, Base $b) {
   my ($n-digits, $factorial) = 1, 1;
   $factorial *= ++$n-digits while $factorial < $n;
   die "I'm too lazy for more general algorithms"
      if $n-digits >= $b - 1;

   state $p36-min = '1023456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
   my $fix = $p36-min.substr(0, $b - $n-digits);
   my @moving = $p36-min.substr($b - $n-digits, $n-digits).comb(/./);
   gather while $n > 0 {
      take $fix ~ @moving.join('');
      @moving = next-permutation(@moving) if --$n;
   };
}

sub MAIN (PosInt $n = 5, Base $b = 10) {
   .put for pandigital-numbers($n, $b);
}


#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util 'sum';
sub validate_SEDOL ($s) {
   state $weights = [1, 3, 1, 7, 3, 9, 1];
   return 0 if $s !~ m{\A [0-9B-DF-HJ-NP-TV-Z]{6} [0-9] \z}mxs;
   my @s = split m{}mxs, $s;
   my $sum = sum map {
      my $n = $s[$_] le '9' ? $s[$_] + 0 : ord($s[$_]) - ord('A') + 10;
      $weights->[$_] * $n;
   } 0 .. 6;
   return $sum % 10 ? 0 : 1;
}
say validate_SEDOL(shift // 'B0YBKL9');

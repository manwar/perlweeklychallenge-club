#!/usr/bin/env raku
use v6;

sub sequence-without-one-on-one (Int:D $N is copy where 0 < *) {
   my $candidate = '1';
   while ($N > 1) {
      $candidate = succ-of-b4($candidate);
      --$N if $candidate !~~ /11/;
   }
   return $candidate;
}

sub succ-of ($x) {
   my ($carry, @succ) = (True, $x.comb.reverse>>.Int.Slip);
   for @succ -> $item is rw {
      ($item, $carry) = ($item + 1, False) if $carry;
      ($item, $carry) = (1        , True)  if $item > 3;
      last unless $carry;
   }
   @succ.push: 1 if $carry;
   @succ.reverse.join: '';
}

sub succ-of-b4 (Str:D $x) {
   my $X = $x.parse-base(4);
   loop {
      my $candidate = (++$X).base(4);
      return $candidate if $candidate !~~ /0/;
   }
}

my @inputs = @*ARGS ?? @*ARGS !! qw< 5 10 60 >;
sequence-without-one-on-one(+$_).put for @inputs;

#!/usr/bin/env raku
use v6;

class IntIterator { ... }
class BruteCheck { ... }
sub MAIN (Int:D $n where * > 0 = 20) {
   $*OUT.out-buffer = False;
   .put for BruteCheck.new(
      iterator => IntIterator.new(start => 2),
      ender    => -> @x { @x.elems == $n },
      checker  => sub ($n) { $n == totient-supersum($n) },
   ).run();
}

sub totient-supersum ($n is copy) {
   state %cache = <0 0 1 1 2 1>;

   my @stack = $n,;
   @stack.push($n = euler-phi($n)) while %cache{$n}:!exists;

   $n = @stack.pop;
   my $pred = %cache{$n};
   while @stack {
      ($n, my $phi) = @stack.pop, $n;
      $pred = %cache{$n} = $phi + $pred;
   }

   return $pred;
}

sub euler-phi ($n) {
   state %cache = <0 0 1 1 2 1>;
   return %cache{$n} //= (1 ..^ $n).grep({($_ gcd $n) == 1}).elems;
}

class IntIterator {
   has $.start is readonly is built = 0;
   has $.stop is readonly is built = Inf;
   has $.step is readonly is built = 1;
   has $!current;
   submethod TWEAK() {
      $!current = $!start;
      $!stop = -Inf if $!stop == Inf && $!step < 0;
   }
   method pull-one {
      return Nil
         if ($!step > 0 && $!current > $!stop)
         || ($!step < 0 && $!current < $!stop);
      my $retval = $!current;
      $!current += $!step;
      return $retval;
   }
};

class BruteCheck {
   has &.checker;
   has &.ender is built = sub (@r) { False };
   has $.iterator is built = IntIterator.new();
   method run {
      my @rval;
      while (! &!ender(@rval) && defined(my $c = $!iterator.pull-one())) {
         @rval.push: $c if &!checker($c);
      }
      return @rval;
   }
}

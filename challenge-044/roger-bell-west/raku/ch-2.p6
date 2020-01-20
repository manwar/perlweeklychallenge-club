#! /usr/bin/perl6

my $goal=200;

my @stack;

for sprintf('%b',$goal).split('',:skip-empty) -> $op {
  push @stack,'double';
  if ($op == 1) {
    push @stack,'add 1';
  }
}
@stack.shift;
@stack.shift;

say join(', ',@stack);

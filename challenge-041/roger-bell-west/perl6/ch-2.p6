#! /usr/bin/perl6

my @stack;

for (0..19) -> $i {
  if ($i < 2) {
    push @stack,1;
  } else {
    push @stack,1+@stack[@stack.end]+@stack[@stack.end-1];
    shift @stack;
  }
  say @stack[@stack.end];
}

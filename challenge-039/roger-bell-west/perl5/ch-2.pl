#! /usr/bin/perl

use strict;
use warnings;

my @stack=();

my %op=(
  add => \&add,
  '+' => \&add,
  sub => \&sub,
  '-' => \&sub,
  mul => \&mul,
  '*' => \&mul,
  div => \&div,
  '/' => \&div,
  neg => \&neg,
  dup => \&dup,
  pop => \&pop,
  exch => \&exch,
    );

foreach my $p (@ARGV) {
  if (exists $op{$p}) {
    $op{$p}->();
  } elsif ($p =~ /^[.0-9]+$/) {
    push @stack,$p;
  } else {
    die "Unknown input $p\n";
  }
  print join(' ',@stack),"\n";
}

sub add {
  push @stack,(pop @stack) + (pop @stack);
}

sub sub {
  push @stack,-((pop @stack) - (pop @stack));
}

sub mul {
  push @stack,(pop @stack) * (pop @stack);
}

sub div {
  push @stack,1/((pop @stack) / (pop @stack));
}

sub neg {
  push @stack,-(pop @stack);
}

sub dup {
  push @stack,$stack[-1];
}

sub pop {
  pop @stack;
}

sub exch {
  ($stack[-1],$stack[-2])=($stack[-2],$stack[-1]);
}

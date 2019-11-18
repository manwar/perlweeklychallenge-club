#! /usr/bin/perl6

my @stack=();

my %op=(
  add => &add,
  '+' => &add,
  sub => &sub,
  '-' => &sub,
  mul => &mul,
  '*' => &mul,
  div => &div,
  '/' => &div,
  neg => &neg,
  dup => &dup,
  pop => &pop,
  exch => &exch,
    );

for @*ARGS -> $p {
  if (%op{$p}:exists) {
    %op{$p}.();
  } elsif ($p ~~ /^<[.0..9]>+$/) {
    push @stack,$p;
  } else {
    die "Unknown input $p\n";
  }
  say join(' ',@stack);
}

sub add {
  push @stack,(@stack.pop) + (@stack.pop);
}

sub sub {
  push @stack,-((@stack.pop) - (@stack.pop));
}

sub mul {
  push @stack,(@stack.pop) * (@stack.pop);
}

sub div {
  push @stack,1/((@stack.pop) / (@stack.pop));
}

sub neg {
  push @stack,-(@stack.pop);
}

sub dup {
  push @stack,@stack[* -1];
}

sub pop {
  @stack.pop;
}

sub exch {
  (@stack[* -1],@stack[* -2])=(@stack[* -2],@stack[* -1]);
}

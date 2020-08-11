#! /usr/bin/perl6

my $u=0;

my @fn;
for @*ARGS -> $p {
  if ($p.IO.e) {
    push @fn,$p;
  } elsif ($p eq '-u') {
    $u=1;
  }
}
unless (@fn) {
  push @fn,'-';
}

my %l;

for @fn -> $fn {
  my $fh=open :r,$fn;
  for $fh.lines {
    .chomp;
    my @e=comb(/<-[@]>+/,$_);
    my $k=lc(@e[1]) ~ '@' ~ @e[0];
    if ($u) {
      %l{$k}:delete;
    }
    push %l{$k},$_;
  }
  close $fh;
}

for (sort keys %l) -> $k {
  my @q=%l{$k}.flat;
  for @q -> $e {
    say $e;
  }
}

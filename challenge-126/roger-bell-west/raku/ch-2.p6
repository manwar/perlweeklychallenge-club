#! /usr/bin/perl6

my @in=(
  [qw{x * * * x * x x x x}],
  [qw{* * * * * * * * * x}],
  [qw{* * * * x * x * x *}],
  [qw{* * * x x * * * * *}],
  [qw{x * * * x * * * * x}],
    );

my $ymax=@in.end;
my $xmax=@in[0].end;

my @mn;
for 0..$ymax {
  push @mn,[(0) xx ($xmax+1)];
}

for (0..$ymax) -> $y {
  my @sy=(max(0,$y-1)..min($ymax,$y+1));
  for (0..$xmax) -> $x {
    my @sx=(max(0,$x-1)..min($xmax,$x+1));
    if (@in[$y][$x] eq 'x') {
      for @sy -> $yi {
        for @sx -> $xi {
          if ($xi==$x && $yi==$y) {
            next;
          }
          @mn[$yi][$xi]++;
        }
      }
    }
  }
}

for (0..$ymax) -> $y {
  for (0..$xmax) -> $x {
    if (@in[$y][$x] eq 'x') {
      @mn[$y][$x]='x';
    }
  }
  say @mn[$y].join(' ');
}

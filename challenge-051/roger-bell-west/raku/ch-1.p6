#! /usr/bin/perl6

my @l=(-25,-10,-7,-3,2,4,8,10);
my $t=0;

@l=sort @l;
my %r;
for (0..@l.end-2) -> $a {
  for ($a+1..@l.end-1) -> $b {
    for ($b+1..@l.end) -> $c {
      if (@l[$a]+@l[$b]+@l[$c]==$t) {
        %r{@l[$a]}{@l[$b]}{@l[$c]}=1;
      }
    }
  }
}

for sort keys %r -> $d {
  for sort keys %r{$d} -> $e {
    for sort keys %r{$d}{$e} -> $f {
      print "$d + $e + $f\n";
    }
  }
}

#! /usr/bin/perl6

tow([10, 20, 30, 40, 50, 60, 70, 80, 90, 100]);
say "";

tow([10, -15, 20, 30, -25, 0, 5, 40, -5]);

sub tow(@n) {
  my $target=floor(sum(@n)/2);
  my $k=floor((@n.elems)/2);
  my $bestval=-1;
  my @bestset;
  for combinations(@n,$k) -> @set {
    my $l=abs($target-@set.sum());
    if ($bestval < 0 || $l < $bestval) {
      $bestval=$l;
      @bestset=@set.clone;
    }
  }
  my @o=([],[]);
  my %r=map {$_ => 1},@bestset;
  for @n -> $m {
    if (%r{$m}:exists) {
      push @o[1],$m;
    } else {
      push @o[0],$m;
    }
  }
  for (0,1) -> $i {
    say "(" ~ @o[$i].join(', ') ~ ")";
  }
}

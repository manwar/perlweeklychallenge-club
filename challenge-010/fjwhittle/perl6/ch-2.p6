#!/usr/bin/env/perl6

#| Jaro similarity
sub sim-j (Str $a, Str $b) {
  my @si = $a.comb;
  my @sj = $b.comb;

  my $lim = max(@si, @sj) / 2 - 1;

  my %m;

  for @si.pairs -> $i {
    my $jf = max(0, $i.key - $lim);
    my $jt = min($i.key + $lim, @sj-1);

    for @sj[$jf..$jt] -> $j {
      if $j eq $i.value && !(%m{$i.key}) {
        %m{$i.key} = $i.value;
        last;
      }
    }
  }

  if my $m = %m.values.Bag {
    my $t = 0;

    my @sij = @sj.grep(* ∈ $m);

    for @si.grep(* ∈ $m).pairs {
      $t++ while @sij && @sij.shift ne .value;
    }

    $t /= 2;

    ($m / @si + $m / @sj + 1 - $t / $m) / 3
  } else { 0 }
}

#| Jaro-Winkler similarity
sub sim-w (Str $a, Str $b, Rat :$p = 1/10) {
  if my $simj = sim-j($a,$b) {
    my $l = 0;
    for ($a.comb Z $b.comb)[^4] -> [$ai, $bi] {
      $ai eq $bi or last;
      $l++;
    }
    $simj + $l * $p * (1 - $simj);
  } else { 0 }
}

say 1 - sim-w(|@*ARGS[^2]);

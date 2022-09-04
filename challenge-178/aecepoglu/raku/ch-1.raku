# This is my first time writing raku (or perl) code
#  so don't take this as a standard for what good raku code should look like

my $b = -4
my $k = Complex($b).sqrt;

sub to-negaimaginary ($n, $i=0, @acc=[]) {
  if $n == 0 { return (@acc || [0]).reverse };
  if !($i %% 2) { return to-negaimaginary $n, ($i + 1), @acc.push(0) };
  to-negaimaginary ($n ÷ $b).ceiling, ($i + 1), @acc.push($n % $b.abs)
}

sub from-base ($n, $k, $acc=0) {
  $n.reduce: -> $x, $y { ($x×$k) + $y }
}

#for -5..18 -> $x { say $x, '. ', (to-negaimaginary $x), ', ', $x == from-base (to-negaimaginary $x), $k }

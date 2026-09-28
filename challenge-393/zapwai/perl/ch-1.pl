use v5.38;
use List::Util "uniq";

# Euclid's formula

sub multiples($a, $b, $c, $num) {
    my @o;
    for my $k (1 .. $num/$c) {
	push @o, $a*$k . " " . $b*$k . " " . $c*$k;
    }
    return @o;
}

sub proc($num) {
    say "Input: $num";
    my @o;
  outer: for my $m (2 .. sqrt($num)) {
	for my $n (1 .. $m - 1) {
	    next if ($m % $n == 0 && $n > 1);
	    my $c = $m*$m + $n*$n;
	    next outer if ($c > $num);
	    my $a = $m*$m - $n*$n;
	    my $b = 2*$m*$n;
	    push @o, multiples($a, $b, $c, $num);
	    push @o, multiples($b, $a, $c, $num);
	}
    }
    @o = uniq(@o);
    say "Output: ", scalar @o;
    say "{" . join(", ", @o) . "}";
}

my $num = 20;
proc($num);

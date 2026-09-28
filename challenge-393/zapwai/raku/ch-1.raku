use v6;

# Euclid's formula

sub multiples($a, $b, $c, $num) {
    my @o;
    for 1 .. $num/$c -> $k {
	@o.push($a*$k ~ " " ~ $b*$k ~ " " ~ $c*$k);
    }
    return @o;
}

sub proc($num) {
    say "Input: $num";
    my @o;
    outer: for 2 .. sqrt($num) -> $m {
	for 1 .. $m - 1 -> $n {
	    next if $m % $n == 0 && $n > 1;
	    my $c = $m*$m + $n*$n;
	    next outer if $c > $num;
	    my $a = $m*$m - $n*$n;
	    my $b = 2*$m*$n;
	    push @o, |multiples($a, $b, $c, $num);
	    push @o, |multiples($b, $a, $c, $num);
	}
    }
    @o = @o.unique;
    say "Output: ", @o.elems;
    say @o.join(', ');
}

my $num = 20;
proc($num);

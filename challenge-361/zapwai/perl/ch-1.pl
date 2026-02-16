use v5.38;

my $MAX = 100;
my @f = (1,1);
my $i = 2;

do {
    push @f, $f[$i-1] + $f[$i-2];
    $i++;
} while ($f[$#f] < $MAX);

## e.g. 1 1 2 3 5 8 13 21 34 55 89 

sub is_fibo($num) {
    for my $n (@f) {
	return 1 if ($n == $num);
    }
    return 0;
}

sub list_terms($num) {
    if (is_fibo($num)) {
	return $num;
    } else {
	my $max = 0;
	for (@f) {
	    if ($_ > $num) {
		last;
	    }
	    else {
		$max = $_;
	    }
	}
	my $diff = $num - $max;
	my @t = list_terms($diff);
	return (@t, $max);
    }
}

sub proc($num) {
    say "Input: $num";
    say "Output: ", join(" + ", list_terms($num));
}

my $num = 4;
proc($num);
$num = 12;
proc($num);
$num = 20;
proc($num);
$num = 96;
proc($num);
$num = 100;
proc($num);

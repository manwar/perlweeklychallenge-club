use v6;

sub no_div($n, @p) {
    for @p -> $p {
	return 0 if $n % $p == 0;
    }
    return 1;
}

sub fill() {
    my @p = ();
    for 2 .. 10000 -> $n {
	push @p, $n if no_div($n, @p);
    }
    return @p;
}

my @primes = fill();

sub proc($s) {
    say "Input: $s";
    my $val = 0;
    $val += ord($_) for $s.comb;
    say $val;
    
    my $index = 0;
    for 0 .. @primes.end -> $i {
	next if @primes[$i] < $val;
	$index = $i;
	last;
    }
    my $pre = @primes[$index - 1];
    my $post = @primes[$index]; 

    my $adiff = $val - $pre;
    my $bdiff = $post - $val;

    my $out = $adiff < $bdiff ?? $adiff !! $bdiff;
    say "Output: $out";
}

my $s = "hello";
proc($s);
$s = "football";
proc($s);
$s = "a";
proc($s);
$s = "challenge";
proc($s);
$s = "perl";
proc($s);

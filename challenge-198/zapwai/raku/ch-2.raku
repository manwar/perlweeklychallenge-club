my $n;
loop {
    $n = prompt "Please enter a number (or (q)uit): ";
    last if ($n eq 'q');
    redo unless ($n ~~ /^\d+$/);
    my $tot = 0;
    for 2 .. $n {
	$tot++ if is_prime($_);
    }
    say "Input: \$n = $n";
    say "Output: $tot";
}
my %primes;
sub is_prime($n) {
    return True if %primes{$n};
    for 2 .. sqrt $n {
	return False if $n % $_ == 0;
    }
    %primes{$n} = 1;
    True;
}

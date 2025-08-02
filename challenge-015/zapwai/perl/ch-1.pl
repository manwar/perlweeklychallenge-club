use v5.38;
my @primes = (2);
my @avg;

sub fill_primes($num) {
    my $i = $primes[$#primes];
    while (@primes < $num) {
	$i++;
	my $cnt = scalar grep { $i % $_ == 0 } @primes;
	push @primes, $i if ($cnt == 0);
    }
}

sub avg_primes() {
    for (1 .. $#primes - 1) {
	push @avg, ($primes[$_ + 1] + $primes[$_ - 1]) / 2;
    }
}

fill_primes(60);
avg_primes();

pop @primes;
shift @primes;
my (@weak, @strong, @other);
for (0 .. $#primes - 1) {
    if ($primes[$_] < $avg[$_]) {
	push @weak, $primes[$_];
    } elsif ($primes[$_] > $avg[$_]) {
	push @strong, $primes[$_];
    } else {
	push @other, $primes[$_];
    }
}
my @w = splice @weak, 0, 10;
say join(", ", @w);
my @s = splice @strong, 0, 10;
say join(", ", @s);

use v5.30;
my $n = 20;
say "Input: \$n = $n";
print "Output: ";
my @list;
list($n);
say scalar @list;
say "\t[@list]";
sub list(int $n) {
    for (2 .. $n) {
	push @list, $_ if is_prime($_);
    }
}
sub is_prime() {
    my $num = shift;
    for my $d (2 .. int sqrt($num)) {
	return 0 if ($num % $d == 0);
    }
    1
}

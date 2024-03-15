use v5.36;

sub has_distinct_digits ($num) {
    my @dig = split("",$num);
    my %num = map { $_ => 1 } @dig;
    return (scalar keys %num == scalar @dig);
}

for (2 .. 1000) {
    if (has_distinct_digits($_**2) and length $_*$_ >= 5) {
	say "Square this: $_ to get ", $_*$_;
	last;
    }
}


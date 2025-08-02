use feature qw(signatures say);

sub proc(@n) {
    say "Input: \@n = @n";
    @n = sort {$a <=> $b} @n;
    my @dist;
    do {
	my $min = shift @n;
	my $max = pop @n;
	my $avg = ($max + $min) / 2;
	push @dist, $avg unless (grep {$_ == $avg} @dist);
	last if (@n == 1);
    } while (@n);
    say "Output: ", scalar @dist;
}

my @nums = (1, 2, 4, 3, 5, 6);
proc(@nums);
@nums = (0, 2, 4, 8, 3, 5);
proc(@nums);
@nums = (7, 3, 1, 0, 5, 9);
proc(@nums);

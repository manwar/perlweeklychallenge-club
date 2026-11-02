use v5.38;

sub proc(@a) {
    say "Input: @a";
    my @e = grep {$_ % 6 == 0} @a;
    my $avg = 0;
    $avg += $_ for (@e);
    my $o;
    if (scalar @e) {
	$avg /= (scalar @e);
	my $b = int $avg;
	$o = (($avg - $b) < 0.5) ? $b : $b + 1;
    } else {
	$o = 0;
    }
    say "Output: $o";
}

my @arr = (18,5,7,11);
proc(@arr);
@arr = (6, 12, 18, 24, 30, 40);
proc(@arr);
@arr = (3, 9, 15, 21, 27);
proc(@arr);
@arr = (6, 12, 14, 20);
proc(@arr);
@arr = (6, 6, 6, 12, 12);
proc(@arr);

use v5.38;

sub next_int($v) {
    return 1 if ($v < 1);
    return int($v + 1);
}

sub avg(@a) {
    my $sum = 0;
    $sum += $_ for (@a);
    return $sum / @a;
}

sub proc(@a) {
    say "Input: @a";
    my $avg = avg(@a);
    my $next = next_int($avg);
    while (grep {$next == $_} @a) {
	$next = next_int($next);
    }
    say "Output: $next";
}

my @a = (1,2,4,5,6);
proc(@a);
@a = (-5, -2, -1, 3);
proc(@a);
@a = (1,2,3);
proc(@a);
@a = (2,3,7,8);
proc(@a);
@a = (1,1,1,10);
proc(@a);

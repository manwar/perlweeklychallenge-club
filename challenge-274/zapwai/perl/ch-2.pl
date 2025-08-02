use v5.38;
my @inp = ( [12, 11, 41], [15, 5, 35] );
my $MAX = 60;
my @R;
my @cost;
for my $l (@inp) {
    my $interval = $$l[0];
    my $start = $$l[1];
    push @cost, $$l[2];
    my @L;
    for my $i (0 .. $MAX/$$l[0]) {
        my $x = $start + $i*$interval;
	push @L, $x;
    }
    push @R, \@L;
}
my @r1 = @{$R[0]};
my @r2 = @{$R[1]};
my $length_one = $cost[0];
my $length_two = $cost[1];
my $out;
for my $t (1 .. 59) {
    my $delta_one = delta($t, @r1);
    my $delta_two = delta($t, @r2);
    my $time_taken_one = $length_one + $delta_one;
    my $time_taken_two = $length_two + $delta_two;
    $out .= "$t, " if (($delta_one < $delta_two) && ($time_taken_one > $time_taken_two));
}
say substr $out, 0, -2;

sub delta($t, @r) {
    foreach my $r (@r) {
	next if ($r < $t);
	return $r - $t;
    }
}

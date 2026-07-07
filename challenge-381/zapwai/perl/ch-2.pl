use v5.38;

sub proc(@int) {
    say "Input: @int";
    my ($min, $max) = ($int[0], $int[0]);
    for my $val (@int) {
	$min = $val if ($min > $val);
	$max = $val if ($max < $val);
    }
    my @out;
    for my $val (@int) {
	push @out, $val unless ($val == $min || $val == $max);
    }
    say "Output: ", scalar @out;
}

my @int = (2,4);
proc(@int);

@int = (1,1,1,1);
proc(@int);

@int = (1, 1, 4, 8, 12, 12);
proc(@int);

@int = (3,6,6,9);
proc(@int);

@int = (0, -5, 10, -2, 4);
proc(@int);

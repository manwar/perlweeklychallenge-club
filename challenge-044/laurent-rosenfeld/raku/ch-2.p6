use v6;

constant START-VAL = 1;
constant TARGET = 200;
constant HALF-TARGET = TARGET / 2;

my $min-ops = TARGET;
my $best-so-far;
my %good-combinations;

for 0..30 -> $incr {
    last if $incr > $min-ops;
    my $current-val = START-VAL;
    my @steps = ( START-VAL );
    for 1..$incr -> $add {
        push @steps, "+1";
        $current-val++;
    }
    while $current-val <= HALF-TARGET {
        push @steps, "*2";
        $current-val *= 2;
    }
    while $current-val < TARGET {
        push @steps, "+1";
        $current-val++;
    }
    my $nb-steps = @steps.elems;
    next if $nb-steps >= $min-ops;
    $min-ops = $nb-steps;
    $best-so-far = $incr;
    %good-combinations{$incr} = [@steps];
}
say "Best solution: %good-combinations{$best-so-far}";

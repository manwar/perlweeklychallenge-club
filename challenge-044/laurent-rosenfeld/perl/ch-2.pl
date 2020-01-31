use strict;
use warnings;
use feature "say";
use constant { START_VAL => 1, TARGET => 200};
use constant HALF_TARGET => TARGET /2;

my $min_ops = TARGET;
my $best_so_far;
my %good_combinations;

for my $incr (0..30) {
    last if $incr > $min_ops;
    my $current_val = START_VAL;
    my @steps = ( START_VAL );
    for my $add (1..$incr) {
        push @steps, "+1";
        $current_val++;
    }
    while ($current_val <= HALF_TARGET) {
        push @steps, "*2";
        $current_val *= 2;
    }
    while ($current_val < TARGET) {
        push @steps, "+1";
        $current_val++;
    }
    my $nb_steps = scalar @steps;
    next if $nb_steps >= $min_ops;
    $min_ops = $nb_steps;
    $best_so_far = $incr;
    $good_combinations{$incr} = [@steps];
}
say "Best solution: @{$good_combinations{$best_so_far}}";



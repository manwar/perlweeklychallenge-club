use strict;
use warnings;
use feature "say";

my @result;

sub print_result {
    my $count = 0;
    for  my $solution (@result) {
        print "\tOption ", ++$count, ": ";
        my @step_list;
        push @step_list, "$_ " . ($_ =~ /1/ ? "step " : "steps") for @$solution;
        say join " + ", @step_list;
    }
    say "";
}

sub try_steps  {
    my ($nb_steps, $sum, @curr) = @_;
    for my $new_step (1, 2) {
        my $new_sum =  $sum + $new_step;
        next if $new_sum > $nb_steps;
        my @new_cur = (@curr, $new_step);
        if ($new_sum == $nb_steps) {
            push @result, \@new_cur;
            last;
        } else {
            try_steps($nb_steps, $new_sum, @new_cur);
        }
    }
}

for my $target (3, 4, 5) {
    @result = ();
    try_steps $target, 0, ();
    say 'Input: $n = ', $target;
    say "Output: ", scalar @result;
    print_result;
}

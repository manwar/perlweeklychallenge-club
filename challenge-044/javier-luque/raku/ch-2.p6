# Test: perl6 ./ch-2.p6
use v6.d;

our $min_steps = 15;
our $min_solution;

sub MAIN () {
    add-or-double(1, 0, '');
    say 'Found smallest solution in ' ~ $min_steps ~
      ' steps: ' ~ $min_solution;
}


sub add-or-double(Int $cash, Int $current_steps, Str $solution) {
    my $steps = $current_steps + 1;

    # Let's not deep recurse past 15
    if ($steps > 15) {
        return Nil;
    }

    if ($cash == 200) {
        if ($min_steps > $steps) {
            $min_steps = $steps;
            $min_solution = $solution;
        }
    }

    if ($cash * 2 <= 200 ) {
        add-or-double($cash * 2, $steps, $solution ~ 'd' );
    }

    if ($cash + 1 <= 200) {
        add-or-double($cash + 1, $steps, $solution ~ 'a');
    }
}

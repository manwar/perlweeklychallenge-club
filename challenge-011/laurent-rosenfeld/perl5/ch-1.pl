use strict;
use warnings;
use feature qw/say/;

my %freeze = (F => 32, C => 0);
my %boil = (F => 212, C => 100);
my $speed_diff = ($boil{F} - $freeze{F} ) /($boil{C} - $freeze{C} ) ;

my $c = $freeze{C};
my $f = $freeze{F};

while (abs($c - $f) > 0.2) {
    $f += ($c - $f)/2;
    $c +=  ( ($c - $f) / $speed_diff );
    # say "Approx: $c $f ", $c-$f; # De-comment this line to see the intermediate results
}
printf "Fahrenheit and Celsius scales meet at: %.0f\n", $c;

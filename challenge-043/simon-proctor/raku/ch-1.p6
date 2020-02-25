#!/usr/bin/env perl6

use v6;

# I'm not 100% sure what the task is asking for I think it's about using the Rings as sets so you can put numbers in the intersections.
# (Note after running it I've found a solution with 1 number per set / intersection. So the code is based on this.

# First up define the available areas
sub reset-sets () {
    {
        blue => 8, yellow => 7, black => 0, green => 5, red => 9,
        blue_yellow => 0, yellow_black => 0, black_green => 0, green_red => 0
    };
}

my %sets = reset-sets();

# Now define subs to calculate the totals for each set
sub set-sum(%sets,@keys) {
    return sub () {
        [+] |%sets{@keys};
    }
}
my &blue = set-sum(%sets,<<blue blue_yellow>>);
my &yellow = set-sum(%sets,<<blue_yellow yellow yellow_black>>);
my &black = set-sum(%sets,<<yellow_black black black_green>>);
my &green = set-sum(%sets,<<black_green green green_red>>);
my &red = set-sum(%sets,<<green_red red>>);

my &complete = sub () { so blue() & yellow() & black() & green() & red() == 11 }

say "Before";
say "Current Sets {%sets.perl} : Totals : Blue {blue()} : Yellow {yellow() } : Black {black()} : Green {green()} : Red {red()} : Complete? {complete()}";

my @options = [1,2,3,4,6];

# First attempt, 1 number per pot.
for @options.permutations -> @possible {
    %sets = reset-sets();
    %sets<<black blue_yellow yellow_black black_green green_red>> = @possible;
    if ( complete() ) {
      say "Solution";
      say "Current Sets {%sets.perl} : Totals : Blue {blue()} : Yellow {yellow() } : Black {black()} : Green {green()} : Red {red()} : Complete? {complete()}";
      exit;
    }
}

say "Going to need to try something else";



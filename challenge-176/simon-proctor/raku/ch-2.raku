#!/usr/bin/env raku

#| Find all the reverible number less then 100
sub MAIN() {
    (1..^100).grep( { none(($_ + $_.flip).comb) %% 2 } ).say;
}

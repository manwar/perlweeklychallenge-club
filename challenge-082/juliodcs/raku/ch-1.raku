#!/usr/bin/env raku

# returns list of divisors
sub prefix:<∕>(\num) {
    (1 ... num/2, +num).grep: num %% *
}

# intersects and returns result as sorted list
sub infix:<@∩>(\a, \b) {
    (a ∩ b).keys.sort.list
}

sub MAIN(Int \a where * > 0, Int \b where * > 0) {
    say ∕a @∩ ∕b
}

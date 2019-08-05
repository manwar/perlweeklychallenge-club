#!/usr/bin/perl6

multi sub female(Int $n where { $_ == 0 }) {
    return 1;
}

multi sub female(Int $n where { $_ > 0 }) {
    return $n - male(female($n - 1));
}

multi sub male(Int $n where { $_ == 0 }) {
    return 0;
}

multi sub male(Int $n where { $_ > 0 }) {
    return $n - female(male($n - 1));
}

multi sub MAIN() {
    say 'Female: ', ({ female((state $n = 0)++) } ... *)[0 .. 20].join(', ');
    say 'Male:   ', ({ male((state $n = 0)++) } ... *)[0 .. 20].join(', ');
}

#!/usr/bin/perl6

sub MAIN(
    Int $N  #= number to factorialize and count trailing 0's (1 - 10)
    where { $N ~~ any 1 .. 10}
) {
    (([*] 1 .. $N) ~~ / <(0+)> $ / // q{}).chars.say;
}
#!/usr/bin/raku

sub MAIN(
    *@args
) {
    @args
        .permutations
        .grep({ @$_[0] == @args[0]; })
        .map({ $_.batch(2); })
        .map({ $_.map({ $_.sort({ $^a <=> $^b }); }) })
        .map({ join(q{}, | @$_); })
        .unique
        .map({ $_.comb; })
        .map({ $_.batch(2); })
        .map({ [+] $_.map({ $_.min; }) })
        .max
        .say;
}
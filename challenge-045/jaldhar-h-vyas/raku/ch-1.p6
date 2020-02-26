#!/usr/bin/perl6

multi sub MAIN(*@ARGS) {
    my $input = @*ARGS.lc.join(q{ }).subst(/\s+/, q{}, :g);
    $input ~= q{ } x 8 - ($input.chars % 8); 
    ([Z~] $input.comb.rotor(8)).join(q{ }).subst(/' '+/, q{ }, :g).say;
}
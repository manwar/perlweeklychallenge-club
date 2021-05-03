#!/usr/bin/env raku

my token valid-phone-number {
    [
        |\+\d\d
        |\d**4
        |\( ~ \) \d ** 2
    ]
    \s+
    \d**10
}

multi MAIN () {
    slurp()
    andthen .comb: &valid-phone-number
    andthen .map: *.say
}

multi MAIN (Bool :test($)!) {
    use Test;
    like $_, &valid-phone-number, "$_ is valid number"  for   '0044 1148820341',  '+44 1148820341', '(44) 1148820341';
    unlike $_, &valid-phone-number, "$_ is not valid number"  for   '00 1148820341',  '44-11-4882-0341';
    done-testing;
}

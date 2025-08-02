#!/usr/bin/env raku

sub  percentage-of-character ($str,:$char) {
    $str.comb
    andthen .Bag
    andthen .{$char}/.total
    andthen 100 * $_
    andthen .round
}

multi MAIN (Bool :test($)!) {
    use Test;
    is  percentage-of-character('perl',:char<e>), 25;
    is  percentage-of-character('java',:char<a>), 50;
    is  percentage-of-character('python',:char<m>), 0;
    is  percentage-of-character('ada',:char<a>), 67;
    is  percentage-of-character('ballerina',:char<l>), 22;
    is  percentage-of-character('analitik',:char<k>), 13;
    done-testing;
}

multi MAIN ($str,:$char) {
    say  percentage-of-character $str,:$char
}

#!/usr/bin/env raku

sub balance-string (+$str) {
    $str
    andthen .match: / [$<digit>=\d|$<letter>=<:L>]+ /;

    do with ( $<digit> - $<letter> ) {
        when 0|1 { roundrobin $<digit>.sort, $<letter>.sort, :slip }
        when -1  { roundrobin $<letter>.sort, $<digit>.sort, :slip }
        default  { '' }
    } andthen [~] $_ 
}
multi MAIN (Bool :test($)!) {
    use Test;
    is balance-string('a0b1c2'), '0a1b2c', 'letters and digits interleaved: a0b1c2 → 0a1b2c';
    is balance-string('abc12'), 'a1b2c', 'letters first then digits: abc12 → a1b2c';
    is balance-string('0a2b1c3'), '0a1b2c3', 'digits and letters shuffled: 0a2b1c3 → 0a1b2c3';
    is balance-string('1a23'), '', 'unbalanced input 1a23 cannot form alternating string';
    is balance-string('ab123'), '1a2b3', 'more digits than letters: ab123 → 1a2b3';
    done-testing;
}

multi MAIN (+$str) {
    say balance-string $str;
}

#!/usr/bin/env raku

multi fun-time($time) {
    $time ~~ / (\d+) ':' (\d+) \s* (<[ap]>m)? /;

    with $2 {
        when 'am'   { $0      ~ ':' ~ $1 }
        when 'pm'   { $0 + 12 ~ ':' ~ $1 }
    } orwith $0 {
        when * ≤ 12 {        $0       ~ ':' ~ $1 ~ 'am' }
        when * > 12 { '0' ~ ($0 - 12) ~ ':' ~ $1 ~ 'pm' }
    }
}

multi MAIN ($time) {
    say fun-time $time
}

multi MAIN (Bool :$test! ) {
    use Test;
    is fun-time('19:20'),    '07:20pm';
    is fun-time('07:20pm'),  '19:20';
    is fun-time('07:20 am'), '07:20';
    is fun-time('07:20'),    '07:20am';
    done-testing;
}

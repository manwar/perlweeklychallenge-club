#!/usr/bin/env raku

sub unique-subsequence ( $s, $t ) {
    my $re = $t.comb.join: '.*';
    $s.match: /<$re>/,:ex
}

multi MAIN (Bool :$test!) {
    use Test;
    is unique-subsequence('littleit', 'lit').Int,5;
    is unique-subsequence('london', 'lon').Int,  3;
    done-testing;
}

multi MAIN ($s, $t) {
    say +unique-subsequence $s, $t,
}

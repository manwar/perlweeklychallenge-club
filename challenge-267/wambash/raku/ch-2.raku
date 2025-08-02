#!/usr/bin/env raku

sub join-sum ((:$str, :$sum, :$line), Pair $y) {
    ($sum + $y.value ≤ 100)
    ?? \(str => $str ~ $y.key, sum => $sum + $y.value, :$line )
    !! \(str => $y.key,        sum => $y.value,         line =>$line+1)
}

sub line-counts ($str, +widths) {
    my %letters = 'a'..'z' Z=> widths;

    $str.comb
    andthen .map: { $_ => %letters{$_} }\
    andthen \(:str(''),:0sum,:1line), |$_
    andthen .reduce: &join-sum
    andthen .<line sum>
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply join-sum((:str('ab'),:20sum,  :3line), 'c' => 5), \(:str('abc'), :25sum, :3line);
    is-deeply join-sum((:str('abc'),:95sum, :3line), 'd' => 10), \(:str('d'),  :10sum, :4line);
    is-deeply line-counts(([~] 'a'..'z'), 10 xx 26), (3,60);
    is-deeply line-counts('bbbcccdddaaa', 4,slip 10 xx 26), (2,4);
    done-testing;
}

multi MAIN ($str, +widths) {
    put line-counts $str, widths
}

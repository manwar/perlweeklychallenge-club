#! /usr/bin/perl6

use Test;

plan 4;

is(fim(5),"Five is four, four is magic.",'example 1');
is(fim(7),"Seven is five, five is four, four is magic.",'example 2');
is(fim(6),"Six is three, three is five, five is four, four is magic.",'example 3');
is(fim(4),"Four is magic.",'example 4');

sub fim($n0) {
    my $n=$n0;
    my @words=("zero","one","two","three","four",
               "five","six","seven","eight","nine");
    my @p;
    while (True) {
        my $s=@words[$n] ~ ' is ';
        if ($n==4) {
            $s ~= 'magic.';
            @p.push($s);
            last;
        } else {
            $n=chars(@words[$n]);
            $s ~= @words[$n];
            @p.push($s);
        }
    }
    return tc(join(', ',@p));
}

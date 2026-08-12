# https://theweeklychallenge.org/blog/perl-weekly-challenge-386/
use v5.10;

sub f {
    state %digit_value = map { [0..9, 'A'..'Z', 'a'..'z', '+', '/']->[$_] => $_ } 0..63;
    my($num, $base) = @_;
    $num =~ s/.$// ? $digit_value{$&} + $base * f($num, $base) : 0
}

say pop(@$_) == f( @$_ ) ? "ok" : "ERROR" for
[ "101010",   2  =>         42 ],
[ "EEADEE",  16  =>   15642094 ],
[ "755",      8  =>        493 ],
[ "1BRJB",   36  =>    2228519 ],
[ "7MyqL",   64  =>  123456789 ];

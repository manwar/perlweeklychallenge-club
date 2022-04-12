use strict;
use warnings;
##
# You are given a positive number $n. Write a script 
# to generate the Moebius Number for the given number. 
##
use POSIX;
use Math::Complex;

sub farey{
    my($order) = @_;
    my @farey;
    my($s, $t, $u, $v, $x, $y) = (0, 1, 1, $order, 0, 0);
    push @farey, "$s/$t", "$u/$v";
    while($y != 1 && $order > 1){
        $x = POSIX::floor(($t + $order) / $v) * $u - $s;
        $y = POSIX::floor(($t + $order) / $v) * $v - $t;
        push @farey, "$x/$y";
        ($s, $t, $u, $v) = ($u, $v, $x, $y);
    }
    return @farey;
}

sub mertens{
    my($n) = @_;
    my @farey = farey($n);
    my $mertens = 0;
    map {$mertens += exp(2 * M_PI * i * eval($_))} @farey;
    $mertens += -1;
    return Re($mertens);
}

sub moebius{
    my($n) = @_;
    return 1 if $n == 1;
    return sprintf("%.f", (mertens($n) - mertens($n - 1)));
}

MAIN:{
    map {print moebius($_) . "\n"} (5, 10, 20);
}
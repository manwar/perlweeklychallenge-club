use v6;
constant @fact = 1, |[\*] 1..* ;
subset BigInt of Int where * ≥ 2000;

multi trailing-zeroes ( $n ) {
    @fact[$n].match(/0*$/).chars
}

multi trailing-zeroes ( BigInt $n ) {
    trailing-zeroes-of-bigint($n)
}

sub trailing-zeroes-of-bigint ( $n ) {
    state @coeficient = [\+] 0, {5**$++} ... *;
    [+] $n.polymod(5 xx *) Z* @coeficient
}

multi MAIN ($n) {
    my $fact = $n ~~ BigInt ?? "$n!" !! "$n! = @fact[$n]";
    say "$fact has {trailing-zeroes($n)} trailing zeroes"
}

multi MAIN (:$test! ) {
    use Test;
    is trailing-zeroes(10), 2;
    is trailing-zeroes(7),  1;
    is trailing-zeroes(4),  0;
    is trailing-zeroes-of-bigint(10), 2;
    is trailing-zeroes-of-bigint(7),  1;
    is trailing-zeroes-of-bigint(4),  0;
    is trailing-zeroes-of-bigint($_), trailing-zeroes($_) for ^2000 .pick(20);
    done-testing;
}

use v6;

my @primes = grep {.is-prime}, 1..*;

sub prime-factors (UInt $num-in) {
    my @factors;
    my $num = $num-in;
    for @primes -> $div {
        while ($num %% $div) {
            push @factors, $div;
            $num div= $div;
        }
        return @factors if $num == 1;
    }
    push @factors, $num unless $num == $num-in;
    return @factors;
}
say "$_: ", prime-factors($_).join(" ") for
    grep {prime-factors($_).elems.is-prime}, 1..50;

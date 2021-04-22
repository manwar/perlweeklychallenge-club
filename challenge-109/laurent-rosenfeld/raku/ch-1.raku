use v6;

sub chowla (Int $n) {
    return 0 if $n < 2 or $n.is-prime;
    return (2..$n div 2).grep({$n %% $_}).sum;
}
say "$_\t", chowla $_ for 1..20;

use v6;

sub divisors (Int $num) {
    return 1, | grep { $num %% $_ }, 2 .. (1 + ($num / 2).Int);
}

for 2..10000 -> $num {
    my @divisors = divisors $num;
    say "$num: ", @divisors if $num == [+] @divisors;
}

use v6;

sub sum-divisors (Int $num) {
    my @divisors = grep { $num %% $_ }, 2..($num / 2).Int;
    return [+] 1, | @divisors;
}

for 2..Inf -> $i {
    my $sum_div = sum-divisors $i;
    if $sum_div > $i and $i == sum-divisors $sum_div {
        say "$i and $sum_div are amicable numbers";
        last;
    }
}

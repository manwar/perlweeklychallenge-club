use v6;

for 2..10000 -> $num {
    my @divisors = 1, | grep { $num %% $_ }, 2 .. (1 + ($num / 2).Int);
    say "$num: ", @divisors if $num == [+] @divisors;
}



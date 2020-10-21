#!/usr/bin/env raku

sub flip-elems (@n) {
    my $sum = [+] @n;
    my @min_combination = @n;
    my $min_sum = Inf;
    K: for 1..@n.elems - 1 -> $k {
        for @n.combinations($k) -> @c {
            my $s = $sum - 2 * ([+] @c);
            if 0 <= $s < $min_sum {
                @min_combination = @c;
                $min_sum = $s;
                if $s == 0 {
                    last K;
                }
            }
        }
    }
    say ">> $min_sum = ([+] {@n}) - 2 * ([+] {@min_combination})";
    return @min_combination.elems;
}

# say flip-elems [2,13,10,8]; # 2
# say flip-elems [12,2,10]; # 1

say flip-elems @*ARGS;

#!/usr/bin/env raku

# Usage: ch-2.p6
# Output: The length of the 20 longest Collatz sequences from 1 to 1e6.

# 922524 => 445
# 922525 => 445
# 922526 => 445
# 938143 => 445
# 615017 => 447
# 410011 => 449
# 818943 => 450
# 820022 => 450
# 820023 => 450
# 546681 => 452
# 970599 => 458
# 767903 => 468
# 796095 => 468
# 511935 => 470
# 910107 => 476
# 927003 => 476
# 704623 => 504
# 939497 => 507
# 626331 => 509
# 837799 => 525

multi sub MAIN {
    my $length;
    my %seen;
    %seen{1} = 1;
    my @collatz;

    for (1 .. 1e6) -> $start {
        $length = 0;
        %seen{$start} = collatz($start);
        @collatz.push($start => %seen{$start});
    }

    .fmt("%-6s => %s").say 
        for @collatz.sort({$^a.value <=> $^b.value}).tail(20);

    sub collatz($n is copy) {
        if (%seen{$n}) {
            return $length + %seen{$n};
        }

        if $n %% 2 {
            $n = $n / 2; 
        }

        else {
            $n = 3 * $n + 1;
        }
       
        $length++;
        collatz($n);
    }
}

# Usage: ch-2.p6 23 
# Output: The length of the Collatz sequence followed by the sequence.
# 23 -> 70 -> 35 -> 106 -> 53 -> 160 -> 80 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
# length = 16

multi sub MAIN(UInt $num where $num > 0) {
    my @arr = collatz($num);
    say @arr.join(" -> ");
    say "length = {@arr.elems}";

    sub collatz($n is copy --> Array) {
        my @collatz;

        loop {
            @collatz.push($n);

            if ($n == 1) { 
                return @collatz;
            }

            if $n %% 2 {
                $n = $n / 2; 
            }

            else {
                $n = 3 * $n + 1;
            }
        }
    }
}

#!/usr/bin/env raku

# Usage: ch-2.p6
# Output: 

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

# I couldn't figure out the built-in memoize so I just did my
# own caching with the hash. 

# YMMV but on my computer...

# The hash brings the runtime from 800 seconds to 160 seconds.

# The exists adverb brings it down to 120 seconds.

# Keeping a current sorted array of the 20 largest items brings it 
# down to 95 seconds. (vs. sorting 1_000_000 items later)
multi sub MAIN {
    my $t = now;

    my %seen;
    %seen{1} = 1;
    my @collatz = (1 => 1) xx 20;

    for (1 .. 1e6) -> $start {
        my $n = $start;
        my $length = 0;

        loop {
            if %seen{$n}:exists {
                %seen{$start} = %seen{$n} + $length;

                if @collatz[0].value <= %seen{$start} {
                    @collatz.shift;
                    @collatz.push($start => %seen{$start});
                    @collatz = @collatz.sort({$^a.value <=> $^b.value});
                }
               
                last;
            }

            $n = $n %% 2 ?? $n / 2 !! 3 * $n + 1;
            $length++;
        }
    }    

    .say for @collatz;

    say now - $t;
}

# Usage: ch-2.p6 23 
# Output: 
# 23       70       35       106      53       160     
# 80       40       20       10       5        16      
# 8        4        2        1       

# length = 16
multi sub MAIN(Numeric $n is copy where $n > 0) {
    my @collatz = ($n);

    loop {
        last if $n == 1;
        $n = $n %% 2 ?? $n / 2 !! 3 * $n + 1;
        @collatz.push($n);
    }
 
    .fmt("%-8d").say for @collatz.rotor(6, :partial);
    say "\nlength = {@collatz.elems}";
}

#!/usr/bin/env raku

# Usage: ch-2.p6
# Output: The length of the 20 longest Collatz sequences from 1 to 1e6.

# 10971  => 268
# 13255  => 276
# 17647  => 279
# 17673  => 279
# 23529  => 282
# 26623  => 308
# 34239  => 311
# 35497  => 311
# 35655  => 324
# 52527  => 340
# 77031  => 351
# 106239 => 354
# 142587 => 375
# 156159 => 383
# 216367 => 386
# 230631 => 443
# 410011 => 449
# 511935 => 470
# 626331 => 509
# 837799 => 525

# I implemented my own "memoize" with the seen hash.
# With memoize this program takes about about 90 seconds to run on my pc.
# Without memoize it takes about 9 and 1/2 minutes.

multi sub MAIN {
    my $elems; 
    my @twenty = (1 => 1) xx 20;
    state %seen;

    for (1 .. 1e6) -> $start {
        $elems = 0;
        my $c = collatz_elems($start);
        %seen{$start} = $c;

        if (@twenty[0].value <= @twenty[19].value <= $c+1) {
            @twenty.shift;
            @twenty.push($start => $c+1);
            @twenty = @twenty.sort({$^a.value <=> $^b.value});
        }
    }

    for @twenty -> $pair {
        say $pair.fmt("%-6s => %s");
    }

    sub collatz_elems($n is copy --> UInt) {
        if (%seen{$n}) {
            return (%seen{$n} + $elems);
        }
 
        if ($n == 1) { 
            return $elems;
        }

        if $n %% 2 {
            $n = $n / 2; 
        }

        else {
            $n = 3 * $n + 1;
        }

        $elems++;
        collatz_elems($n);
    }
}

# Usage: ch-2.p6 23 
# Output: The length of the Collatz sequence followed by the sequence.
# length = 16
# 23 -> 70 -> 35 -> 106 -> 53 -> 160 -> 80 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1

multi sub MAIN(UInt $num where $num > 0) {
    my @arr = collatz_array($num);
    say "length = {@arr.elems}";
    say @arr.join(" -> ");

    sub collatz_array($n is copy --> Array) {
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

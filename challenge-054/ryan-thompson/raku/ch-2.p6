#!/usr/bin/env perl6

# ch-2.p6 - Collatz Conjecture, extra credit
#
# Ryan Thompson <rjt@cpan.org>

my $top-n   = 20;   # Number of top sequences to list
my $limit   = 1e6;  # Highest starting number
my $mintop  = 0;    # Minimum value in @top (efficiency/convenience)

my @top     = 0 => 0, 1 => 1; # Top N list (start => seq-len)
my @memo    = (0, 1);  # Memoization (@memo[start] = seq-len)

#| Non extra-credit Collatz sequence
sub collatz( Int $n is copy ) {
    my @r = $n;
    while ( $n ≠ 1 ) {
        $n = $n %% 2 ?? ($n / 2).Int !! (3*$n + 1).Int;
        @r.push: $n;
    }
    @r;
}

# Iterate through all starting numbers
for 3..$limit -> $start {
    my Int $n = $start;
    my Int $len = 0;

    # Keep going through the sequence until we hit a memoized value
    while (!@memo[$n]) {
        $len += 1 + $n % 2;
        $n = $n %% 2 ?? ($n / 2).Int !! ((3*$n + 1) / 2).Int;
    }

    $len += @memo[$n];
    @memo[$start] = $len if $start < $limit * 2;
    
    # If the $len is better than the worst value in @top, add it
    top($start, $len)          if  $len > $mintop and $start ≤ $limit;
    top($n * 2, @memo[$n] + 1) if $n ≤ $limit / 2 and @memo[$n] > $mintop;
}

printf "Start: %6d has %4d steps\n", .key, .value for @top;

#| O(n) insert $n => $len into @top
sub top(Int $n, Int $len) {
    my $idx = @top.keys.first: { @top[$_].value < $len };
    @top.splice: $idx.Int, 0, $n => $len;
    @top.pop if @top > $top-n;
    $mintop = @top[*-1].value;
}

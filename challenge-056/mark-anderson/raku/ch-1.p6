#!/usr/bin/env raku

# Usage:   raku ch-1.p6 @N $k
# Example: raku ch-1.p6 2 7 9 2
# Output:  2,1

sub MAIN(*@ARGV where @ARGV.all ~~ /^\d+$/) {
    my $k = @ARGV.pop;

    for @ARGV.keys.combinations: 2 -> ($i, $j) {
        say "$j,$i" if @ARGV[$j] - @ARGV[$i] == $k;
    }
} 

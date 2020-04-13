#!/usr/bin/env raku

# Usage:   perl ch-1.pl @N $k
# Example: perl ch-1.pl 2 7 9 2
# Output:  2,1

sub MAIN(*@ARGV where @ARGV.all ~~ /\d/) {
    my $k = @ARGV.pop;

    for @ARGV.keys.combinations: 2 -> $list {
        my ($i, $j) = $list;
        say "$j,$i" if @ARGV[$j] - @ARGV[$i] == $k;
    }
} 

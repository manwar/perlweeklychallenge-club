#!/usr/bin/perl6

sub LongestCommonSubstring(*@strings) {
    @strings = @strings.sort(*.chars);

    my $shortest = @strings.shift;
    my @substrings;    
    for 0 ..^ $shortest.chars -> $i {
        for $i ..^ $shortest.chars -> $j {
            @substrings.push($shortest.substr($i, $j - $i + 1));
        }
    }

    return @substrings.sort(-*.chars)
                    .grep({ @strings.all.contains($_) })
                    .first;
}

say LongestCommonSubstring('ABABC', 'BABCA', 'ABCBA');

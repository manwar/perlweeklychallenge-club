#!/usr/bin/env raku

# Usage:
# raku ch-2.raku aabbababba

# Output:
# aa bbababb
# aa bb aba bb
# abbababba
# abba bab
# babab
# bab abba

sub MAIN(Str $str) {
    my %seen;

    my @matches = gather ($str ~~ m:ex /(\w ** 2..*) <?{ $0 eq $0.flip }>/)>>.take;

    for @matches -> $match { 
        next if %seen{$match.from ~ " " ~ $match.to}:exists;

        my @arr = [$match];

        while @arr {
            my @a = @arr.shift;

            my @m = @matches.grep(@a[*-1].to == *.from);

            if @m ~~ Empty {
                say @a>>.flat.Str;
            }

            else {
                for @m -> $m {
                    @arr.push: [@a, $m];
                    %seen{$m.from ~ " " ~ $m.to} = 1;
                }
            }
        }
    }
}

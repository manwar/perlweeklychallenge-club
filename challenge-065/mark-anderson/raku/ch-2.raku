#!/usr/bin/env raku

# Usage: 
# raku ch-2.raku aabbababba 

# Output:
# aa bbababb
# bb aba bb
# abbababba
# abba bab
# babab
# bab abba

my @matches;

sub MAIN(Str $str) {
    @matches = gather ($str ~~ m:ex /(\w ** 2..*) <?{ $0 eq $0.flip }>/)>>.take;

    partition([$_]) for @matches;
}

sub partition(@arr) { 
    state %seen;

    my $match = @arr[*-1];

    unless %seen{$match.from ~ " " ~ $match.to}:exists {
        %seen{$match.from ~ " " ~ $match.to} = 1;
    
        my @m = @matches.grep($match.to == *.from);

        if @m {
            partition(@arr.push: $_) for @m;
        }

        else {
            say @arr>>.flat.Str;
            @arr = Empty;
        }
    }
}

#!/usr/bin/perl6
sub search($S, @W) {
    my @results;

    for @W -> $word {
        if $S ~~ /$word/ { 
            @results.push($word);
        } 
    }
    return @results.elems ?? @results.join(', ') !! 0;
}

say search("perlweeklychallenge", ["weekly", "challenge", "perl"]);
say search("perlandraku", ("python", "ruby", "haskell"));

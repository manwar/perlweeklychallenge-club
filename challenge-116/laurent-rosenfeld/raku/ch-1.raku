use v6;

sub num-seq (Int $in) {
    MATCH: for $in ~~ m:ex/^(\d+)+$/ -> $m {
        my @match = $m[0].map({~$_}); # stringify the match object
        next MATCH if @match.elems < 2;
        for 1..@match.end -> $i {
            next MATCH if @match[$i] ~~ /^0/ or # remove a match starting with 0
                @match[$i] - @match[$i - 1] != 1;
        }
        return @match;
    }
    return $in
}

for <1234 91011 10203> -> $test {
    say join ', ', num-seq $test;
}

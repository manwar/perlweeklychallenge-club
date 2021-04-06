#!/usr/bin/env raku

sub is-self-descriptive($num){
    my @l = $num.Str.comb;
    for @l.kv -> $i, $d {
        my $occurances = @l.grep(/$i/).elems;
        return False if $occurances != $d;
    }
    return True;
}

sub MAIN() {
    my @sd-list = lazy gather for (^Inf) {
        take $_ if is-self-descriptive($_);
    }
    say @sd-list[^3].join(",");
}

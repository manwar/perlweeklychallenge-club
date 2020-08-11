#!/usr/bin/env raku

sub word-break($string, $words) {
        my @ans;
        recursive-helper($string, $words, (), @ans);
        return @ans;
}

sub recursive-helper($string, $words, $accum, @ans) {
        unless $string {
                @ans.push($accum);
                return;
        }
        for $words.list {
                recursive-helper($string.substr(.chars), $words, (|$accum, $_), @ans) if $string.starts-with($_);
        }
}

say word-break("perlweeklychallenge", <weekly challenge perl>);
say word-break("perlandraku", <python ruby haskell>);

#multiple solutions
say word-break("perlandraku", <perl perland raku and>);

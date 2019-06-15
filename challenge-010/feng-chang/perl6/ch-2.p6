#!/bin/env perl6

sub jaro-similarity(Str $s1, Str $s2) returns Num {
    my Int $s1-len = $s1.chars;
    my Int $s2-len = $s2.chars;
    my Int $d      = max($s1-len, $s2-len) div 2 - 1;

    my Int $m   = 0;        # matching characters
    my Str @as1 = $s1.comb;
    my Str $ms1 = '';       # string made up of matching characters from s1
    for 0 .. $s1-len - 1 -> Int $i {
        if $s2.substr(max(0, $i - $d) .. min($s2-len, $i + $d)).contains(@as1[$i]) {
            ++$m;
            $ms1 ~= @as1[$i];
        }
    }

    return 0e0 if $m == 0;

    my Str @as2 = $s2.comb;
    my Str $ms2 = '';       # string made up of matching characters from s2
    for 0 .. $s2-len - 1 -> Int $i {
        $ms2 ~= @as2[$i] if $s1.substr(max(0, $i - $d) .. min($s1-len, $i + $d)).contains(@as2[$i]);
    }

    my Int $nt = 0;
    for $ms1.comb Z $ms2.comb -> $p {
        ++$nt if $p[0] eq $p[1];
    }

    return 1e0 / 3 * ($m / $s1-len + $m / $s2-len + $nt / $m);
}

sub jaro-winkler-similarity(Str $s1, Str $s2) returns Num {
}

my $sim-j = jaro-similarity('CRATE', 'TRACE');

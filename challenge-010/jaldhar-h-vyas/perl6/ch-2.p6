#!/usr/bin/perl6

sub prefix(Str $string1, Str $string2) {
    my @prefix1 = $string1.comb;
    my @prefix2 = $string2.comb;
    my $result = 0;

    for 0 .. 3 -> $i {
        if (@prefix2[$i].defined && @prefix1[$i] eq @prefix2[$i]) {
            $result++;
        } else {
            last;
        }
    }
    return $result;
}

sub jaroSimilarity(Str $string1, Str $string2) {
    my Str $string2Copy = $string2;
    my $m = 0; # matches
    my $t = 0; # transpositions
    my $near = $string1.chars / 2 - 1;
    my @chars = $string1.comb;

    for 0 .. @chars.elems - 1 -> $i {
        my $pos = $string2Copy.index(@chars[$i]);
        if $pos.defined {
            $m++;
            if abs($pos - $i) > $near {
                $t++;
            }
            $string2Copy.substr-rw($pos, 1) = ' '; # prevent using same char twice.
        }
    }
    $t /= 2;

    return $m
      ?? 1/3 * ($m / $string1.chars + $m / $string2.chars + ($m - $t) / $m)
      !! 0;
}

sub jaroWinklerSimilarity(Str $string1, Str $string2) {
    my $j = jaroSimilarity($string1, $string2);

    return $j + (prefix($string1, $string2) * 0.1) * (1 - $j);
}

sub jaroWinklerDistance(Str $string1, Str $string2) {
    return 1 - jaroWinklerSimilarity($string1, $string2);
}

sub swap(Str $s1, Str $s2) {
    return (max($s1.chars, $s2.chars) ~~ $s1.chars) ?? ($s1, $s2) !! ($s2, $s1);
}

multi sub MAIN(
    Str $arg1,   #= First string to compare.
    Str $arg2    #= Second string to compare.
) {
    my ($string1, $string2) = swap($arg1, $arg2);
    say jaroWinklerDistance($string1, $string2);
}
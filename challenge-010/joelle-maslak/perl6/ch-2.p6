#!/usr/bin/env perl6
use v6;

# Assumption: case doesn't matter

sub MAIN(Str:D $s1, Str:D $s2, Rat:D $p = 0.1) {
    say jaro-winkler-distance($s1.fc, $s2.fc, $p);
}

sub jaro-winkler-distance(Str:D $s1, Str:D $s2, $p -->Cool:D) {
    my $jaro-distance   = jaro-distance($s1, $s2);
    my $jaro-similarity = 1 - $jaro-distance;

    # compute prefix length similarity
    my $min-len = ($s1.chars, $s2.chars).min; 
    my $prefix-len = $min-len < 4 ?? $min-len !! 4;
    my $l = (0..$prefix-len).reverse.first: { $s1.substr(0,$^a) eq $s2.substr(0,$^a) };
    
    my $jw-similarity = $jaro-similarity + ($l * $p * $jaro-distance);
    return 1 - $jw-similarity; # Distance
}

multi sub jaro-distance(Str:D $s1, Str:D $s2 where { $s2 eq $s1 } -->Cool:D) { 0 }
multi sub jaro-distance(Str:D $s1, Str:D $s2                      -->Cool:D) {
    my @s1 = $s1.comb;
    my @s2 = $s2.comb;

    my @s1-matches = @s1.map: { Nil };
    my @s2-matches = @s2.map: { Nil };
   
    my $max-len    = ($s1.chars, $s2.chars).max; 
    my $match-dist = ($max-len / 2).floor - 1;
    $match-dist = 0 if $match-dist < 1;

    # Get matches
    loop (my $i=0; $i < $s1.chars; $i++) {
        my $start = $match-dist ≤ $i ?? $i - $match-dist !! 0;
        my $end   = $i + $match-dist < $s2.chars ?? $i + $match-dist !! $s2.chars - 1;

        loop (my $j=$start; $j ≤ $end; $j++) {
            next if @s2-matches[$j].defined;
           
            if @s1[$i] eq @s2[$j] {
                @s1-matches[$i] = @s1[$i];
                @s2-matches[$j] = @s2[$j];
                last;
            }
        }
    }

    # Get rid of non-matching characters.
    @s1-matches = @s1-matches.grep( *.defined );
    @s2-matches = @s2-matches.grep( *.defined );

    my $m = @s1-matches.elems;
    return 1 if $m == 0;  # We have no matches.

    # Get transpositions
    my $t = 0;
    loop (my $x=0; $x < $m; $x++) {
        $t += .5 if @s1-matches[$x] ne @s2-matches[$x];
    }

    my $jaro-similarity = ( 1/3 * ( $m/$s1.chars + $m/$s2.chars + ($m-$t)/$m ) );
    my $jaro-difference = 1 - $jaro-similarity;

    return $jaro-difference;
}

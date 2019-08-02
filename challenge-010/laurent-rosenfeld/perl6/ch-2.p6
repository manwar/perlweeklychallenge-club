use v6;

sub simjaro (Str $str1, Str $str2) {
    my $len1 = $str1.chars;
    my $len2 = $str2.chars;
    my $dmax = (max($len1, $len2) / 2).Int -1;
    my @st1 = $str1.comb;
    my $i = 0;
    my @matches;
    for $str2.comb -> $letter {
        push @matches, $letter if (grep { $letter eq $_ },
            @st1[max(0,$i-$dmax)..min($i+$dmax,$len1-1)]);
        $i++;
    }
    my $nb_matches = @matches.elems;
    return 0 if $nb_matches == 0;
    my %matching_letters = map { $_ => 1}, @matches;
    my @matches_str1 = grep { %matching_letters{$_}:exists },
        $str1.comb;
    my $disorder = 0;
    for 0..$nb_matches-1 -> $i {
        $disorder++ if @matches[$i] ne @matches_str1[$i];
    }
    my $transposition = $disorder / 2;
    return ($nb_matches / $len1 + $nb_matches / $len2 +
        ($nb_matches - $transposition)/$nb_matches) / 3;
}
sub simwinkler (Str $str1, Str $str2) {
    my $p_constant = 0.1;
    my $length_prefix = 0;
    for 0..3 -> $count {
        last if substr $str1, $count, 1 ne substr $str2, $count, 1;
        $length_prefix++;
    }
    my $simj = simjaro $str1, $str2;
    return $simj + $length_prefix * $p_constant * (1 - $simj);
}

my @tests = < FOOB BARF   CRATE TRACE   CRATE CRATE   TRACE CRATE
    CREATE TRACT   DWAYNE DUANE >;
for @tests -> $w1, $w2 {
    my $simw = simwinkler $w1, $w2;
    say "Jaro-Winkler distance between $w1 and $w2 is: ", (1 - $simw).fmt("\t%.3f");
}

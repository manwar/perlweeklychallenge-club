#!/usr/bin/env perl6
use v6;

sub matching($s1,$s2) {
    my $d=floor(max($s1.chars,$s2.chars)/2)-1;
    ($s1.comb.pairs X $s2.comb.pairs).grep({ (abs($_[0].key.Int-$_[1].key.Int) <= $d) && ($_[0].value eq $_[1].value) }).map(*.[0]).unique.map(*.value)
}

sub trnsp($s1,$s2) { (matching($s1,$s2) Z matching($s2,$s1)).map({ $_[0] ne $_[1] }).sum/2 }

sub jaro_sim($s1,$s2) {
    given my $m=matching($s1,$s2).[0].chars {
	when 0 { 0 }
	default { ($m/$s1.chars+$m/$s2.chars+($m - trnsp($s1,$s2))/($m))/3 }
    }
}

sub jw_sim($s1,$s2,$p,$max_pref) {
    my $pref_len=min($max_pref, ((0..^$s1.chars).first({ $s1.substr(0..$_) ne $s2.substr(0..$_) }) // $s1.chars));
    my $js=jaro_sim($s1,$s2);
    $js+$pref_len*$p*(1-$js)
}

sub jw_dist($s1,$s2,$p,$max_pref) {1-jw_sim($s1,$s2,$p,$max_pref)}

say jw_dist(|@*ARGS[0,1], .1, 4)

=finish
run as <script> <string1> <string2>
see

https://files.eric.ed.gov/fulltext/ED325505.pdf

for a clearer description of matching/transpositions by Winkler (clearer than Wikipedia's, that is)

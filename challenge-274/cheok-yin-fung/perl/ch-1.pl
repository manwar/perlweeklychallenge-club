# The Weekly Challenge 274
# Task 1 Goat Latin
use v5.30.0;
use warnings;

sub gl {
    my $sent = $_[0];
    my @words = split " ", $sent;
    for my $i (0..$#words) {
        $words[$i] = trf($words[$i]) . "a" x ($i+1);
    }
    return join " ", @words;

}

sub trf {
    my $word = $_[0];
    if ($word =~ /^[aeiou]/i) {
        $word .= "ma";
    } 
    else {
        $word = substr($word,1).substr($word,0,1)."ma";
    }
    return $word;
}

use Test::More tests=>3;
ok gl("I love Perl") eq "Imaa ovelmaaa erlPmaaaa";
ok gl("Perl and Raku are friends") 
            eq 
    "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa";
ok gl("The Weekly Challenge")
            eq
    "heTmaa eeklyWmaaa hallengeCmaaaa";

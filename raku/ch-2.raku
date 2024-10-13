#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
289-2: Jumbled Letters              Submitted by: Ryan Thompson

Your task is to write a program that takes English text as its input and outputs a jumbled version as follows:

The first and last letter of every word must stay the same
The remaining letters in the word are scrambled in a random order (if that happens to be the original order, that is OK).
Whitespace, punctuation, and capitalization must stay the same
The order of words does not change, only the letters inside the word
So, for example, “Perl” could become “Prel”, or stay as “Perl,” but it could not become “Pelr” or “lreP”.
=end comment

my @T-upper =
    "'",        "'",
    '_&&\$',    '_&&\$',
    'tc',       'tc',
    'ten',      'tEn',          
    'hell',     'hELl',
    ' a',       ' a',  
    'a ',       'a ',  
    ' a ',      ' a ',  
    'a b',      'a b',
    ' a b',     ' a b',  
    ' a b ',    ' a b ',  
    'a b c d',          'a b c d',  
    ' a b c d',         ' a b c d',  
    'a b c d ',         'a b c d ',  
    ' a b c d ',        ' a b c d ',  
    '%a"b-c,d<e.',      '%a"b-c,d<e.',  

    'isn\'t it a grandiosity', 'iSn\'t it a gRANDIOSITy',
    'isn\'t it a grand-iosity', 'iSn\'t it a gRANd-iOSITy',
    'isn\'t it a grand\iose city', 'iSn\'t it a gRANd\iOSe cITy',
;

my @T-alf =
    "Hello my name is Jonas Saul Jones.",
    rx/H [ell|lel|lle] "o my n" [am | ma] "e is J" [ona|oan|nao|noa|ano|aon]
        "s S" [au|ua] "l J" [one|oen|neo|noe|eno|eon] "s." /,
;

plan @T-upper ÷ 2 + @T-alf ÷ 2;

constant $min = 3; # minimum length of 'word' to alter.

sub ctr-jumble( $str is copy -->Str) {
    my @a = $str.comb;
    my ($pref, $suff) = @a.shift, @a.pop;
    $pref ~ @a.pick( +@a).join ~ $suff;
}
sub ctr-uc( $str -->Str) {
    my @a = $str.comb;
    my ($pref, $suff) = @a.shift, @a.pop;
    @a = @a>>.uc;
    $pref ~ @a.join ~ $suff;
}

sub task( $str, &alter = &ctr-jumble ) {
    my @a = $str.split: :v, / <:L>**{$min..*}/; #??? undoc interpotation syn
    my $ret;
    for @a -> $s {
        if $s ~~ Str { $ret ~= $s }
        elsif $s ~~ Match {
            $ret ~= &alter( $s.Str);
        } else { die "It's the programmer's fault." }
    }
    return $ret;
}

for @T-upper -> $in, $exp {
     is task($in, &ctr-uc ), $exp, "uc $in";
}
for @T-alf -> $in, $exp {
    my $got = task($in, &ctr-jumble ); 
    ok $got ~~ $exp, "jumbled $got";
}
done-testing;



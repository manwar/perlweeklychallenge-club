#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
278 1: Sort String      Submitted by: Mohammad Sajid Anwar

    XXX my translation XXX

Given a shuffled string, $str, return the ordered string.  The shuffled
string is unshuffled by using the position number appended to each word.

Example 1
Input: $str = "and2 Raku3 cousins5 Perl1 are4"
Output: "Perl and Raku are cousins"
Example 2
Input: $str = "guest6 Python1 most4 the3 popular5 is2 language7"
Output: "Python is the most popular guest language"
Example 3
Input: $str = "Challenge3 The1 Weekly2"
Output: "The Weekly Challenge"
=end comment

my @Test =
    #in /exp
    "and2 Raku3 cousins5 Perl1 are4",
        "Perl and Raku are cousins",
    "guest6 Python1 most4 the3 popular5 is2 language7",
        "Python is the most popular guest language",
    "Challenge3 The1 Weekly2",
        "The Weekly Challenge",
    (  "More1 than2 the3 average4 butterfly5 by6 ceiling,7"
     ~  " range8 and9 load10 capacity.11"
     #).split(' ').pick(*).join(' '),
    ).&shuffle,
        "More than the average butterfly by ceiling, range and load capacity."
;
my @Die = Str, '', '1', '1a', 'a', 'ab', '1a1', 'a1a', 'a2', 'a1b3';

plan @Test ÷ 2 + @Die;;

sub shuffle( Str $str -->Str) { $str.split(' ').pick(*).join(' ') }

multi task( Any:D $in where * eq '' ) { die 'Error: Zero length.' }
multi task( Any:D $in -->Str) {
    my @ordered-word;
    for $in.words {
        if so $_ ~~ / ^ $<w> = [\D+]   $<k> = [\d+] $ / {
            @ordered-word[$<k>.Int - 1] = $<w>.Str;
        } else {
            die qq{Error: "$_" is malformed.};
        }
    }
    die 'Error: Bad sequencing.' unless @ordered-word.all.defined;
    @ordered-word.join: ' ';
}

for @Test -> $in, $exp { is task($in), $exp, "$exp <- $in"; }

for @Die -> $in { dies-ok { task $in }, "Died <- " ~  ( $in // "(Str)"); }

done-testing;

my $str = (  "More1 than2 the3 average4 butterfly5 by6 ceiling,7 range8"
     ~  " and9 by10 carrying11 phasers.12").&shuffle;

say "\nInput: \$str = $str.raku()\nOutput: &task( $str).raku()";


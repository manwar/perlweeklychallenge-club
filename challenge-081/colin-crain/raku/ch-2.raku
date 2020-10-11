#!/usr/bin/env perl6
# 
#
#       bag-o-sharks.raku
#
#         TASK #2 › Frequency Sort
#         Submitted by: Mohammad S Anwar
#         You are given file named input.
# 
#         Write a script to find the frequency of all the words.
# 
#         It should print the result as first column of each line should be the
#         frequency of the the word followed by all the words of that frequency
#         arranged in lexicographical order. Also sort the words in the
#         ascending order of frequency.
# 
#         INPUT file
# 
#         West Side Story
# 
#         The award-winning adaptation of the classic romantic tragedy "Romeo
#         and Juliet". The feuding families become two warring New York City
#         gangs, the white Jets led by Riff and the Latino Sharks, led by
#         Bernardo. Their hatred escalates to a point where neither can coexist
#         with any form of understanding. But when Riff's best friend (and
#         former Jet) Tony and Bernardo's younger sister Maria meet at a dance,
#         no one can do anything to stop their love. Maria and Tony begin
#         meeting in secret, planning to run away. Then the Sharks and Jets plan
#         a rumble under the highway--whoever wins gains control of the streets.
#         Maria sends Tony to stop it, hoping it can end the violence. It goes
#         terribly wrong, and before the lovers know what's happened, tragedy
#         strikes and doesn't stop until the climactic and heartbreaking ending.

#         NOTE
#         For the sake of this task, please ignore the following in the input file:
#                 . " ( ) , 's --
# 
#         OUTPUT
#         1 But City It Jet Juliet Latino New Romeo Side Story Their Then West
#         York adaptation any anything at award-winning away become before begin
#         best classic climactic coexist control dance do doesn't end ending
#         escalates families feuding form former friend gains gangs goes
#         happened hatred heartbreaking highway hoping in know love lovers meet
#         meeting neither no one plan planning point romantic rumble run secret
#         sends sister streets strikes terribly their two under understanding
#         until violence warring what when where white whoever wins with wrong
#         younger
# 
#         2 Bernardo Jets Riff Sharks The by it led tragedy
# 
#         3 Maria Tony a can of stop
# 
#         4 to
# 
#         9 and the
# 
#         method:
#             a bit of NLP for you all. A naive bag of words output by
#             frequency. We'll start by pretreating the data: scrub certain
#             defined punctuation and possessive case into spaces, and lowercase
#             normalize all text. WE will make sure to keep a single hyphen. We
#             won't be doing any name recognition so the we won't worry about
#             losing capitalization for those entities here and concern
#             ourselves rather with making sure "their" and "Their" get counted
#             as the same word. This is of course a judgement call and not
#             specified behavior but seems fitting to this basic word analysis. 
# 
#             Consequently the output is slightly different as, for instance,
#             'their' is moved to the second category, and the output is
#             actually in lexicographic order as requested, rather than the
#             example ASCII sort with capital letters first. 
# 
#             Next-level improvements on this method might be begin to identify
#             Named Entities by selectively removing the capitalization of
#             letters only at beginning of sentences, that is to say after a
#             period or certain punctuation, or at the beginning of a paragraph
#             or quote. Then unusually capitalized words could be identified in 
#             the corpus on basis of their grammarical uniqueness. 
# 
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

my $input = q:to/__END__/;
    West Side Story

    The award-winning adaptation of the classic romantic tragedy "Romeo
    and Juliet". The feuding families become two warring New York City
    gangs, the white Jets led by Riff and the Latino Sharks, led by
    Bernardo. Their hatred escalates to a point where neither can coexist
    with any form of understanding. But when Riff's best friend (and
    former Jet) Tony and Bernardo's younger sister Maria meet at a dance,
    no one can do anything to stop their love. Maria and Tony begin
    meeting in secret, planning to run away. Then the Sharks and Jets plan
    a rumble under the highway--whoever wins gains control of the streets.
    Maria sends Tony to stop it, hoping it can end the violence. It goes
    terribly wrong, and before the lovers know what's happened, tragedy
    strikes and doesn't stop until the climactic and heartbreaking ending.
    __END__

## preproc
$input ~~ s:g/ <[."(),]> | \'s | \-\- / /;
$input .= lc;
$input .= trim;

## freq analysis
my %freq;
for $input.split(/\s+/)
          .Bag
          .kv -> $key, $val {
    %freq{$val}.push: $key;
}

## out
for %freq.keys.sort({ $^a <=> $^b }) {
    say $_.fmt("%-5s") ~ %freq{$_}.sort.join("\n     ") ~ "\n";
}




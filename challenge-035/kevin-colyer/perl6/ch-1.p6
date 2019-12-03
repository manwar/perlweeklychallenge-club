#!/usr/bin/perl6
use v6;

use Test;

=begin pod
Task 35.1
Write a program to encode text into binary encoded morse code.
Pay attention to any changes which might need to be made to the text to make it valid morse code.
Morse code consists of dots, dashes and gaps. It can be encoded in binary in the following fashion:
dot: 1
dash: 111
intra-character gap: 0
character gap: 000
word gap: 0000000
An intra-character gap is inserted between the dots and dashes in a character.
=end pod

constant DOT = "1";
constant DASH = "111";
constant ICG = "0_";
constant CG = "000___";
constant WG = "   0000000\n";
# Morse
my %morse =
    'A' =>  '•−',
    'B' =>  '−•••',
    'C' =>  '−•−•',
    'D' =>  '−••',
    'E' =>  '•',
    'F' =>  '••−•',
    'G' =>  '−−•',
    'H' =>  '••••',
    'I' =>  '••',
    'J' =>  '•−−−',
    'K' =>  '−•−',
    'L' =>  '•−••',
    'M' =>  '−−',
    'O' =>  '−−−',
    'N' =>  '−•',
    'P' =>  '•−−•',
    'Q' =>  '−−•−',
    'R' =>  '•−•',
    'S' =>  '•••',
    'T' =>  '−',
    'U' =>  '••−',
    'V' =>  '•••−',
    'W' =>  '•−−',
    'X' =>  '−••−',
    'Y' =>  '−•−−',
    'Z' =>  '−−••',
    'Ä' =>  '•−•−',
    'Á' =>  '•−−•−',
    'Å' =>  '•−−•−',
    'Ch' => '−−−−', # There is no unicode code point for this. Will only use for decoding...
    'É' =>  '••−••',
    'Ñ' =>  '−−•−−',
    'Ö' =>  '−−−•',
    'Ü' =>  '••−−',
    '0' =>  '−−−−−',
    '1' =>  '•−−−−',
    '2' =>  '••−−−',
    '3' =>  '•••−−',
    '4' =>  '••••−',
    '5' =>  '•••••',
    '6' =>  '−••••',
    '7' =>  '−−•••',
    '8' =>  '−−−••',
    '9' =>  '−−−−•',
    #Punctuation Marks
    '.' =>  '•−•−•−',
    ',' =>  '−−••−−',
    ':' =>  '−−−•••',
    '?' =>  '••−−••',
    "'" =>  '•−−−−•',
    '-' =>  '−••••−',
    '/' =>  '−••−•',
    '(' =>  '−•−−•−', # note one code for open and close...
    ')' =>  '−•−−•−',
    '"' =>  '•−••−•',
    '@' =>  '•−−•−•',
    '=' =>  '−•••−',
    # Error ••••••••
    # space= WG - a long pause in morse
;

sub encodeBinaryMorse($text is copy, :$visualise=False) {
    $text=filterMorseInput($text);
    my Str $bm = '';
    my Str $last='';
    for $text.comb -> $a {
        if $a eq ' ' { $bm ~=WG; $last = $a; next }; # Word gap
        my $dd=%morse{$a};
        my Str $j = '';
        $bm ~= CG if $last !eq ' ' and $bm.chars > 0 ; # character gap
        # encode a single char
        for $dd.comb -> $i {
            $j ~= ICG if $j.chars>0 ; # intercharacter gap
            $j ~= $i eq "•" ?? DOT !! DASH ;
        };
        $bm ~= $j;
        $last=$a;
    }
    return $visualise ?? $bm !! $bm.trans([" ","\n","_"] => '');
}

sub filterMorseInput ($text) {
    # upper case and remove non-morse chars.
    return $text.uc.trans([%morse.keys," "] => '', :complement);
}

is filterMorseInput("abc 123 ?"),"ABC 123 ?","keeps good stuff";
is filterMorseInput("abcé 123 ?"),"ABCÉ 123 ?","keeps good stuff";
is filterMorseInput("abc\n!\\abc"),"ABCABC","filters bad stuff";
is encodeBinaryMorse("e", :visualise),DOT,"simple 1 char encoding";
is encodeBinaryMorse("a", :visualise),DOT~ICG~DASH,"simple 1 char encoding";
is encodeBinaryMorse("ea", :visualise),DOT~CG~DOT~ICG~DASH,"simple 2 char encoding";
is encodeBinaryMorse("eae", :visualise),DOT~CG~DOT~ICG~DASH~CG~DOT,"simple 3 char encoding";
is encodeBinaryMorse("sos", :visualise),DOT~ICG~DOT~ICG~DOT~CG~DASH~ICG~DASH~ICG~DASH~CG~DOT~ICG~DOT~ICG~DOT,"simple 3 char encoding";
is encodeBinaryMorse("e a", :visualise),DOT~WG~DOT~ICG~DASH,"simple 2 word encoding";

say encodeBinaryMorse("hello world");
# 101010100010001011101010001011101010001110111011100000001011101110001110111011100010111010001011101010001110101
done-testing;


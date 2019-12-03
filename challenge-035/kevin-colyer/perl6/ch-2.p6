#!/usr/bin/perl6
use v6;

use Test;

=begin pod
Task 35.2
Write a program to decode binary morse code.
Consider how it might be possible to recover from badly formed morse code.
a) by splitting the morse code on gaps
b) without looking further than one digit ahead
# grammar
# dot or dash
# dd icg dd (up to 6 dd's') = c
# c [cg c] = w
# w [wg w]
# code = w+
# special note on parenthesis...
=end pod

my %morse =
    '•−'    =>      'A',
    '−•••'  =>      'B',
    '−•−•'  =>      'C',
    '−••'   =>      'D',
    '•'     =>      'E',
    '••−•'  =>      'F',
    '−−•'   =>      'G',
    '••••'  =>      'H',
    '••'    =>      'I',
    '•−−−'  =>      'J',
    '−•−'   =>      'K',
    '•−••'  =>      'L',
    '−−'    =>      'M',
    '−−−'   =>      'O',
    '−•'    =>     'N',
    '•−−•'  =>      'P',
    '−−•−'  =>      'Q',
    '•−•'   =>      'R',
    '•••'   =>      'S',
    '−'     =>      'T',
    '••−'   =>      'U',
    '•••−'  =>      'V',
    '•−−'   =>      'W',
    '−••−'  =>      'X',
    '−•−−'  =>      'Y',
    '−−••'  =>      'Z',
    '•−•−'  =>      'Ä',
    '•−−•−' =>      'Á',
    '•−−•−' =>      'Å',
    '−−−−'   =>    'Ch',                     # Only used for decoding...
    '••−••' =>      'É',
    '−−•−−' =>      'Ñ',
    '−−−•'  =>      'Ö',
    '••−−'  =>      'Ü',
    '−−−−−' =>      '0',
    '•−−−−' =>      '1',
    '••−−−' =>      '2',
    '•••−−' =>      '3',
    '••••−' =>      '4',
    '•••••' =>      '5',
    '−••••' =>      '6',
    '−−•••' =>      '7',
    '−−−••' =>      '8',
    '−−−−•' =>      '9',
    #Punctuation Marks
    '•−•−•−' =>    '.',
    '−−••−−' =>    ',',
    '−−−•••' =>    ':',
    '••−−••' =>    '?',
    '•−−−−•' =>    "'",
    '−••••−' =>    '-',
    '−••−•'  =>    '/',
    '−•−−•−' =>    '(', # note one code for open and close...
    '•−••−•' =>    '"',
    '•−−•−•' =>    '@',
    '−•••−'  =>    '=',
    # Error ••••••••
;

constant DOT = "•";
constant DASH = "−";
constant SPACE = " ";
constant ERRMORSE = "!";


sub decodeBinaryMorseCode($bitstream is copy) {
    my $tokens="";
    # tokenise
    decodeMorse('',:start); # reset parens
    my $code="";
    my $text="";
    while $bitstream.chars>0 {
        # say "code [$code] text [$text] left:{$bitstream.chars}";
        if $bitstream.starts-with("0000000") { $text ~= decodeMorse($code) ~ SPACE; $code=""; $bitstream.=substr(7, *); next};
        if $bitstream.starts-with("000")     { $text ~= decodeMorse($code);         $code=""; $bitstream.=substr(3, *); next}; # ICG
        if $bitstream.starts-with("0")       { $bitstream.=substr(1, *); next}; # ICG
        if $bitstream.starts-with("111")     { $code~= DASH; $bitstream.=substr(3, *); next};
        if $bitstream.starts-with("11")      {
            # if we get here we have an unknown bit pattern.
            # which is even numbers of 1's. Can assume extra 0's are ICG's
            # try to flush code
            $text ~= decodeMorse($code);
            $code="";
            # attempt recovery by moving forward
            # say " Unrecognised code in bitstream. Advancing to next valid point.";
            $bitstream.=substr(2,*);
        };
        if $bitstream.starts-with("1")       { $code~= DOT; $bitstream.=substr(1, *); next};
    }
    $text~=decodeMorse($code) if $code.chars;
    return $text;
}

sub decodeMorse($code,:$start=False) {
    state $parens= True; # open parens = True, close = False;
    $parens = $start if $start; # start sentence reset parens
    return "" unless $code.chars;
    return ERRMORSE unless %morse{$code}:exists;
    my $t= %morse{$code};
    return $t unless $t eq '(';
    $t= $parens ?? '(' !! ')';
    $parens= ! $parens;
    return $t;
}

sub leftChop($t,$chars) {
    return '' if $t.chars <= $chars;
    return $t.substr($chars,*);
}

is leftChop("123",3),'','nothing left';
is leftChop("123",4),'','nothing left';
is leftChop("123",2),'3','one left';
is decodeMorse('−−−−'),'Ch',"decode morse ok";
is decodeMorse('••••••••'),ERRMORSE,"errors on non morse";
is decodeMorse('−•−−•−'),'(',"parens open";
is decodeMorse('−•−−•−',:start),'(',"parens open (restart)";
is decodeMorse('−•−−•−'),')',"parens close";
is decodeBinaryMorseCode('10'),'E',"E";
is decodeBinaryMorseCode('1110'),'T',"T";
is decodeBinaryMorseCode('000'),'',"inter character gap";
is decodeBinaryMorseCode('0000000'),' ',"space (word gap)";
is decodeBinaryMorseCode( "101010100010001011101010001011101010001110111011100000001011101110001110111011100010111010001011101010001110101"),"HELLO WORLD","HELLO WORLD decodes ok";
is decodeBinaryMorseCode( "101010100010100000001110101110111010111000101011101000101011100011101000111010111011101011100000001011101110001110111011100010111010001011101010001110101"), "HI (FUN) WORLD", "HI (FUN) WORLD decodes ok";
is decodeBinaryMorseCode( "101011"), "I", "recover from corrupt bitsream 1";
is decodeBinaryMorseCode( "101010001110111011100010101"), "SOS", "SOS";
is decodeBinaryMorseCode( "101010001111111011100010101"), "SQS", "SOS recover from corrupt bitsream 2";
# corruption is here -----------------^
is decodeBinaryMorseCode( "10101000111111011100010101"), "SOS", "SOS recover from corrupt bitsream 3";
# corruption is here -----------------^ dropped a bit
is decodeBinaryMorseCode( "1010100011111011100010101"), "STTS", "SOS recover from corrupt bitsream 3";
# corruption is here -----------------^ dropped two bits

say "\nRandom bit flips in HELLO WORLD";
for ^30 {
    my $hw="101010100010001011101010001011101010001110111011100000001011101110001110111011100010111010001011101010001110101";
my $i=$hw.chars.rand.Int;
    $hw.substr-rw($i,1)= $hw.substr($i,1) eq "1" ?? "0" !! "1";
    say "Flipped bit $i:" ~  decodeBinaryMorseCode($hw) ;
}

done-testing;


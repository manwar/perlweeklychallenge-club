#
# Perl Weekly Challenge - 035
# Task #1 and #2
# 
#
# Mark Senn, http://engineering.purdue.edu/~mark
# November 24, 2019
#
# From
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-035#task-1
#     Contributed by Paul Johnson
#     Write a program to encode text into binary encoded morse code.
#
#     Pay attention to any changes which might need to be made to the
#     text to make it valid morse code.
#
#     Morse code (see https://en.wikipedia.org/wiki/Morse_code)
#     consists of dots, dashes and gaps. It can be encoded in binary
#     in the following fashion:
#         dot: 1
#         dash: 111
#         intra-character gap: 0
#         character gap: 000
#         word gap: 0000000
#
#     An intra-character gap is inserted between the dots and dashes
#     in a character.
#
# This program converts text (variable name $plaintext) into binary
# encoded Morse code (variable name $ciphertext).
#

# Run using Raku v6.d;
use v6.d;

# Read the input from the command line.  If no input is given
# use the string "42 db".
my $plaintext = '42 db';
@*ARGS.elems  and  $plaintext = "{@*ARGS}";

# Based on information in
#     https://en.wikipedia.org/wiki/File:International_Morse_Code.svg
# I put a space between all dots and/or dashes to improve readability.
# This program only supports lowercase letters and digits.  Add more
# plaintext symbols here if you'd like.
my %plain2cipher =
    a => '. -',          b => '- . . .',      c => '- . - .',
    d => '- . .',        e => '.',            f => '. . - .',
    g => '- - .',        h => '. . . .',      i => '. .',
    j => '. - - -',      k => '- . -',        l => '. - . .',
    m => '- -',          n => '- .',          o => '- - -',
    p => '. - - .',      q => '- - . -',      r => '. - .',
    s => '. . .',        t => '-',            u => '. . -',
    v => '. . . -',      w => '. - -',        x => '- . . -',
    y => '- . - -',      z => '- - . .',      1 => '. - - - -',
    2 => '. . - - -',    3 => '. . . - -',    4 => '. . . . -',
    5 => '. . . . .',    6 => '- . . . .',    7 => '- - . . .',
    8 => '- - - . .',    9 => '- - - - .',    0 => '- - - - -';

# Replace %plain2cipher values with corresponding binary values.
for %plain2cipher.values -> $_ is rw  {
    s:g/'.'/1/;    # dot
    s:g/'-'/111/;  # dash
    s:g/' '/0/;    # intra-character gap
}

# Compute %cipher2plain from %plain2cipher.
my %cipher2plain = %plain2cipher.invert;


#
#  Convert plaintext to ciphertext.
#

"plaintext:  $plaintext".say;

# Replace character gap and word gap with out-of-band characters---if they
# were expanded to their binary values here they could interfere with
# with $plaintext data.
$_ = $plaintext;
my $cgoob = '!';  # character gap
my $wgoob = '@';  # word gap
s:g/(\S)<before \S>/$0$cgoob/;  # character gap
s:g/' '/$wgoob/;                # word gap

# Replace in-band characters in $_ with their binary equivalents.
my $ciphertext = '';
for .comb(/./)  {
    %plain2cipher{$_}:exists
    ??  ($ciphertext ~= %plain2cipher{$_})
    !!  ($ciphertext ~= $_);
}

# Replace the out-of-band characters with their binary equivalents
$ciphertext ~~ s:g/$cgoob/000/;
$ciphertext ~~ s:g/$wgoob/0000000/;

"ciphertext: $ciphertext".say;


#
#  Convert ciphertext to plaintext.
#

$_ = $ciphertext;
$plaintext = '';
my @word = .split(/0000000/);  # word gap
loop (my $i = 0;  $i < @word.elems;  $i++)  {
    $_ = @word[$i];
    my @char = .split(/000/);  # character gap
    for (@char)  {
        $plaintext ~= %cipher2plain{$_};
    }
    ($i < @word.elems - 1)  and  $plaintext ~= ' ';
}

"plaintext:  $plaintext".say;

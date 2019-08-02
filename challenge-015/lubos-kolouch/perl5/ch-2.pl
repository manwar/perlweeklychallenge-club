#!/usr/bin/perl 
#===============================================================================
#
#         FILE: 2019_15_2.pl
#
#        USAGE: ./2019_15_2.pl
#
#  DESCRIPTION: Perl Weekly challenge w15 #2
#  Write a script to implement Vigenère cipher. The script should be able
#  decode and encode. Checkout wiki page for more information.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 07/02/2019 09:47:38 PM
#     REVISION: ---
#===============================================================================

use warnings;
use strict;
use feature qw{ say };

sub encode_letter {
    my ($plain, $key) = @_;

    # calculate the shift for plain text
    my $shift_plain = ord($plain) - ord('A');

    # calculate the shift for key
    my $shift_key = ord($key) - ord('A');

    # calculate the resulting ASCII value
    my $result =  ord('A') + ($shift_plain  +  $shift_key) % (ord('Z')-ord('A')+1);

    return chr($result);
}

sub decode_letter {
    my ($key, $cypher) = @_;

    # calculate the shift for key
    my $shift_key = ord($key) - ord('A');

    # calculate the shift for cypher text
    my $shift_cypher = ord($cypher) - ord('A');

    # calculate the resulting ASCII value
    my $result =  ord('A') + ($shift_cypher  -  $shift_key) % (ord('Z')-ord('A')+1);

    return chr($result);
}


sub  encode_text {
    my $text = shift;
    my $key = shift;

    # convert the text to arrays for convenience, could be also done as string
    # with length

    my @text_a = split //, $text;
    my @key_a = split //, $key;

    my $result;

    for (0.. scalar @text_a -1) {
        my $letter = $text_a[$_];

        # encode each letter
        $result .= encode_letter($letter, $key_a[$_ % scalar @key_a]);
    }

    return $result;

}

sub  decode_text {
    my $text = shift;
    my $key = shift;

    # convert the text to arrays for convenience, could be also done as string
    # with length

    my @text_a = split //, $text;
    my @key_a = split //, $key;

    my $result;

    for (0.. scalar @text_a -1) {
        my $letter = $text_a[$_];

        # decode each letter
        $result .= decode_letter($key_a[$_ % scalar @key_a], $letter);
    }

    return $result;

}

# ------ MAIN STARTS HERE --------
my ($text, $key, $direction) = @ARGV;

die 'No text passed. Usage: script TEXT KEY DIRECTION("d" or "e")' unless $text;
die 'No key passed. Usage: script TEXT KEY DIRECTION("d" or "e")' unless $key;
die 'No direction passed. Usage: script TEXT KEY DIRECTION("d" or "e")' unless $direction;

$text = uc($text);
$key=uc($key);
$direction = uc($direction);

die 'direction must be d or e' unless $direction eq 'D' or $direction eq  'E';

say encode_text($text, $key) if ($direction eq 'E');
say decode_text($text, $key) if ($direction eq 'D');

# ----------- TESTS ----------
use Test::More;

is( encode_letter('A','A'),'A', 'test encode A-A' );
is( encode_letter('A','S'),'S', 'test encode A-S' );
is( encode_letter('C','C'),'E', 'test encode C-C' );
is( encode_letter('F','M'),'R', 'test encode F-M' );
is( encode_letter('O','Y'),'M', 'test encode O-Y' );
is( encode_letter('Y','L'),'J', 'test encode Y-L' );
is( encode_letter('Z','Z'),'Y', 'test encode Z-Z' );

is( decode_letter('A','A'),'A', 'test decode A-A' );
is( decode_letter('A','S'),'S', 'test decode A-S' );
is( decode_letter('C','C'),'A', 'test decode C-C' );
is( decode_letter('F','M'),'H', 'test decode F-M' );
is( decode_letter('O','Y'),'K', 'test decode O-Y' );
is( decode_letter('Y','L'),'N', 'test decode Y-L' );
is( decode_letter('Z','Z'),'A', 'test decode Z-Z' );
is( encode_text('ATTACKATDAWN', 'LEMON'), 'LXFOPVEFRNHR', 'Test encode ATTACKATDAWN LEMON');
is( decode_text('LXFOPVEFRNHR', 'LEMON'), 'ATTACKATDAWN', 'Test decode ATTACKATDAWN LEMON');
isnt( decode_text('LXFOPVEFRNHR', 'LEMON'), 'DTTACKATDAWN', 'Test decode ATTACKATDAWN LEMON');
isnt( encode_text('ATTACKATDAWN', 'LEMON'), 'OXFOPVEFRNHR', 'Test encode ATTACKATDAWN LEMON');
done_testing();

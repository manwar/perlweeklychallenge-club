#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-025/
# Task #2
# Create script to implement Chaocipher. Please checkout wiki page for more information.
# https://en.wikipedia.org/wiki/Chaocipher

use strict;
use warnings;

my $plain = shift || 'WELLDONEISBETTERTHANWELLSAID';

print "Ciphered text: ".encipher($plain).$/;
print "Deciphered text: ".decipher(encipher($plain)).$/;

# OUTPUT
# $ ./ch-2.pl
# Ciphered text: OAHQHCNYNXTSZJRRHJBYHQKSOUJY
# Deciphered text: WELLDONEISBETTERTHANWELLSAID

sub encipher {
    return chao($_[0],0);
}

sub decipher {
    return chao($_[0],1);
}

sub chao {
    my $text     = shift;
    my $decipher = shift;

    my ( $left , $right ) = ( get_left() , get_right() );

    my $ret = '';
    for my $c (split //, uc $text) {

        my $input = $decipher ? $left : $right;
        my $pos = index $input,$c;

        my $output = $decipher ? $right : $left;
        $ret .= substr $output,$pos,1;

        permute(\$left, $pos,0);
        permute(\$right,$pos,1);
    }
    return $ret;
}

sub get_left {
    return 'HXUCZVAMDSLKPEFJRIGTWOBNYQ'
};

sub get_right {
    return 'PTLNBQDEOYSFAVZKGJRIHWXUMC'
};

sub permute{
    my ($alpha,$pos,$right) = @_;

    #shift to zenith (right alphabet shifts one more)
    $$alpha = (substr $$alpha,$pos+$right) . (substr $$alpha,0,$pos+$right);

    #permute upto nadir (left alphabet starts at zenith+1, right one at zenith+2)
    $$alpha = (substr $$alpha,0,1+$right)
            . (substr $$alpha,2+$right,12-$right)
            . (substr $$alpha,1+$right,1)
            . (substr $$alpha,14);
}




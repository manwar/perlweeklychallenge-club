#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-035/
# Task #2
# Write a program to decode binary morse code.
# Consider how it might be possible to recover from badly formed morse code.
#
# a) by splitting the morse code on gaps
# b) without looking further than one digit ahead

use strict;
use warnings;

my %morse = (
    A => '.-',      N => '-.',
    B => '-...',    O => '---',
    C => '-.-.',    P => '.--.',
    D => '-..',     Q => '--.-',
    E => '.',       R => '.-.',
    F => '..-.',    S => '...',
    G => '--.',     T => '-',
    H => '....',    U => '..-',
    I => '..',      V => '...-',
    J => '.---',    W => '.--',
    K => '-.-',     X => '-..-',
    L => '.-..',    Y => '-.--',
    M => '--',      Z => '--..',

    0 => '-----',   5 => '.....',
    1 => '.----',   6 => '-....',
    2 => '..---',   7 => '--...',
    3 => '...--',   8 => '---..',
    4 => '....-',   9 => '----.',
);

my %morse_inv = map { $morse{$_} => $_ } keys %morse;

my %morse_bin_inv = (
    '1'        => \&add_dot   ,  # dot
    '111'      => \&add_dash  ,  # dash
    '0'        => sub { }     ,  # intra-character gap
    '000'      => \&add_char  ,  # character gap
    '0000000'  => \&add_word  ,  # word gap
);

die "Usage: $0 <string of binary encoded morse code>" unless @ARGV == 1;

my $seq    = '';
my $token  = '';
my $output = [ '' ];

my $bmc = $ARGV[0];

foreach my $i (0 .. (length $bmc)-1 ) {
    my $actual = substr $bmc, $i, 1;
    my $next = substr $bmc, $i+1, 1;
    $seq .= $actual;
    if ($actual ne $next) {
        $morse_bin_inv{$seq}->();
        $seq = '';
    }
}
add_char();

print join ' ', @$output;
exit 0;


sub add_dot {
    $token .= '.';
}

sub add_dash {
    $token .= '-';
}
sub add_char {
    $output->[-1] .= $morse_inv{$token};
    $token = '';
}
sub add_word {
    add_char();
    push @$output, '';
}


__END__

./ch-2.pl 101110111011100010101110001010100011100000001011100011101000111011101110001110001010101000100010111010000000101110111010001000101110100010111010100000001010101000101110001110101110100011101011100010001011101
JUST ANOTHER PERL HACKER

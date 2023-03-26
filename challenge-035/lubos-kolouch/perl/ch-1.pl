use strict;
use warnings;
use Test::More;

# Define Morse code mappings
my %morse_code = (
    'A' => '.-',
    'B' => '-...',
    'C' => '-.-.',
    'D' => '-..',
    'E' => '.',
    'F' => '..-.',
    'G' => '--.',
    'H' => '....',
    'I' => '..',
    'J' => '.---',
    'K' => '-.-',
    'L' => '.-..',
    'M' => '--',
    'N' => '-.',
    'O' => '---',
    'P' => '.--.',
    'Q' => '--.-',
    'R' => '.-.',
    'S' => '...',
    'T' => '-',
    'U' => '..-',
    'V' => '...-',
    'W' => '.--',
    'X' => '-..-',
    'Y' => '-.--',
    'Z' => '--..',
    ' ' => '/'
);

# Encode text into binary encoded Morse code
sub encode_morse {
    my $text    = shift;
    my $encoded = '';
    foreach my $char ( split //, uc $text ) {
        if ( exists $morse_code{$char} ) {
            my $morse = $morse_code{$char};
            my @bits  = ();
            foreach my $symbol ( split //, $morse ) {
                if ( $symbol eq '.' ) {
                    push @bits, '1', '0';
                }
                elsif ( $symbol eq '-' ) {
                    push @bits, '1' x 3, '0';
                }
            }
            $encoded .= join( '0', @bits ) . '0';
        }
    }
    $encoded =~ s/0$//;    # Remove trailing intra-character gap
    return $encoded;
}

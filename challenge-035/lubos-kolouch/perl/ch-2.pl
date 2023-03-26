use strict;
use warnings;
use Test::More;

# Define Morse code mappings
my %morse_code = (
    '.-'   => 'A',
    '-...' => 'B',
    '-.-.' => 'C',
    '-..'  => 'D',
    '.'    => 'E',
    '..-.' => 'F',
    '--.'  => 'G',
    '....' => 'H',
    '..'   => 'I',
    '.---' => 'J',
    '-.-'  => 'K',
    '.-..' => 'L',
    '--'   => 'M',
    '-.'   => 'N',
    '---'  => 'O',
    '.--.' => 'P',
    '--.-' => 'Q',
    '.-.'  => 'R',
    '...'  => 'S',
    '-'    => 'T',
    '..-'  => 'U',
    '...-' => 'V',
    '.--'  => 'W',
    '-..-' => 'X',
    '-.--' => 'Y',
    '--..' => 'Z',
    '/'    => ' '
);

# Decode binary encoded Morse code
sub decode_morse {
    my $encoded = shift;

    # Split encoded text into words and characters
    my @words   = ( $encoded =~ /0{7}/g );
    my @letters = map { [ ( $_ =~ /0{3}/g ) ] } @words;

    # Convert Morse code to plaintext
    my $plaintext = '';
    for my $word (@letters) {
        for my $letter (@$word) {
            if ( exists $morse_code{$letter} ) {
                $plaintext .= $morse_code{$letter};
            }
            else {
  # If the Morse code is badly formed, try to recover by looking one digit ahead
                for my $i ( 1 .. 3 ) {
                    my $lookahead = substr( $letter, $i );
                    if ( exists $morse_code{$lookahead} ) {
                        $plaintext .= $morse_code{$lookahead};
                        last;
                    }
                }

# If no valid Morse code sequence can be recovered, treat the character as a space
                $plaintext .= ' '
                  unless length $plaintext && substr( $plaintext, -1 ) eq ' ';
            }
        }
        $plaintext .= ' ';
    }
    $plaintext =~ s/\s+$//;    # Remove trailing space
    return $plaintext;
}

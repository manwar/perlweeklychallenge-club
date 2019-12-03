# Test: perl6 ch2.p6 'string to test'
use v6.d;

sub MAIN (Str $message) {
    say encode($message);
}

sub encode (Str $message) {
    my $encoded_message = '';

    # Some definitions
    my $char_gap = '0' x 3;
    my $word_gap = '0' x 7;

    # I generated this lookup table using a modified perl5 script
    my %morse = (
    '!' => '1010111011101',     "'" => '1011101110111011101',
    '+' => '1011101011101',     ',' => '1110111010101110111',
    '-' => '111010101010111',   '.' => '10111010111010111',
    '/' => '1110101010111',     '0' => '1110111011101110111',
    '1' => '10111011101110111', '2' => '101011101110111',
    '3' => '1010101110111',     '4' => '10101010111',
    '5' => '101010101',         '6' => '11101010101',
    '7' => '1110111010101',     '8' => '111011101110101',
    '9' => '11101110111011101', ':' => '11101110111010101',
    '?' => '101011101110101',   '@' => '101010111010111',
    'A' => '10111',             'B' => '111010101',
    'C' => '11101011101',       'D' => '1110101',
    'E' => '1',                 'F' => '101011101',
    'G' => '111011101',         'H' => '1010101',
    'I' => '101',               'J' => '1011101110111',
    'K' => '111010111',         'L' => '101110101',
    'M' => '1110111',           'N' => '11101',
    'O' => '11101110111',       'P' => '10111011101',
    'Q' => '1110111010111',     'R' => '1011101',
    'S' => '10101',             'T' => '111',
    'U' => '1010111',           'V' => '101010111',
    'W' => '101110111',         'X' => '11101010111',
    'Y' => '1110101110111',     'Z' => '11101110101',
    );

    # Split words
     my @words = $message.split(rx{\s+});
    for (0 .. @words.end) -> $i {
        # Split characters
        my @chars = @words[$i].comb;

        for (0 .. @chars.end) -> $j {
            # Translate the character
            $encoded_message ~= %morse{@chars[$j].uc};

            # Add the character gap
            $encoded_message ~= $char_gap
                unless ($j == @chars.end);
        }

        # Add the word gap
        $encoded_message ~= $word_gap
            unless ($i == (@words.end));
    }

    return $encoded_message;
}

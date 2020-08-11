#!/usr/bin/perl
# Test: ./ch1.pl 'string to test'
use strict;
use warnings;
use feature qw /say/;

say encode(join ' ', @ARGV);

sub encode {
    my $test_string = shift;
    my $converted_string = '';

    # Some definitions
    my $dot      = '1';
    my $dash     = '1' x 3;
    my $gap      = '0';
    my $char_gap = '0' x 3;
    my $word_gap = '0' x 7;

    # For my sanity I just copied and paste real morse code
    # This could be cleaner
    my %morse = qw(
        A .-     B -...   C -.-.  D -..   E .    F ..-.
        G --.    H ....   I ..    J .---  K -.-   L .-..
        M --     N -.     O ---   P .--.  Q --.-  R .-.
        S ...    T -      U ..-   V ...-  W .--
        X -..-   Y -.--   Z --..
        0 -----  1 .----  2 ..--- 3 ...-- 4 ....-
        5 .....  6 -....  7 --... 8 ---.. 9 ----.
        . .-.-.- / -...-  : ---... ' .----.
        - -....- ? ..--.. ! ..--. @ ...-.- + .-.-.
    );

    # Stop perl from spitting out a warning
    # about a comma in qw
    $morse{','} = '--..--';

    # Convert the dot and dashes to the required 0 and 1's
    for my $key (sort keys %morse) {
        my $code = $morse{$key};
        $code =~ s/\.$/$dot/;      # trailing $dot
        $code =~ s/\-$/$dash/;     # trailing $dash
        $code =~ s/\./$dot$gap/g;  # all other dots
        $code =~ s/\-/$dash$gap/g; # all other dashes
        $morse{$key} = $code;
    }

    # Split words
    my @words = split('\s+', $test_string);
    for my $i (0 .. $#words) {

        # Split characters
        my @chars = split('', $words[$i]);
        for my $j (0 .. $#chars) {
            # Translate the character
            $converted_string .= $morse{uc($chars[$j])};

            # Add the character gap
            $converted_string .= $char_gap
                unless ($j == $#chars);
        }

        # Add the word gap
        $converted_string .= $word_gap
            unless ($i == $#words);
    }

    return $converted_string;
}


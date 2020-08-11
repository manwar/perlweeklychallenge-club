#!/usr/bin/perl
# Test: ./ch1.pl 'string to test' | ./ch2.pl
use strict;
use warnings;
use feature qw /say/;

say decode(<STDIN>);

sub decode {
    my $encoded_string = shift;
    my $converted_string = '';
    chomp $encoded_string;

    # Do some error correction
    if (scalar(@ARGV)) {
        $encoded_string =
            simulate_error($encoded_string, $ARGV[0]);
        $encoded_string =
            error_correction($encoded_string);
    }

    # Some definitions
    my $char_gap = '0' x 3;
    my $word_gap = '0' x 7;

    # I generated this lookup table using a modified perl5 script
    my %morse = (
    '1010111011101'     => '!', '1011101110111011101' => "'",
    '1011101011101'     => '+', '1110111010101110111' => ',',
    '111010101010111'   => '-', '10111010111010111'   => '.',
    '1110101010111'     => '/', '1110111011101110111' => '0',
    '10111011101110111' => '1', '101011101110111'     => '2',
    '1010101110111'     => '3', '10101010111'         => '4',
    '101010101'         => '5', '11101010101'         => '6',
    '1110111010101'     => '7', '111011101110101'     => '8',
    '11101110111011101' => '9', '11101110111010101'   => ':',
    '101011101110101'   => '?', '101010111010111'     => '@',
    '10111'             => 'A', '111010101'           => 'B',
    '11101011101'       => 'C', '1110101'             => 'D',
    '1'                 => 'E', '101011101'           => 'F',
    '111011101'         => 'G', '1010101'             => 'H',
    '101'               => 'I', '1011101110111'       => 'J',
    '111010111'         => 'K', '101110101'           => 'L',
    '1110111'           => 'M', '11101'               => 'N',
    '11101110111'       => 'O', '10111011101'         => 'P',
    '1110111010111'     => 'Q', '1011101'             => 'R',
    '10101'             => 'S', '111'                 => 'T',
    '1010111'           => 'U', '101010111'           => 'V',
    '101110111'         => 'W', '11101010111'         => 'X',
    '1110101110111'     => 'Y', '11101110101'         => 'Z',
    );

    # Split words
    my @words = split($word_gap, $encoded_string);
    for my $i (0 .. $#words) {

        # Split characters
        my @chars = split($char_gap, $words[$i]);
        for my $j (0 .. $#chars) {
            # Translate the character
            $converted_string .= $morse{$chars[$j]}
                if (defined($morse{$chars[$j]}));
        }

        # Add the word gap
        $converted_string .= ' '
            unless ($i == $#words);
    }

    return $converted_string;
}

sub simulate_error {
    my $mutated_string = shift;
    my $mutations = shift;

    for my $i (0..$mutations) {
        my @zero_locations = ();

        # locate all the 0's
        my @chars = split ('', $mutated_string);
        for my $i (0 .. $#chars) {
            push @zero_locations, $i
                if ($chars[$i] == 0);
        }

        # remove a random 0;
        my $random_position = int(rand($#zero_locations));
        substr $mutated_string,
               $zero_locations[$random_position], 1, '';
    }

    return $mutated_string;
}


sub error_correction {
    my $corrected_string = shift;

    # missed char sep between two shorts
    $corrected_string =~ s/^110/^1010/g;

     # missed char sep between two longs
    $corrected_string =~ s/111111/1110111/g;

    # missed char sep between two shorts
    $corrected_string =~ s/0110/01010/g;

    # missed word separator
    $corrected_string =~ s/10{4,6}1/100000001/g;

    # missed char separator
    $corrected_string =~ s/1001/10001/g;

    # missed on short and long
    $corrected_string =~ s/1111/10111/g;

    return $corrected_string;
}

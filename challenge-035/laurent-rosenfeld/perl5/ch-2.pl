use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;

my %bin_chars = ( '.' => 1, '_' => 111);
my $morse_codes_file = "morse.dat";
open my $IN_MORSE, "<", $morse_codes_file or die "Cannot open $morse_codes_file $!";
my %bin_morse =
    map { chomp;
          my ($key, $val) = split ":", $_ ;
          my $bin_val = join '0', map $bin_chars{$_}, split //, $val;
          $key => $bin_val;
        } <$IN_MORSE>;

my $input = shift // "The quick brown fox jumps over the lazy dog";

sub to_morse {
    my $input = uc shift;      # Morse doesn't have cases
    $input =~ s/[^A-Z0-9 ]//g; # remove non Morse characters
    my @morse_words;
    for my $word (split / /, $input) {
        push @morse_words, join '000', map { $bin_morse{$_} } split //, $word;
    }
    return join '0000000', @morse_words;
}
sub from_morse {
    my $input = shift;
    my %rev_bin_morse = reverse %bin_morse;
    my @words;
    for my $word (split /0{7}/, $input) {
        push @words, join '', map $rev_bin_morse{$_}, split /000/, $word;
    }
    return join " ", @words;
}
sub format80c {
    shift =~ s/(.{80})/$1\n/gr;
}

say "Input string: $input";
my $encoded = to_morse $input;
say "Binary encoded Morse string:\n", format80c $encoded;
say "Decoded string: ", from_morse $encoded;

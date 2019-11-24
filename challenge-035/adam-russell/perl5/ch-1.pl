use strict;
use warnings; 
##
# Write a program to encode text into binary encoded morse code.
##
use constant DOT            => "1";
use constant DASH           => "111";
use constant CHAR_GAP       => "000";
use constant INTRA_CHAR_GAP => "0";
use constant WORD_GAP       => "0000000";
my %letter_morse = (
    A      => ".-",
    B      => "-...",
    C      => "-.-.",
    D      => "-..",
    E      => ".",
    F      => "..-.",
    G      => "--.",
    H      => "....",
    I      => "..",
    J      => ".---",
    K      => "-.-",
    L      => ".-..",
    M      => "--",
    N      => "-.",
    O      => "---",
    P      => ".--.",
    Q      => "--.-",
    R      => ".-.",
    S      => "...",
    T      => "-",
    U      => ".--",
    V      => "...-",
    W      => ".--",
    X      => "-..-",
    Y      => "-.--",
    Z      => "--..",
);

sub encode{
    my (@message) = @_; 
    my @encoded;
    for my $word (@message){ 
        chomp($word); 
        my @letters = split(//, $word);
        @letters = map { 
            uc($_) 
        } @letters;
        my @morse = map { $letter_morse{$_} } @letters;
        my @digital_morse = map { 
            my @d = split(//, $_);
            @d = map { m/-/ ? DASH : DOT } @d;
            join(INTRA_CHAR_GAP, @d); 
        } @morse;
        push @encoded, join(CHAR_GAP, @digital_morse);
    }
    return join(WORD_GAP, @encoded);
}

MAIN:{
    my $message = $ARGV[0];
    my @words = split(/\s+/, $message);
    my $encoded = encode(@words); 
    print "$encoded\n";
} 

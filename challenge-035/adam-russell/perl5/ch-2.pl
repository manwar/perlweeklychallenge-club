use strict;
use warnings; 
##
# Write a program to decode binary morse code.
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
my %morse_letter = reverse %letter_morse; 

sub decode{
    my($message) = @_;
    my @decoded; 
    my @morse_words = split(WORD_GAP, $message);
    for my $morse_word (@morse_words){
        my @morse_chars = split(CHAR_GAP, $morse_word);
        my @letters = map{ 
            my @d = split(INTRA_CHAR_GAP, $_);
            @d = map { $_ eq "1" ? "." : "-" } @d;
            $morse_letter{join("", @d)} 
        } @morse_chars;
        push @decoded, join("", @letters) . " ";  
    } 
    return join("", @decoded);
} 

MAIN:{
    my $message = $ARGV[0];
    my $decoded = decode($message); 
    print "$decoded\n";
} 


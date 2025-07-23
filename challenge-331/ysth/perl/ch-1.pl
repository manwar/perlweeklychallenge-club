use 5.036;

use utf8::all; # utf8 @ARGV

sub grapheme_length($string) {
    scalar( () = $string =~ /\X/g )
}

sub last_word_length($string) {
    # words are made up of letters, numbers, modifiers, and underscore-like punctuation
    grapheme_length reverse($string) =~ /([\pL\pN\pM\p{pC}]+)/ ? scalar reverse $1 : ''
}

sub main() {
    my @inputs = @ARGV;
    for my $string (@inputs) {
        printf "%-30s -> %s\n", $string, last_word_length $string;
    }
}

main() unless caller;

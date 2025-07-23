use 5.040;

use utf8::all; # utf8 @ARGV
use Text::Fuzzy ();

sub buddy_strings($string1, $string2) {
    length $string1 == length $string2
        and Text::Fuzzy->new($string1, max => 1, no_exact => 1) == 1
}

sub main() {
    my @inputs = @ARGV;
    for my ($string1, $string2) (@inputs) {
        printf "%-30s\n%-30s\n    -> %s\n", $string1, $string2, (buddy_strings($string1, $string2) ? 'yes' : 'no');
    }
}

main() unless caller;

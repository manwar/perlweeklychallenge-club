use strict;
use warnings;
use feature 'say';
use utf8;
use Unicode::Normalize;
binmode(STDOUT, ":utf8");

sub makeover {
    return join '', map { /(.)/ } map { /(\X)/g } NFD shift;
}

for my $test ('ÃÊÍÒÙ', 'âÊíÒÙ', 'àçùòîéèûä' ) {
    say "$test -> \t", makeover($test);
}

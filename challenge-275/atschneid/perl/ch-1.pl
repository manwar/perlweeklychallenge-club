use strict;
use warnings;

use v5.38;

sub check_broken_key( $string, @broken_keys ) {
    my $keys = join '', @broken_keys;
    my $regex = qr"\S*[${keys}]\S*"i;

    $string =~ s/$regex//ig;

    return scalar split ' ', $string;
}


my @inputs = (
    [ "Perl Weekly Challenge", ['l', 'a'] ],
    [ "Perl and Raku", ['a'] ],
    [ "Well done Team PWC", ['l', 'o'] ],
    [ "The joys of polyglottism", ['T'] ]
    );

for (@inputs) {
    my $sentence = $_->[0];
    my @keys = @{$_->[1]};
    
    say $sentence . ' ' . (join ', ', @keys) . ' :: ' . check_broken_key( $sentence, @keys );
}

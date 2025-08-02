use strict;
use warnings;

use v5.38;

my @inputs = (
    "perl",
    "book",
    "good morning",
    "hello",
    "heloOlo",
    "heloeOlo"
    );
for (@inputs) {
    say $_ . " => " . ( splittable_string($_) ? "true" : "false" );
}

sub splittable_string( $string ) {
    my @count = $string =~ /[aeiou]/gi;
    return $#count % 2;
}


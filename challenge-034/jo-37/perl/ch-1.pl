#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use warnings FATAL => 'all';
use Data::Dump qw(dd pp);
use experimental qw(signatures postderef);
die <<EOS unless @ARGV == 2;
usage: $0 'A B C...' 'X Y Z...'

'A B C...' 'X Y Z...'
    two lists of words

EOS


### Input and Output

main: {
    # Split arguments.
    my @a = split /\s+/, shift;
    my @b = split /\s+/, shift;
    # Create "sets" %a and %b having the elements of @a and @b as keys
    # *and* values. Using hash slices to populate the hashes.
    my %a;
    @a{@a} = @a;
    my %b;
    @b{@b} = @b;
    # Build the intersection of %a and %b by using the %a's keys to
    # slice %b.
    say join ' ', grep defined, @b{keys %a};
}

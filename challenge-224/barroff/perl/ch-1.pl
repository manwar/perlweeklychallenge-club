#!/usr/bin/env perl

use v5.36;

sub create_bag (@source_array) {
    my %bag;
    for my $element (@source_array) {
        $bag{$element}++;
    }
    return %bag;
}

sub special_notes ( $source, $target ) {
    my %source_bag = create_bag( split( //, $source ) );
    my %target_bag = create_bag( split( //, $target ) );
    foreach my $key ( keys %target_bag ) {
        return undef
          unless defined( $source_bag{$key} )
          and $source_bag{$key} >= $target_bag{$key};
    }
    return 1;
}

#| Run test cases
sub MAIN() {
    if ( @ARGV == 2 ) {
        say special_notes( $ARGV[0], $ARGV[1] ) ? 'true' : 'false';
    }
    else {
        use Test2::V0 qw( is plan );
        plan 3;

        is special_notes( 'abc', 'xyz' ), undef, 'works for ("abc", "xyz")';
        is special_notes( 'scriptinglanguage', 'perl' ), 1,
          'works for ("scriptinglanguage", "perl")';
        is special_notes( 'aabbcc', 'abc' ), 1, 'works for ("aabbcc", "abc")';
    }
}

MAIN();

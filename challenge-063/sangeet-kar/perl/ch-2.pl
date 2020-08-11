#!/usr/bin/env perl

sub rot {
    my ( $string, $n ) = @_;
    substr( $string, $n ) . substr( $string, 0, $n );
}

my $input = $ARGV[0] // 'xyxx';

my $tmp = $input;
for ( my $i = 1 ; ; $i++ ) {
    $tmp = rot( $tmp, $i % length($input) );
    if ( $tmp eq $input ) {
        print $i;
        last;
    }
}


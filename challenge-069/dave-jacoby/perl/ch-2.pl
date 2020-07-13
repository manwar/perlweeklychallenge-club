#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental::signatures };

my $val = '';
my $m;
for my $n ( 1 .. 20 ) {
    $val = task2($val);
    $m   = $n;
}
display( $m, $val );

# display and _line are functions written to break up the long
# input to something far easier to read. 
sub display ( $n, $val ) {
    my $x = 70;
    my $l = 0;
    while ( length $val >= $x ) {
        my $line = substr( $val, 0, $x );
        substr( $val, 0, $x ) = '';
        _line( $l++, $n, $line );
    }
    _line( $l, $n, $val );
}

sub _line ( @input ) {
    say join "\t", @input;
}

# the definition of the function is
#    SN = SN-1 + “0” + switch(reverse(SN-1))
# and the + is concatenation, not mathematical
sub task2 ( $input ) {
    my $output = join '', $input, '0', _switch( reverse($input) );
    return $output;
}

# we already have a reverse function in Perl, but this does
# something different. returns an empty string if given one,
# and the string, reversed
sub _reverse ( $string ) {
    return $string if length $string == 0;
    return join '', reverse split //, $string;
}

# again, there exists a Perl thing with this name, that does
# a very different. I suppose I could've done this as bitwise
# or instead, but I'm already handling everything as a string
sub _switch ( $string ) {
    my $output = '';
    for my $c ( split //, $string ) {
        $output .= $c ? '0' : '1';
    }
    return $output;
}

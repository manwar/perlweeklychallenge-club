#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ uniq };

my @alphabet = ( '_', 'A' .. 'Z' );
my %n2a      = map { $_ => $alphabet[$_] } 1 .. 26;

my @input = sort { $a <=> $b } qw( 1115 127 919 212 202 2112 );
for my $i (@input) {
    my @list = decoded_list($i);
    my $list = join ', ', @list;
    say <<"END";
    Input:  \$s = $i
    Output: $list
END
}

sub decoded_list ( $input ) {
    my @output;
    my @list = _make_list($input);
OUTER: for my $x (@list) {
        my @x =  grep { /\d/ } split /\D+/, $x;
        for my $y (@x) { next OUTER if !$n2a{$y} }
        push @output, join '', map { $n2a{$_} } @x;
    }
    return uniq sort @output;
}

sub _make_list ( $input, $string = '' ) {
    if ( $input eq '' ) {
        return ($string);
    }
    my $letter = substr( $input, 0, 1 );
    substr( $input, 0, 1 ) = '';
    my @output;
    push @output, _make_list( $input, $string . $letter );
    push @output, _make_list( $input, $string . ' ' . $letter );
    return @output;
}

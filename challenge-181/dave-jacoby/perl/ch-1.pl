#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my $input = <<"END";
All he could think about was how it would all end. There was
still a bit of uncertainty in the equation, but the basics
were there for anyone to see. No matter how much he tried to
see the positive, it wasn't anywhere to be seen. The end was
coming and it wasn't going to be pretty. 
END

my $output = sentence_order($input);
say $input;
say ' ';
say $output;

sub sentence_order( $input ) {
    my $output = '';
    $input =~ s/\n/ /gmx;
    my @sentences = split /\./, $input;
    for my $sentence (@sentences) {
        my $new = join ' ', sort { fc $a cmp fc $b } split /\ /, $sentence;
        $output .= $new . '. ';
    }
    $output = paragraphize($output);
    return $output;
}

sub paragraphize ( $input, $line_length = 55 ) {
    my @input  = split /\ +/, $input;
    my $output = '';
    my $line   = '';
    for my $word (@input) {
        next if $word !~ /\w/;
        $line .= ' ' if length $line;
        $line .= $word;
        if ( length $line > $line_length ) {
            $output .= $line;
            $output .= "\n";
            $line = '';
        }
    }
    $output .= $line;
    return $output;
}

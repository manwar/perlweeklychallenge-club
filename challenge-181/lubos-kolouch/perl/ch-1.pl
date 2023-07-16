#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;

sub order_sentence {
    my $paragraph = shift;
    my @sentences = split /\./, $paragraph;

    my @ordered;
    foreach my $sentence (@sentences) {
        next if $sentence =~ /^\s*$/;
        my @words = sort split /\s+/, $sentence;
        push @ordered, join( ' ', @words ) . '.';
    }

    return join( ' ', @ordered );
}

is( order_sentence('All he could think about was how it would all end.'),
    'All about all could end he how it think was would.' );
is(
    order_sentence(
'There was still a bit of uncertainty in the equation, but the basics were there for anyone to see.'
    ),
'There a anyone basics bit but equation, for in of see still the the there to uncertainty was were.'
);
is( order_sentence('The end was coming and it wasn\'t going to be pretty.'),
    'The and be coming end going it pretty to was wasn\'t.' );

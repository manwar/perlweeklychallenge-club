#!/usr/bin/env perl6

use v6;

class Box {
    has Int $.weight;
    has Int $.worth;

    method gist { "{$!weight}kg worth £{$!worth}" }
}

#| Calculate the most valuable boxes you can carry
sub MAIN(
    Int $max-boxes = 5, #= Max number of boxes you can carry (default 5)
    Int $max-weight = 15, #= Max weight of boxes you can carry (default 15kg)
) {
    my @boxes = ( Box.new( :1weight, :1worth ),
                  Box.new( :1weight, :2worth ),
                  Box.new( :2weight, :2worth ),
                  Box.new( :12weight, :4worth ),
                  Box.new( :4weight, :10worth ) );

    say "I can take up to {$max-boxes} boxes weighing up to {$max-weight}kg from this selection";
    .say for @boxes;

    my @options = @boxes.combinations().grep( *.elems <= $max-boxes ).grep( { ([+] $_.map( *.weight )) <= $max-weight } ).sort( { ( [+] $^b.map( *.worth ) ) cmp ( [+] $^a.map( *.worth ) ) } );

    say "I think I'll take :";
    .say for @options[0].list;
    say "Which weighs {[+] @options[0].map(*.weight)}kg and is worth £{[+] @options[0].map(*.worth)}";
}

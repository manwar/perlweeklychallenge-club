#!/usr/bin/env raku
use Test;

is nearest-rgb("#F4B2D1"), "#FF99CC";
is nearest-rgb("#15E6E5"), "#00FFCC";
is nearest-rgb("#191A65"), "#003366";
is nearest-rgb("#2D5A1B"), "#336633";
is nearest-rgb("#00FF66"), "#00FF66";

grammar G
{
    token TOP { '#' <hex> <hex> <hex> }
    token hex { <xdigit> <xdigit>     }
}

class actions
{
    method hex($/) 
    { 
        my @a = <19 4C 7F B2 E5 FF>;

        my %h = '19' => '00', '4C' => '33', '7F' => '66',
                'B2' => '99', 'E5' => 'CC', 'FF' => 'FF';
        
        make %h{ @a.first(* ge $/.uc) }
    }
}

sub nearest-rgb($color)
{
    [~] flat '#', G.parse($color, :actions(actions))<hex>>>.made
}

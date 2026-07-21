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
        my @a = <00 19 1A 33 4C 4D 66 7F 80 99 B2 B3 CC E5 E6 FF>;

        my %h = '00' => '00', '19' => '00', '1A' => '33', '33' => '33',
                '4C' => '33', '4D' => '66', '66' => '66', '7F' => '66',
                '80' => '99', '99' => '99', 'B2' => '99', 'B3' => 'CC',
                'CC' => 'CC', 'E5' => 'CC', 'E6' => 'FF', 'FF' => 'FF';
        
        make %h{ @a.first(* ge $/.uc) }
    }
}

sub nearest-rgb($color)
{
    [~] flat '#', G.parse($color, :actions(actions))<hex>>>.made
}

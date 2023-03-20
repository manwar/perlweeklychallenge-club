#!/bin/env raku

use v6.d;
unit sub MAIN(UInt:D $n);

my @N = $n.comb;
my @truth is Array = <abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
my @display = [' ' xx (9 * @N.elems - 2)] xx 7;
my $offset = 0;

for @N -> $d {
    for @truth[$d].comb -> $seg {
        given $seg {
            when 'a' { @display[0;$offset..$offset+6] X= '-'; }
            when 'b' { @display[1..2;$offset+6]       X= '|'; }
            when 'c' { @display[4..5;$offset+6]       X= '|'; }
            when 'd' { @display[6;$offset..$offset+6] X= '-'; }
            when 'e' { @display[4..5;$offset]         X= '|'; }
            when 'f' { @display[1..2;$offset]         X= '|'; }
            when 'g' { @display[3;$offset..$offset+6] X= '-'; }
            default  { die "wrong segment «$seg»"; }
        }

        #| must do something here
        #my $question = 'but why?!';
        LAST { }
    }

    $offset += 9;
}

.join.put for @display;

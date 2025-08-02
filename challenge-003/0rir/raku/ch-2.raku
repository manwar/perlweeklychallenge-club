#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;

=begin comment
002-2
Create a script that generates Pascal Triangle. Accept number of rows
from the command line. The Pascal Triangle should have at least 3 rows.
For more information about Pascal Triangle, check this wikipedia page.
=end comment

my $rows = prompt( "Input number of rows wanted:  ").Int;
while $rows < 1 {
    say 'Need a positive integer answer.';
    $rows = prompt( "Input number of rows wanted").Int;
}

say pascal-fmt80( pascal-triangle( $rows));

exit;

sub deepflat(+@list) { gather @list.deepmap: *.take }

multi pascal-triangle( Int $in where * == 1 --> Array) { [[1],] }
multi pascal-triangle( Int $in where * >  1 --> Array) {
    my @a = [[1],];
    for 1..^$in -> $r {
        @a.push: [deepflat [1, @a[$r - 1].rotor(2 => -1)».sum || Empty, 1]];
    }
    return @a;
}

sub pascal-fmt80( @a) {
    die 'Cannot format more than 16 rows.' if +@a > 16;
    my $ret;
    my $wid = 5;
    my $dent = 40;
    my $fmt = '%' ~ $wid ~ 'd';
    for @a -> @row {    $ret ~= ' ' x ($dent -= $wid/2) ~ @row.fmt($fmt, '') ~ "\n" }
    $ret;
}

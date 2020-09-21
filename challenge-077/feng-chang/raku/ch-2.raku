#!/bin/env raku

# read input and surround matrix with O's
#   e.g.: ./ch-2.raku < data-c2-01.txt
my @a;
for $*IN.lines -> $line {
    @a.push($line.comb.Array.unshift('O').push('O'));
}

my UInt $rows  = @a.elems;
my UInt $width = @a[0].elems - 2;
@a.unshift(['O' xx $width + 2]);;
@a.push(['O' xx $width + 2]);;

# count lonely X's
my UInt $cnt = 0;
for 1..$rows X 1..$width -> ($i, $j) {
    my $junc = all(@a[$i-1;$j-1], @a[$i-1;$j], @a[$i-1;$j+1],
                   @a[$i;$j-1],                @a[$i;$j+1],
                   @a[$i+1;$j-1], @a[$i+1;$j], @a[$i+1;$j+1]
               );
    ++$cnt if @a[$i;$j] eq 'X' and $junc eq 'O';
}

say $cnt;

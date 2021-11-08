#!/usr/bin/env perl6
#
#
#       126-2-clean-sweep.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;


my $m = 3;
my $n = 3;
my $pct = 30;

my @mat = generate_map( $m, $n, $pct );
say "$_" for @mat;

my @map = @mat.map({ $_.map({ $_ eq '*' ?? 0 !! $_ }).Array });
say "$_" for @map;

my @range = -1, 0, 1;
my @deltas = (@range X @range).grep({all( $_ ) != 0});


sub generate_map ($m, $n, $pct) {
## height in rows, width in columns, % chance of cell being a mine
    my @mat;
    my @list = |('x' xx $pct), |('*' xx 100 - $pct);
    for (^$m X ^$n) -> ($r, $c) {
        @mat[$r][$c] = @list.roll;
    }
    return @mat;
}

for ^(@map.elems) X ^(@map[0].elems) -> ($i, $j) {
    next unless @map[$i][$j] eq 'x';
    for @deltas -> $d {
            my $r = $i + $d[0];
            my $c = $j + $d[1];
            if ( @map.elems > $r >= 0 and @map[0].elems > $c >= 0 ) {
                next if @map[$r][$c] eq 'x';
                @map[$r][$c] += 1;
            }
    }

}

say "$_" for @map;

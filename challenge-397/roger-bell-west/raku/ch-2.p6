#! /usr/bin/raku

use Test;

plan 5;

is-deeply(binaryreflection([3, 6, 12]), [3, 6, 12], 'example 1');
is-deeply(binaryreflection([1, 2, 4, 8]), [1, 2, 4, 8], 'example 2');
is-deeply(binaryreflection([7, 8, 9, 10]), [8, 10, 7, 9], 'example 3');
is-deeply(binaryreflection([5, 9, 15, 17]), [5, 9, 15, 17], 'example 4');
is-deeply(binaryreflection([11, 13, 14, 19]), [14, 13, 11, 19], 'example 5');

sub reflect($a) {
    my @p;
    my $am = $a;
    while (True) {
        @p.push($am % 2);
        $am = $am +> 1;
        if ($am == 0) {
            last;
        }
    }
    my $ar = 0;
    my $s = @p.elems;
    for @p -> $n {
        $s -= 1;
        $ar += $n +< $s;
    }
    $ar;
}

sub binaryreflection(@ax) {
  my @k = @ax.map({reflect($_)});
  my @i = (0 .. @ax.end).sort({
    @k[$^a] <=> @k[$^b]
      ||
    @ax[$^a] <=> @ax[$^b]
  });
  Array(@i.map({@ax[$_]}));
}

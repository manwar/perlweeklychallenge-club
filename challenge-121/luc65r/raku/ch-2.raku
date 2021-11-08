#!/usr/bin/env raku

sub len(@mat, @tour --> Numeric) {
    @tour.rotor(2 => -1).map({ @mat[.tail;.head] }).sum
}

proto MAIN(|) {
    my @mat := {*};
    my $n = @mat.shape[0];
    say "matrix:\n", @mat, "\n";
    my @m = |min :by({ len @mat, $_ }), map { |$_, $_[0] }, permutations ^$n;
    say "tour: $@m";
    say "length: {len @mat, @m}";
}

multi MAIN(UInt:D $n --> Array) {
    my Numeric @mat[$n;$n];
    for @mat <-> $v {
        $v = (1 ..^ 10).rand.Int;
    }
    @mat[$_;$_] = 0 for 0 ..^ $n;
    return @mat;
}

multi MAIN(Str:D $f = "-" --> Array) {
    my @l = $f.IO.open.lines;
    Array[Numeric].new: :shape(+@l, +@l), map { / [ (\d+) \s* ]+ /; |+« $/.list }, @l
}

#!/usr/bin/raku

sub MAIN(
    *@list where { @list.elems > 2 } #= list of coordinates in the form x,y
) {
    my @coords = @list».split(',')».Int;

    my ($x0, $y0) = @coords[0];
    my ($x1, $y1) = @coords[1];
    my $dx = $x1 - $x0;
    my $dy = $y1 - $y0;

    for @coords[2..*] -> ($x, $y) {
        if ($dx * ($y - $y0) != $dy * ($x - $x0)) {
            say "False";
            exit;
        }
    }

    say "True";
}
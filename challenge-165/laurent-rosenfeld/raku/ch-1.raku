use SVG;
my \SCALE = 5;

my ( @points, @lines);
my @input = <53,10  53,10,23,30  23,30  34,35,36>;
for @input -> $val {
    my @items = split /','/, $val;
    if @items.elems == 2 {
        make-point(@items)
    } elsif @items.elems == 4 {
        make-line(@items);
    } else {
        note "Error on item ", @items;
    }
}

say ( SVG.serialize(svg => [ width => 500, height => 500, |@points, |@lines ] ));

sub make-point (@dots) {
    @dots = map { $_ * SCALE }, @dots;
    my $point = circle =>
        [ cx => @dots[0],
          cy => @dots[1],
          r => 3,
          fill => 'forestgreen' ];
    push @points, $point;
}

sub make-line (@dots) {
    @dots = map { $_ * SCALE }, @dots;
    my $line = line =>
        [ x1 => @dots[0],
          y1 => @dots[1],
          x2 => @dots[2],
          y2 => @dots[3],
          stroke => 'navy' ];
    push @lines, $line;
}

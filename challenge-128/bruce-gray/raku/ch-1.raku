# Count uninterrupted zeros, omitting left-side neighbors.
# So, <1 0 0 0 1 0> becomes <0 3 2 1 0 1>.
sub streaks-of-zeros ( @row ) {
    my $streak = 0;
    return reverse @row.reverse.map: {
        +( $streak = $_ ?? 0 !! $streak+1 )
    }
}
# Based on "bottleneck"; The max width of a rectangle that you are trying to fit as you scan downward, 
# gets squeezed narrower each time you iterate through a less-wide row.
sub largest-sub-matrix-of-zeros ( @m ) {
    # Build parallel matrix of zeros-to-my-right. @m not needed after this.
    my @sog = @m.map(&streaks-of-zeros); 

    my %max = <depth width area i j> Z=> (0,0,0, Any, Any);
    for     @sog.kv -> $i, @row {
        for @row.kv -> $j, $v   {
            # Since @sog holds the max-width to the right, a triangular reduce on `min` yields
            # the max rectangle size from i,j down to each row.
            my @slice_mins = [\min] @sog.skip($i)».[$j].grep({ $_ or last });
            for @slice_mins.kv -> $depth0, $width {
                my $depth = $depth0 + 1;
                my $area  = $depth * $width;
                %max = :$area, :$depth, :$width, :$i, :$j if $area > %max<area>;
            }
        }
    }
    return %max;
}

my @tests =
    (
        <1 0 0 0 1 0>,
        <1 1 0 0 0 1>,
        <1 0 0 0 0 0>,
    ),
    (
        <0 0 1 1>,
        <0 0 0 1>,
        <0 0 1 0>,
    ),
    (
        <1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1>,
        <1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>,
    ),
    (
        <1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1>,
        <1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1>,
    ),
    [],
;
for @tests {
    my %r = largest-sub-matrix-of-zeros([.list».Int]);
    say '---';
    say %r;
    say 0 xx %r<width> for ^%r<depth>;
}

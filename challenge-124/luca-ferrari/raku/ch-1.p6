#!raku

class Line {
    has $.char = '^';
    has $.start = 0;
    has $.end   = 0;
    has $.pad-with-blanks = True;

    method draw() {
        my $line = ' ' x $!start ~  $!char;
#        $line ~= $!start ~ "<>" ~ $!end;
        if ( $!pad-with-blanks ) {
            $line ~= ' ' x ( $!end - $!start - 1 ) ~ $!char;
        }
        else {
            $line ~= $!char x ( $!end - $!start );
        }

        say $line;

    }
}


sub MAIN() {

    my @lines;
    my $size = 5;
    my ( $start, $end ) = $size, $size * 2 - 1;
    @lines.push: Line.new( start => $start, end => $end, pad-with-blanks => False );
    while ( $start > 0 ) {
        @lines.push: Line.new( start => --$start, end => ++$end );
    }

    # add three lines
    @lines.push: Line.new( start => 0, end => $end ) for 1 .. 3;

    # decreasing part
    while ( $start < $size ) {
        @lines.push: Line.new( start => ++$start, end => --$end );
    }

    # final line
    @lines.push: Line.new( start => $start, end => $end, pad-with-blanks => False );

    # add three lines with a single char
    @lines.push: Line.new( start => $start + $size / 2, end => $start + $size / 2, pad-with-blanks => False ) for 1 .. 3;
    @lines.push: Line.new( start => $start, end => $end, pad-with-blanks => False );
    @lines.push: Line.new( start => $start + $size / 2, end => $start + $size / 2, pad-with-blanks => False ) for 1 .. 3;

    .draw for @lines

}

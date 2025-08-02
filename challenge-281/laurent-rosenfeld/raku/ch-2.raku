my @moves = <2 1>, <2 -1>, <1 2>, <1 -2>,
            <-1 2>, <-1 -2>, <-2 1>, <-2 -1>;

sub to-coordinates ($in) {
    my ($col, $row) = $in.comb;
    return $col.ord - 'a'.ord, $row - 1;
}

sub find-shortest ($st-in, $end-in) {
    # convert input to Cartesian coordinates
    my @start = to-coordinates $st-in;
    my @end = to-coordinates $end-in;

    my @to-be-explored;  # a queue of squares to be visited
    push @to-be-explored, (0, @start).flat;
    my %seen = "@start[]" => 1;  # already visited squares

    while @to-be-explored {
        my @node = shift @to-be-explored;
        my ($depth, @current) = @node[0];
        return $depth if "@current[]" eq "@end[]";
        for @moves -> @move {
            my @next = @current[0] + @move[0],
                       @current[1] + @move[1];
            # dismiss if computed position not on chessboard
            next if @next.any > 7 or @next.any < 0;
            # dismiss if computed position already visited
            next if %seen{"@next[]"}:exists;
            # update seen hash and to-be-explored queue
            %seen{"@next[]"} = 1;
            push @to-be-explored, ($depth + 1, @next).flat;
        }
    }
}

my @tests = <g2 a8>, <g2 h2>;
for @tests -> @test {
    printf "%-6s => ", "@test[]";
    say find-shortest @test[0], @test[1];
}

use v6;

my @tests =
    [ [ |(0..3) ], [ |(4..7)  ],  [ |(8..11)  ], [ |(12..15) ] ],
    [ [ |(0..4) ], [ |(5..9)  ],  [ |(10..14) ], [ |(15..19) ] ],
    [ [ |(0..5) ], [ |(6..11) ], [ |(12..17)  ], [ |(18..23) ] ],
    [ [ |(0..5) ], [ |(6..11) ], [ |(12..17)  ] ],
    [ [ |(0..2) ], [ |(4..6)  ],  [ |(8..10)  ], [ |(12..14) ] ];

sub print-matrix (@matrix) {
        say "[ {$_.fmt("% 3i")} ]" for @matrix;
        say "";
}

for @tests -> @matrix {
    my @result;
    print-matrix @matrix;
    loop {
        push @result, |@matrix[0];
        push @result, @matrix[$_][*-1]:delete for 1..@matrix.end;
        push @result, |(reverse @matrix[@matrix.end]:delete);
        last if @matrix.elems == 1;
        push @result, @matrix[$_][0]:delete for reverse 1..@matrix.end;
        @matrix = map { [$_[|(1..$_.end)]] }, @matrix[|(1..@matrix.end)];
        # print-matrix @matrix;
        last unless @matrix;
    }
    say @result, "\n";
}

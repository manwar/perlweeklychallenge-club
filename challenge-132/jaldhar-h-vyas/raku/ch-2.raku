#!/usr/bin/raku

sub MAIN() {
    my @output;

    my @player_ages = (
        [20, "Alex"  ],
        [28, "Joe"   ],
        [38, "Mike"  ],
        [18, "Alex"  ],
        [25, "David" ],
        [18, "Simon" ],
    );

    my @player_names = (
        ["Alex", "Stewart"],
        ["Joe",  "Root"   ],
        ["Mike", "Gatting"],
        ["Joe",  "Blog"   ],
        ["Alex", "Jones"  ],
        ["Simon","Duane"  ],
    );

    my $col0length = 0;
    my $col1length = 0;
    my $col2length = 0;

    for @player_ages -> @r {
        for @player_names -> @s {
            if @r[1] eq @s[0] {

                @output.push([ @r[0], "\"@r[1]\"", "\"@s[1]\"" ]);

                if @r[0].chars > $col0length {
                    $col0length = @r[0].chars;
                }

                if @r[1].chars > $col1length {
                    $col1length = @r[1].chars;
                }

                if @s[1].chars > $col2length {
                    $col2length = @s[1].chars;
                }
            }
        }
    }

    for @output.sort({ @^a[1] cmp @^b[1] }) -> @row {
        printf
            "%-{$col0length + 1}s %-{$col1length + 3}s %-{$col2length + 2}s\n",
            @row[0] ~ q{,}, @row[1] ~ q{,}, @row[2];
    }

}
use v6;

#|[ Performs a hash join given the probe input, build input, and corresponding
    indices with which to compare. ]
sub hashjoin(@S, @R, Int:D $si, Int:D $ri) {
    # 1. For each tuple r in the build input R
    #    1.1 Add r to the in-memory hash table
    @R.classify({ $^r[$ri] }, :into(my %hash{Any}));
    # 2. Do a final scan of the probe input S and add the resulting join tuples
    #    to the output relation
    @S.sort({ $^a[$si] cmp $^b[$si] }).map({
        %hash{$^s[$si]} andthen |.map({ |$s, |$^r[^$ri], |$^r[$ri^..*] }) })
}

my @player-ages = (
    [20, "Alex"  ],
    [28, "Joe"   ],
    [38, "Mike"  ],
    [18, "Alex"  ],
    [25, "David" ],
    [18, "Simon" ],
);

my @player-names = (
    ["Alex", "Stewart"],
    ["Joe",  "Root"   ],
    ["Mike", "Gatting"],
    ["Joe",  "Blog"   ],
    ["Alex", "Jones"  ],
    ["Simon","Duane"  ],
);

sub MAIN() { .put for hashjoin @player-ages, @player-names, 1, 0 }

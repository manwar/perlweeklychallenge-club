#!/usr/bin/perl6

multi sub MAIN() {
    my @boxes = (
        { name => 'R', weight => 1,  amount => 1  },
        { name => 'B', weight => 1,  amount => 2  },
        { name => 'G', weight => 2,  amount => 2  },
        { name => 'Y', weight => 12, amount => 4  },
        { name => 'P', weight => 4,  amount => 10 },
    );

    for 2 .. 5 -> $i {
        my $max = { name => q{}, weight => 0,  amount => -1 };

        for @boxes.combinations($i) -> @combo {
            my $total = { name => q{}, weight => 0,  amount => 0 };
            for @combo -> $box {
                $total<name> ~= $box<name>;
                $total<weight> += $box<weight>;
                $total<amount> += $box<amount>;
            }
            if $total<weight> <= 15 && $total<amount> > $max<amount> {
                $max = $total;
            }
        }
        if $max<amount> > -1 {
            say "For $i boxes, the best combination is $max<name> which weighs",
                " $max<weight> kg and is valued £$max<amount>.";
        } else {
            say "for $i boxes, it is not possible to meet the criteria.";
        }
    }
}
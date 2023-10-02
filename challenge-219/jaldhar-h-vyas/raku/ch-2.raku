#!/usr/bin/raku

sub MAIN(
    $days,
    *@costs
) {
    my @days = $days.split(/ \s+ /).map({ $_.Num }).sort;

    my %costs;
    %costs{'1'} = @costs[0];
    %costs{'7'} = @costs[1];
    %costs{'30'} = @costs[2];

    my @q;
    @q.push({ cost => 0, days => @days });
    my $lowestCost = @days.elems * %costs{'1'};

    while (@q.elems) {
        my %entry = @q.shift;

        if ( %entry{'days'}.elems == 0 ) {
            if ( %entry{'cost'} < $lowestCost ) {
                $lowestCost = %entry{'cost'}; 
            }
        } else {
            if ( %entry{'cost'} >= $lowestCost ) {
                next;
            }

            my $start = %entry{'days'}[0];
            for %costs.keys -> $interval {
                my $end = $start + $interval - 1;
                my $cost = %entry{'cost'} + %costs{$interval};
                @q.push({
                    cost => $cost,
                    days => %entry{'days'}.grep({ $_ > $end })
                });
            }
        }
    }

    say $lowestCost;
}
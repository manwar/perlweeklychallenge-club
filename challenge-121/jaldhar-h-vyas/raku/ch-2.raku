#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @matrix = @args.map({ [$_.words] });
    my $minimumLength = ∞;
    my @tour = ();
    for (@matrix[0].keys).permutations -> $perm {
        my $cost = 0;
        my $from = 0;

        my @cities = @$perm.grep({ $_ != 0});
        for @cities.keys -> $i {
            $cost += @matrix[$from;@cities[$i]];
            $from = @cities[$i];
        }
        $cost += @matrix[$from;0];

        if $cost < $minimumLength {
            $minimumLength = $cost;
            @tour = @cities;
        }
    }

    say "length = $minimumLength";
    say 'tour = (0 ', @tour.join(q{ }), ' 0)'; 
}


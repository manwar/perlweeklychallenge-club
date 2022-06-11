subset Base of Int where 2..36;

sub no-reps ( Str $s --> Bool ) { $s.comb.repeated.not }

sub largest_rep-free_square_in_base ( Base $base ) {
    my Str $highest = (^$base)».base($base).join.flip; # 'BA9876543210' for $base==12

    my UInt $root = $highest.parse-base($base).sqrt.round;

    $root-- until ($root²).base($base).&no-reps;

    return $root;
}

my @bases = flat map { /(\d+)\-(\d+)/ ?? (+$0 .. +$1) !! $_ },
            (@*ARGS ?? @*ARGS !! <2-12 14-16 18>);

for @bases -> Base $base {
    my $root = largest_rep-free_square_in_base($base);

    printf "%2s  %10s  %20s  %8s  %16s\n",
        $base, $root, $root², $root.base($base), ($root²).base($base);
}

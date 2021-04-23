use v6;
constant MAX = 4;

my $*count = 0;
for 2..Inf -> $base {
    check-self-desc($base);
    last if $*count >= MAX;
}

sub check-self-desc (Int $base) {
    my $found = False;
    for $base ** ($base -1) .. $base ** $base -1 -> $num {
        my $num-in-b = $num.base($base);
        next unless $num-in-b ~~ /0$/;
        my @digits = $num-in-b.comb;
        next if $base != [+] @digits;
        my $success = True;
        for 0..$base - 1 -> $rank {
            if (+ $num-in-b.indices($rank) != @digits[$rank]) {
                $success = False;
                last;
            }
        }
        if $success {
            say "Number in base $base: $num-in-b; decimal: $num";
            $*count++;
            $found = True;
            return if $*count >= MAX;
        }
    }
    say "No self-descriptive number for base $base" unless $found;
}

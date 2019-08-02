#| http://www.cs.ox.ac.uk/people/jeremy.gibbons/publications/spigot.pdf
sub gibbons-spigot() {
    my ($q, $r, $t, $i) = 1, 180, 60, 2;
    gather loop {
        my $u = 3 * (3 * $i + 1) * (3 * $i + 2);
        my $y = floor(($q * (27 * $i - 12) + 5 * $r) / (5 * $t));

        take $y;

        ($q, $r, $t, $i) =
            10 * $q * $i * (2 * $i - 1),
            10 * $u * ($q * (5 * $i - 2) + $r - $y * $t),
            $t * $u,
            $i + 1;
    }
}

my $pi = gibbons-spigot;

put $pi[0], '.', $pi[1 ..^ $?FILE.IO.s].join;

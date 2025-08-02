use v5.38;
sub id_mat($n) {
    my @a;
    push @a, [(0) x $n] for (0 .. $n - 1);
    $a[$_][$_] = 1 for (0 .. $n - 1);
    say "@{$a[$_]}" for (0 .. $n - 1);
}
id_mat(4);

use v6;

sub check-squares (@in) {
    my $flag = False;
    for @in.permutations -> @perm {
        my $sum1 = [+] @perm[0, 1];
        next if $sum1 != [+] @perm[1..3] or
            $sum1 != [+] @perm[3..5] or
            $sum1 != [+] @perm[5, 6];
        say @perm and $flag = True
    }
    return $flag;
}
say "No solution" unless check-squares(1..7)

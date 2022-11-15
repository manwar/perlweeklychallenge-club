sub is-cute (@list) {
    my @new = (0, @list).flat;
    for 1..@list.elems -> $i {
        return False unless $i %% @new[$i] or @new[$i] %% $i;
    }
    return True;
}

sub count-cute ($k) {
    my $count = 0;
    for (1..$k).permutations -> @perm {
        $count++ if is-cute @perm;
    }
    return $count;
}

for 1..10 -> $j {
    say "$j -> ", count-cute $j;
}

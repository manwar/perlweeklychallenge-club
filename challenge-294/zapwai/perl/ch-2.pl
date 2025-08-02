use v5.38;

sub perm(@l) {
    return (\@l) if ($#l == 0);
    my @L;
    for my $i (0 .. $#l) {
        my @new = @l;
        splice @new, $i, 1;
        for my $r (perm(@new)) {
            my @curr_list = ($l[$i]);
            push @curr_list, @$r;
            push @L, \@curr_list;
        }
    }
    return @L;
}

sub proc(@ints) {
    say "Input: \@ints = @ints";
    my @p = perm(sort @ints);
    my $out;
    my $flag = 0;
    my $s1 = join "", @ints;
    for my $r (@p) {
        if ($flag == 1) {
            $out = join "", @$r;
            $flag = 0;
        }
        my $s2 = join "", @$r;
        $flag = 1 if ($s1 eq $s2);
    }
    say "Output: $out";
}

my @ints = (1,2,3);
proc(@ints);
@ints = (2,1,3);
proc(@ints);
@ints = (3,1,2);
proc(@ints);

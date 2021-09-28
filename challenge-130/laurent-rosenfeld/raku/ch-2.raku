use v6;

sub dft (%t, $min) {
    my $value = %t<val>;
    my $new-min = $value < $min ?? $value !! $min ;
    # say "$max $min $value $new-max $new-min";
    if %t<lc>:exists {
        # say "%t<lc><val> $min";
        return 0 if %t<lc><val> > $value;
        return 0 if %t<lc><val> > $min;
        return 0 unless dft %t<lc>, $new-min;
    }
    if %t<rc>:exists {
        # say "%t<rc><val> $min";
        return 0 if %t<rc><val> < $value;
        return 0 if %t<rc><val> > $min;
        return 0 unless dft %t<rc>, $new-min;
    }
    return 1;
}
my %tree1 = (
    val => 8,
    lc => { val => 5,
            lc => {val => 4},
            rc => {val => 6}
          },
    rc => {val => 9}
);
#       8
#      / \
#     5   9
#    / \
#   4   6
say (dft %tree1, Inf), "\n";

my %tree2 = (val => 5,
    lc => { val => 4,
            lc => {val => 3},
            rc => {val => 6}
           },
    rc => {val => 7});
#       5
#      / \
#     4   7
#    / \
#   3   6
say dft %tree2, Inf;

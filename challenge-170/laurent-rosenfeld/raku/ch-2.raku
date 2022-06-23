sub print_matrix (@m) {
    for @m -> @row {
        .fmt(" %3d ").print for @row;
        say "";
    }
}
sub kroneck_prod (@a, @b) {
    my @result;
    for @a -> @row_a {
        for @b -> @row_b  {
            push @result, [@row_a  X* @row_b];
        }
    }
    print_matrix @result;
}

say "test 1:";
my @a = (1, 2; 3, 4);
my @b = [5, 6; 7, 8];
kroneck_prod @a, @b;
say "\ntest 2:";
my @c = (1, 2, 3; 2, 3, 4);
my @d = (5, 6; 7, 8; 9, 10);
kroneck_prod @c, @d;
say "\nTest 3:";
kroneck_prod @d, @c;

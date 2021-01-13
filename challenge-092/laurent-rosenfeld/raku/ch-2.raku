use v6;

my @tests = [(2, 6), (1, 4), (8, 10)], [(5, 8), (1, 2), (3,7 ), (8, 10)], [(10, 11), (1, 5), (7, 9)];

# Caution: not complying with the task rules, as this
# script also merges adjacent intervals
for @tests -> @test {
    say @test;
    my @full-data = (map { |( $_[0]..$_[1]) }, @test).Set.keys.sort;
    my $first = shift @full-data;
    my @result;
    my $last = $first;
    for @full-data -> $item {
        if $item != $last + 1 {
           push @result, "($first, $last), ";
           $first = $item;
        }
        $last = $item;
    }
    push @result, "($first, $last), ";
    say ~@result.subst(/','\s+$/, "\n");
}

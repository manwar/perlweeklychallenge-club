my @permut_str;

sub permutation2rank(@in) {
    # if the input list is sorted, then permutations will be sorted
    # Forcing a lexicographic order (although not really needed here)
    my @sorted = sort { $^a leg $^b }, @in;
    my @permutations = @sorted.permutations;
    @permut_str = map {[join " ", $_]}, @permutations;
    my %ranks = map { $^b => $^a }, @permut_str.kv;
}
sub rank2permutations ($rank) {
    return @permut_str[$rank];
}

my @tests = (1, 0, 2), (6, 3, 4), <a c d b>;
for @tests -> @test {
    my %ranks = permutation2rank(@test);
    say @permut_str;
    my $test = join " ", @test;
    say "[$test] has rank %ranks{$test}";
    say "Rank %ranks{$test} is ", rank2permutations(%ranks{$test});
    say "Rank {%ranks{$test} - 1} is ", rank2permutations(%ranks{$test} - 1);
    say "";
}

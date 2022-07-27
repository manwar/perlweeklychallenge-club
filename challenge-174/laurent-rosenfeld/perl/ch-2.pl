use strict;
use warnings;
use feature "say";
use Data::Dumper;

my @permutations;

sub permute {
    my ($done, $left) = @_;
    if (scalar @$left == 0) {
        push @permutations, $done;
        return;
    }
    my @left = @$left;
    permute([ @$done, $left[$_]], [@left[0..$_-1], @left[$_+1..$#left]]) for 0..$#left;
}

sub permutation2rank {
    # if the input list is sorted, then permutations will be sorted
    # This will be in lexicographic order, even for numbers
    my @sorted = sort @_;
    permute([], [@sorted]);
    my @permut_str = map {join " ", @$_} @permutations;
    my $count = 0;
    my %ranks = map { $_ => $count++ } @permut_str;
}

sub rank2permutations {
    return (map {join " ", @$_} @permutations)[$_[0]];
}

my @tests = ( [1, 0, 2], [6, 3, 4], [<a d c b>]);
for my $test (@tests) {
    @permutations = ();
    my %ranks = permutation2rank (@$test);
    my $test_str = join " ", @$test;
    say "Rank of [$test_str] is: $ranks{$test_str}";
    for my $i (2, 4, 5) {
        say "Rank $i is [", rank2permutations ($i), "]";
    }
    say " ";
}

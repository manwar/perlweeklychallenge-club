use strict;
use warnings;
use feature qw/say/;

my @permutations;

sub is_cute {
    my @new = (0, @_);
    for my $i (1.. scalar @_) {
        return 0 if $i % $new[$i] and $new[$i] % $i;
    }
    return 1;
}

sub permute {
    my ($done, $left) = @_;
    if (scalar @$left == 0) {
        push @permutations, $done;
        return;
    }
    my @left = @$left;
    permute([ @$done, $left[$_]], [@left[0..$_-1], @left[$_+1..$#left]]) for 0..$#left;
}

sub count_cute {
    my $k = shift;
    my $count = 0;
    @permutations = ();
    permute([], [1..$k]);
    for my $perm (@permutations) {
        $count++ if is_cute @$perm;
    }
    return $count;
}

for my $j (1..10) {
    say "$j -> ", count_cute $j;
}

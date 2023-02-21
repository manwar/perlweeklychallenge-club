use strict;
use warnings;
use feature "say";

sub reshape {
    my @matrix = @{$_[0]};
    my ($r, $c) = @{$_[1]};
    my @result;
    my $rows = scalar @matrix;
    my $cols = scalar @{$matrix[0]};
    return [0] if $r * $c != $rows * $cols;
    my @flat = map { @$_ } @matrix;
    for my $i (0..$r - 1) {
        push @result, [ @flat[$i*$c .. $i*$c + $c -1 ] ];
    }
    return @result;
}
sub display_result {
    my ($mat, $rc) = @_;
    printf "%-15s - %-3s => ", join ("",
        map ("[@$_]",  @$mat)), "@$rc";
    say map "[@$_]", reshape($mat, $rc);;
}

my @test = ([1, 2], [3, 4]);
for my $rc ([<1 4>], [<4 1>], [<2 2>], [<3 4>]) {
    display_result \@test, $rc;
}
@test = ([1, 2, 3], [4, 5, 6]);
for my $rc ([<3 2>], [<2 3>], [<1 6>], [<6 1>], [<6 3>]) {
    display_result \@test, $rc;
}

use strict;
use warnings;
use feature qw/say/;

my @result;

sub is_valid_triplet {
    my ($a, $b, $c) = @_;
    return 0 if $c >= $a + $b;
    return 0 if $b >= $a + $c;
    return 0 if $a >= $b + $c;
    return 1;
}

sub combine {
    my @out = @{$_[0]};
    my @in  = @{$_[1]};
    if (@out == 3) {
        push @result, $_[0] if is_valid_triplet @out;
        return;
    }
    for my $i (0..$#in) {
        combine ([ @out, $in[$i] ], [ @in[$i+1..$#in] ]);
    }
}

for my $test ( [<1 2 3 2>], [<1 3 2>], [<1 1 2 3>], [<2 4 3> ]) {
    @result = ();
    combine ([], [ sort { $b <=> $a } @$test]);
    say "@$test => ", @result > 0 ? "@{$result[0]}" : "()";
}

use strict;
use warnings;
use feature "say";

sub add {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}
sub check_squares {
    my @in = @{$_[0]};
    my $sum = add @in[0, 1];
    return ($sum == add @in[1..3] and
            $sum == add @in[3..5] and
            $sum == add @in[5, 6] );
}
sub permute {
    my ($perm_ref, $inref) = @_;
    my @in = @$inref;
    if (scalar @in == 0) {
        say "@$perm_ref" if check_squares $perm_ref;
        return;
    }
    permute([@$perm_ref, $in[$_]], [ @in[0..$_-1, $_+1..$#in] ]) for 0..$#in;
}
my @input = 1..7;
permute [], \@input;

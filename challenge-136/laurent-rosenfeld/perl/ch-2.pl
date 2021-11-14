use strict;
use warnings;
use feature "say";
use Data::Dumper;

my @comb;
my @fib = qw /1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597/;

sub sum {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}

sub combine {
    my $target = shift;
    my $count = shift;
    my @out = @{$_[0]};
    my @in  = @{$_[1]};
    return if sum @out > $target;
    push @comb, [@out] and return if sum(@out) == $target;
    return if $count == 0;
    for my $i (0..$#in) {
        combine ($target, $count - 1, [@out, $in[$i]], [@in[$i+1..$#in]]);
    }
}


sub fib_seq {
    my $n = shift;
    my @short_fib = grep { $_ <= $n } @fib;
    my $count =  scalar @short_fib;
    @comb = ();
    combine $n, $count, [], [@short_fib];
    say "@$_" for @comb;
    return scalar @comb;
}

say "Number of sequences for $_: ", fib_seq $_ for 16, 9, 15, 89, 100;

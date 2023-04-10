use strict;
use warnings;
use feature "say";

my ($target, @result);

sub avg {
    my $nb_elems = scalar @_;
    my $sum = shift;
    $sum += $_ for @_;
    return $sum / $nb_elems;
}

sub find_partition {
    my @current = @{$_[0]};
    my @left = @{$_[1]};
    return if scalar @left <= 1;
    if (scalar @current > 0 and $target == avg(@current)) {
        push @result, @current;
        return;
    }
    for my $i (0..$#left) {
        find_partition( [@current, $left[$i]], [@left[0..$i-1, $i+1..$#left]]);
        return if @result > 0;
    }
}

sub start_partition {
    my @in = @_;
    $target = avg @in;
    @result = ();
    my @current;
    find_partition [@current], [@in];
    return @result;
}

for my $test ([<1 2 3 4 5 6 7 8>], [<1 2 3>], [<1 3>]) {
    my @output = start_partition @$test;
    print "@$test => ";
    if (scalar @output == 0) {
        say "false";
    } else {
        print "true : [@output] ";
        my %out = map { $_ => 1 } @output;
        say "[", join " ", grep { not exists $out{$_} } @$test, "]";
    }
}

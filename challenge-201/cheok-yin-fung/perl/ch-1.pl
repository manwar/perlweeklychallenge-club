# The Weekly Challenge 201
# Task 1 Missing Numbers

sub mn {
    my @arr = @_;
    my $tail = scalar @arr;
    my %check;
    $check{$_} = 1 for @arr;
    my @ans;
    for (0..$tail) {
        push @ans, $_ if !$check{$_};
    }
    return [@ans];
}


use Test::More tests=>2;
use Test::Deep;
cmp_deeply(mn(0,1,3), [2]);
cmp_deeply(mn(0,1), [2]);

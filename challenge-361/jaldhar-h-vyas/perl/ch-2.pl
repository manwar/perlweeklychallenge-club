#!/usr/bin/perl
use 5.038;
use warnings;

sub allEquals($arr, $elem) {
    return (scalar grep { $_ == $elem } @{$arr}) == (scalar @{$arr});
}

sub getColumn($arr, $i) {
    return map { $_->[$i] } @{$arr};
}

my @party  = map { [ split // ] } @ARGV;
my $celebrity = -1;

for my $row (keys @party) {
    if (allEquals($party[$row], 0)) {
        if (scalar grep {$_ == 0} getColumn(\@party, $row) == 1) {
            $celebrity = $row;
            last;
        }
    }
}

say $celebrity;

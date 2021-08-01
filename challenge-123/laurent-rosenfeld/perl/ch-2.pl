use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;

sub dist {
    my ($p1, $p2) = @_;
    sqrt(($p2->{x} - $p1->{x}) ** 2 + ($p2->{y} - $p1->{y}) ** 2);
}

sub build4points {
    my @i = @_;
    my @p;
    for (1..4) {
        push @p, { x => shift, y => shift };
    }
    return @p;
}
my @tests = ( [ qw/10 20 20 20 20 10 10 10/ ],
              [ qw/12 24 16 10 20 12 18 18/ ] );
for my $test (@tests) {
    my @points = build4points(@$test);
    my %dist;
    for my $p ( [0, 1], [0, 2], [0, 3], [1, 2], [1, 3], [2, 3] ) {
        my $distance =  dist($points[$p->[0]], $points[$p->[1]]);
        $dist{$distance}++
    }
    # say Dumper \%dist;
    print "@$test => ";
    if ( grep { $_ == 4 } values %dist) {
        say 1;
    } else {
        say 0;
    }
}

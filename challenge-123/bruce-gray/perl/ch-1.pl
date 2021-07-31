use strict;
use warnings;
use 5.010;
use List::Util qw<uniq first>;
use Test::More;

sub is_square {
    die if @_ != 4;

    my %xy;
    push @{ $xy{ 'x'.$_->[0] } }, $_ for @_;
    push @{ $xy{ 'y'.$_->[1] } }, $_ for @_;

    my @unique_points    = uniq map { join ',', @{$_} } @_;
    my @unaligned_points = grep { @{$_} != 2 } values %xy;

    return 0 + (     @unique_points    == 4
                 and @unaligned_points == 0 );
}

my @tests = (
    [ SampleA   => 1, [10,20],[20,20],[20,10],[10,10] ],
    [ SampleB   => 0, [12,24],[16,10],[20,12],[18,16] ],
    [ NotUnique => 0, [10,20],[20,10],[10,20],[20,10] ],
);
plan tests => 0+@tests;
for my $t (@tests) {
    my ( $name, $expected, @input ) = @{$t};
    is is_square(@input), $expected, $name;
}

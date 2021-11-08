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

    my ($A, $B, $C, $D) = sort {    $a->[0] <=> $b->[0]
                                 or $a->[1] <=> $b->[1] } @_;

    my @unique_points    = uniq map { join ',', @{$_} } @_;
    my @unaligned_points = grep { @{$_} != 2 } values %xy;
    my $lr_sides_eq_tb   = ( $C->[0] - $A->[0] == $B->[1] - $A->[1] );

    return 0 + (     $lr_sides_eq_tb
                 and @unique_points    == 4
                 and @unaligned_points == 0 );
}

my @tests = (
    [ SampleA   => 1, [10,20],[20,20],[20,10],[10,10] ],
    [ SampleB   => 0, [12,24],[16,10],[20,12],[18,16] ],
    [ NotUnique => 0, [10,20],[20,10],[10,20],[20,10] ],
    [ Rectangle => 0, [10,10],[90,10],[90,20],[10,20] ],
);
plan tests => 0+@tests;
for my $t (@tests) {
    my ( $name, $expected, @input ) = @{$t};
    is is_square(@input), $expected, $name;
}

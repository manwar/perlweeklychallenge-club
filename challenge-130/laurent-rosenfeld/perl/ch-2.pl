#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;

sub dft {
    my ($t, $min) = @_;
    my $value = $t->{val};
    my $new_min = $value < $min ? $value : $min ;
    # say " $min $value $new_min";
    if (exists $t->{lc}) {
        # say "%t<lc><val> $min";
        return 0 if $t->{lc}{val} > $value;
        return 0 if $t->{lc}{val} > $min;
        return 0 unless dft($t->{lc}, $new_min);
    }
    if (exists $t->{rc}) {
        # say "%t<rc><val> $max $min";
        return 0 if $t->{rc}{val} < $value;
        return 0 if $t->{rc}{val} > $min;
        return 0 unless dft($t->{rc}, $new_min);
    }
    return 1;
}
my %tree1 = (
    val => 8,
    lc => { val => 5,
            lc => {val => 4},
            rc => {val => 6}
          },
    rc => {val => 9}
);
#       8
#      / \
#     5   9
#    / \
#   4   6
say "tree1: ", dft(\%tree1, 1e9), "\n";

my %tree2 = (val => 5,
    lc => { val => 4,
            lc => {val => 3},
            rc => {val => 6}
           },
    rc => {val => 7});
#       5
#      / \
#     4   7
#    / \
#   3   6
say "tree2: ", dft \%tree2, 1e9;

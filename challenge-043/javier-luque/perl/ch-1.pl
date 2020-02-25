#!/usr/bin/perl
# Test: ./ch1.pl
use strict;
use warnings;
use feature qw /say/;
use Algorithm::Combinatorics qw(permutations);

my @numbers = (1, 2, 3, 4, 6);
my $rings = {
    blue   => 8,    yellow => 7,
    green  => 5,    red    => 9,
};

my $iter = permutations(\@numbers);
while (my $p = $iter->next) {
    my $slots = {
        redgreen     => $p->[0],
        greenblack   => $p->[1],
        black        => $p->[2],
        blackyellow  => $p->[3],
        yellowblue   => $p->[4]
    };

    if (validate_answer($rings, $slots)) {
        for my $key (keys %$slots) {
            say 'Slot: ' . $key .
                ' value: ' . $slots->{$key};
        }
    }
}

sub validate_answer {
    my ($r, $s) = @_; # rings and slots

    return
    ( $s->{redgreen} + $r->{red} == 11 &&
      $s->{redgreen} + $r->{green} + $s->{greenblack} == 11 &&
      $s->{greenblack} + $s->{black} + $s->{blackyellow} == 11 &&
      $s->{blackyellow} + $r->{yellow} + $s->{yellowblue} == 11 &&
      $r->{blue} + $s->{yellowblue} == 11 );
}

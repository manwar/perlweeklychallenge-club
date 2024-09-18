#!/usr/bin/perl
use v5.38;
use warnings;

use List::Util qw(min max pairs);

{
    my @ints = @ARGV;
    exit unless @ints;
    @ints = min_max(@ints) while (@ints > 1);
    say $ints[0];
}

sub min_max {
    my $idx_op = 0;
    my @ints = @_;
    push @ints, $ints[-1] if @ints & 0x1; # Repeat last item if odd number.
    return map { [ \&min, \&max ]->[($idx_op++) & 0x1]->(@$_) } pairs @ints;
}

__END__

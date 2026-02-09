#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 1 0 1 0...\n";

my @result = map {$_ ? 'true' : 'false'}
             map {$_ % 5 == 0} prefix_bin(@ARGV);
say join ", ", @result;

sub prefix_bin {
    my(@digits) = @_;
    my @values;
    for my $i (0 .. $#digits) {
        my $str = "0b".join("", @digits[0..$i]);
        my $value = eval($str);
        $@ and dir $@;
        push @values, $value;
    }
    return @values;
}

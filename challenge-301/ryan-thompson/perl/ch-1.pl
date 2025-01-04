#!/usr/bin/env perl

use 5.038;

sub largest(@ints) {
    my $sub = sub {
        my $num = shift;
        return $num.($_[0]//0) if @_ <= 1;
        my $call = "sub($num, @_) -->";

        my $max_val = 0; # Our candidate answer

        # Loop until current number starts with a lower digit than previous
        for my $i (0..$#_) {
            last if $i > 0 and substr($_[$i], 0, 1) ne substr($_[0], 0, 1);

            my @new_ints = @_;
            splice @new_ints, $i, 1; # Remove $i-th element

            my $val = __SUB__->($num.$_[$i], @new_ints);
            $max_val = length($val) > length($max_val) ? $val
                            : $val gt        $max_val  ? $val : $max_val;
        }

        $max_val;
    };

    return $sub->('',reverse sort @ints);
}

say largest(@ARGV) and exit if @ARGV;


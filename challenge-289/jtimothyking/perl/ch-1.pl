#!/usr/bin/perl
use v5.38;
use warnings;

use List::Util qw(uniqint);

# Call whichever implementation you'd like to use.
implementation_2();

sub implementation_1 {
    my @unique_ints = uniqint sort { $b <=> $a } @ARGV;
    say $unique_ints[2] // $unique_ints[0];
}

sub implementation_2 {
    my @max_ints = max3(@ARGV);
    say $max_ints[2] // $max_ints[0];
}

# Return the top 3 unique maximum integers in O(n) time.
sub max3 {
    my $num_max_ints = 3;
    my @max_ints;

    my sub insert_if_new_max {
        my $int = shift;
        for my $i (0 .. $num_max_ints - 1) {
            last if $int == $max_ints[$i];
            next if (defined $max_ints[$i] && $int < $max_ints[$i]);
            splice @max_ints, $i, 0, $int;
            pop @max_ints if @max_ints > $num_max_ints;
            last;
        }
    }

    insert_if_new_max($_) for (@_);
    return @max_ints;
}

__END__

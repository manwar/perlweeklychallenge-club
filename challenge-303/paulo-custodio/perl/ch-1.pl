#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";

my @nums = find_nums(@ARGV);
say "(", join(", ", @nums), ")";

sub find_nums {
    my(@digits) = @_;
    my @nums;
    my %seen;

    my $find_nums;
    $find_nums = sub {
        my($prefix, $pending) = @_;

        # find out if we have a numbermatching the criteria
        if ($prefix ne '' && $prefix >= 100 && $prefix < 1000 && $prefix % 2 == 0) {
            push @nums, 0+$prefix unless $seen{0+$prefix}++;
        }

        return if @$pending == 0 || ($prefix||0) >= 1000;

        for my $i (0 .. $#$pending) {
            my $new_prefix = $prefix . $pending->[$i];
            my @new_pending = @$pending;
            splice(@new_pending, $i, 1);
            $find_nums->($new_prefix, \@new_pending);
        }
    };

    $find_nums->("", \@digits);

    return sort {$a<=>$b} @nums;
}

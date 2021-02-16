#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-100/
# TASK #1 › Fun Time

use 5.030;
use warnings;

my $input = shift;

if ($input =~ /^(?<hour>\d{2}):(?<minute>\d{2})$/) {
    if ($+{hour} eq '00') {
        print '12';
    } elsif ($+{hour} le '12') {
        print $+{hour};
    } else {
        printf '%02d', $+{hour} - 12;
    }
    print ":$+{minute}";
    if ($+{hour} lt '12') {
        print 'am';
    } else {
        print 'pm';
    }
} elsif ($input =~ /^(?<hour>\d{2}):(?<minute>\d{2}) ?(?<period>am|pm)$/) {
    if ($+{period} eq 'am') {
        if ($+{hour} eq '12') {
            print '00';
        } else {
            print $+{hour};
        }
    } else {
        if ($+{hour} eq '12') {
            print $+{hour};
        } else {
            printf '%02d', $+{hour} + 12;
        }
    }
    print ":$+{minute}";
} else {
    die "Invalid time '$input'\n";
}

print "\n";

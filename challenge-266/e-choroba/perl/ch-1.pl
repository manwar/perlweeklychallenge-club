#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub uncommon_words($line1, $line2) {
    my %seen;
    ++$seen{$1}{1} while $line1 =~ /(\w+)/g;
    ++$seen{$1}{2} while $line2 =~ /(\w+)/g;
    my @uncommon = grep {
        ($seen{$_}{1} // 0) + ($seen{$_}{2} // 0) == 1
    } keys %seen;
    return [""] unless @uncommon;
    return \@uncommon
}

use Test2::V0;
plan(3);

is uncommon_words('Mango is sweet', 'Mango is sour'),
    bag { item $_ for 'sweet', 'sour'; end() },
    'Example 1';

is uncommon_words('Mango Mango', 'Orange'),
    ['Orange'],
    'Example 2';

is uncommon_words('Mango is Mango', 'Orange is Orange'),
    [""],
    'Example 3';

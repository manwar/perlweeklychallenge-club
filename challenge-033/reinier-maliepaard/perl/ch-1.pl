#!/usr/bin/perl
use strict;
use warnings;

sub count_letters {
    my ($str) = @_;
    my %tot;

    $tot{lc $_}++ for $str =~ /[a-z]/ig;

    for my $char (sort keys %tot) {
        print "$char: $tot{$char}\n";
    }

    # If you want all letters a–z (including zeros)
    # for my $char ('a' .. 'z') {
    #    print "$char: ", ($tot{$char} // 0), "\n";
    # }
}

# Tests
my $str;

# Example 1
$str = "Abracadabra";
print count_letters($str), "\n";

# Output:
a: 5
b: 2
c: 1
d: 1
r: 2

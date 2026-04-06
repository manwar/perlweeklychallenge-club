#!/usr/bin/perl
use strict;
use warnings;

sub sequence_number {
    my ($aref) = @_;

    for my $index (0..$#$aref) {
        my $str = $aref->[$index];

        # Validation: must be exactly 6 chars, first two a-z, last four digits
        die "Invalid element '$str' at index $index\n"
            unless $str =~ /^[a-z]{2}\d{4}$/;

        # sprintf formats numbers as strings, letting us control width and padding
        substr($aref->[$index], 0, 2) = sprintf "%02d", $index;
    }

    return $aref;
}

# Tests

my @list;

# Example 1
@list = ('ab1234', 'cd5678', 'ef1342');
print "(", join(", ", @{ sequence_number(\@list) }), ")\n"; # Output: ('001234', '015678', '021342')

# Example 2
@list =  ('pq1122', 'rs3334');
print "(", join(", ", @{ sequence_number(\@list) }), ")\n"; # Output: ('001122', '013334')

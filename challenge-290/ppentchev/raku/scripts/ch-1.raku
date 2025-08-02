#!/usr/bin/raku
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v6.d;

use Test;

class TestCase {
    has Int:D @.seq is required is readonly;
    has Bool:D $.expected is required is readonly;
}

my constant @TEST_SEQUENCES = (
    # The test sequences from the problem
    TestCase.new(seq => (6, 2, 2, 3), expected => True),
    TestCase.new(seq => (3, 1, 4, 13), expected => False),
    TestCase.new(seq => (2, 1, 4, 2), expected => True),

    # Let's start simple...
    TestCase.new(seq => (), expected => False),
    TestCase.new(seq => (0), expected => False),
    TestCase.new(seq => (0, 0), expected => True),
    TestCase.new(seq => (0, 1), expected => False),
    TestCase.new(seq => (1, 0, 0), expected => True),
    TestCase.new(seq => (2, 0, 1), expected => True),

    # ...and work our way towards some more complex cases
    TestCase.new(seq => (1, 2, 3, 4), expected => True),
    TestCase.new(seq => (1, 2, 3, 5), expected => True),
    TestCase.new(seq => (1, 3, 4, 5), expected => False),

    # Make sure we don't mix doubles and halves
    TestCase.new(seq => (1, 4), expected => False),
    TestCase.new(seq => (1, 2, 4), expected => True),
);

sub doubles-exist(Int:D @seq) returns Bool:D
{
    my SetHash[Int:D] $seen = SetHash[Int:D].new;
    for @seq {
        return True if $_ * 2 ∈ $seen;

        if (($_ % 2) == 0) {
            return True if ($_ div 2) ∈ $seen;
        }

        $seen.set($_);
    }
    False
}

plan @TEST_SEQUENCES.elems;

for @TEST_SEQUENCES {
    is $_.expected, doubles-exist $_.seq;
}

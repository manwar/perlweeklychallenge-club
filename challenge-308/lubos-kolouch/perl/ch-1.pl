#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;

=pod

=head1 Task 1: Count Common

Given two array of strings, @str1 and @str2,
return the count of common strings in both arrays.

Examples:
  Input: @str1 = ("perl", "weekly", "challenge")
         @str2 = ("raku", "weekly", "challenge")
  Output: 2

  Input: @str1 = ("perl", "raku", "python")
         @str2 = ("python", "java")
  Output: 1

  Input: @str1 = ("guest", "contribution")
         @str2 = ("fun", "weekly", "challenge")
  Output: 0

=cut

# typedef: In this context, our inputs are array refs of strings (ArrayRef[Str]).

sub count_common {
    my ( $arr1_ref, $arr2_ref ) = @_;

# Validate that each input is an array reference of strings (not enforced, but assumed)

    # Use a hash to track the unique strings in the first array.
    my %common;
    foreach my $elem (@$arr1_ref) {
        $common{$elem} = 1;
    }

    my $count = 0;

    # For every element in the second array, check for existence in %common
    foreach my $elem (@$arr2_ref) {
        if ( exists $common{$elem} ) {
            $count++;

            # Remove to prevent duplicate counting if repeated in second array.
            delete $common{$elem};
        }
    }
    return $count;
}

# Unit tests
is(
    count_common(
        [ "perl", "weekly", "challenge" ],
        [ "raku", "weekly", "challenge" ]
    ),
    2,
    "Example 1"
) or diag "Failed for Example 1";

is( count_common( [ "perl", "raku", "python" ], [ "python", "java" ] ),
    1, "Example 2" )
  or diag "Failed for Example 2";

is(
    count_common(
        [ "guest", "contribution" ],
        [ "fun",   "weekly", "challenge" ]
    ),
    0,
    "Example 3"
) or diag "Failed for Example 3";

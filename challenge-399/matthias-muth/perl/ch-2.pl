#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 399 Task 2: Longest Absolute Path
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( max );

sub longest_absolute_path( $fs ) {
    my ( @relevant_entries, %dirs );
    my @current_path = ();
    while ( $fs =~ /(\t*)(\N+)/g ) {
        my ( $level, $name ) = ( length( $1 ), $2 );

        # Cut back the path to the current level.
        splice @current_path, $level;

        # Before adding the new element, mark the current path as
        # being a directory.
        my $dir = join "/", @current_path;
        $dirs{$dir} = 1;

        # Add the new element to the current path used for subsequent
        # input lines.
        push @current_path, $name;

        # Only remember entries that contain a '.'.
        push @relevant_entries, join "/", @current_path
            if $name =~ /\./;
    }

    # Find the longest path after checking it is not a directory.
    return max(
        map { $dirs{$_} ? () : length( $_ ) } @relevant_entries
    ) // 0;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2", 0 ],
    [ "Example 2", "file1.txt\nfile2.ext\na.png", 9 ],
    [ "Example 3",
        "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png",
        38 ],
    [ "Example 4", "root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt", 14 ],
    [ "Example 5",
        "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n"
            . "\tvery_long_directory_name\n\t\tf.txt",
        32 ],
    [ "Own Test 1", "a\n\tb\n\t\tc\n\t\t\td.dir\n\t\t\t\te\nx.txt\n", 5 ],
);

is longest_absolute_path( $_->[1] ), $_->[2], $_->[0]
    for @tests;

done_testing;

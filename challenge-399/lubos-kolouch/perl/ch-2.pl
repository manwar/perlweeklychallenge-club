#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=head1 NAME

ch-2.pl - Longest Absolute Path

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 399, Task 2: Longest Absolute Path.
Given an abstracted filesystem string with newline-separated entries indented
by tabs, returns the length of the longest absolute path to a file (an entry
containing a C<.> character), or C<0> if no file exists.

=head1 FUNCTIONS

=head2 longest_absolute_path($fs)

Parses the filesystem representation C<$fs> and returns the maximum absolute
file path length, or C<0> when no files are present.

=cut

signature_for longest_absolute_path => (
    method     => 0,
    positional => [Str],
);

sub longest_absolute_path ($fs) {
    my @depth_len;
    my $max_len = 0;

    for my $line ( split /\n/msx, $fs ) {
        my ($tabs) = $line =~ m/\A(\t*)/msx;
        my $depth  = length $tabs;
        my $name   = substr $line, $depth;

        my $cur_len = ( $depth == 0 ? 0 : $depth_len[ $depth - 1 ] + 1 ) + length $name;
        $depth_len[$depth] = $cur_len;

        if ( index( $name, q{.} ) != -1 ) {
            $max_len = $cur_len if $cur_len > $max_len;
        }
    }

    return $max_len;
}

is( longest_absolute_path("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"),                                0,  'Example 1' );
is( longest_absolute_path("file1.txt\nfile2.ext\na.png"),                                             9,  'Example 2' );
is( longest_absolute_path("my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"),             38, 'Example 3' );
is( longest_absolute_path("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt"),                           14, 'Example 4' );
is( longest_absolute_path("a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"), 32, 'Example 5' );
done_testing();

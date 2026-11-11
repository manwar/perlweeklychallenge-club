#!/usr/bin/env perl
#
=head1 Task 2: Longest Absolute Path

Submitted by: Mohammad Sajid Anwar

You are given a filesystem as string.
Write a script to return the length of the longest absolute path to a file in
the abstracted file system. If there is no file in the system, return 0.

    dir
    - subdir1
      - file1.ext
      - subsubdir1
    - subdir2
      - subsubdir2
        - file2.ext

The above filesystem can be represented as below:
"dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext"

=head2 Example 1

    Input: $fs = "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"
    Output: 0

    There are no files in the system (a file must contain a . character
    separating a name and extension).
    Since there are no files, the answer is 0.

=head2 Example 2

    Input: $fs = "file1.txt\nfile2.ext\na.png"
    Output: 9

    All entries are located at root depth (0 tabs).
    Found File Paths:
        "file1.txt" (length = 9)
        "file2.ext" (length = 9)
        "a.png"     (length = 5)
    The longest absolute file path length is 9.

=head2 Example 3

    Input: $fs = "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"
    Output: 38

    Notice project v1.0 is a directory (it has children beneath it), while
    notes v1.txt and image.png are files.
    Found File Paths:
        "my documents/project v1.0/notes v1.txt" (length = 38)
        "my documents/image.png" (length = 22)
    The maximum absolute length is 38.

=head2 Example 4

    Input: $fs = "root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt"
    Output: 14

    Found File Paths:
        "root/a/b/c.txt" => 4 + 1 + 1 + 1 + 1 + 1 + 5 = 14
        "root/d/e.txt"   => 4 + 1 + 1 + 1 + 5 = 12
    The longest file path is "root/a/b/c.txt" with length 14.

=head2 Example 5

    Input: $fs = "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"
    Output: 32

    Found File Paths:
        "a/b/c/d/e.txt" => 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 5 = 13
        "a/very_long_directory_name/f.txt" => 1 + 1 + 24 + 1 + 5 = 32
    The long directory name compensates for depth, giving a max length of 32.

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use List::Util qw/max/;

my @cases = (
    {fs => "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2",
        out => 0, name => 'Example 1'},
    {fs => "file1.txt\nfile2.ext\na.png",
        out => 9, name => 'Example 2'},
    {fs => "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png",
        out => 38, name => 'Example 3'},
    {fs => "root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt",
        out => 14, name => 'Example 4'},
    {fs => "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt",
        out => 32, name => 'Example 5'},
);

sub longest_absolute_path
{
    my $fs = shift;

    my %tmp = (-1 => 0);
    my $ret = 0;

    for my $line (split /\n/, $fs) {
        my $depth = () = $line =~ /\t/g;
        $tmp{$depth} = $tmp{$depth - 1} + length($line) - $depth;
        $ret = max($ret, $tmp{$depth} + $depth) if $line =~ /\./;
    }

    return $ret;
}

for my $case (@cases) {
    my $got = longest_absolute_path($case->{fs});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;

#!/usr/bin/env perl
#
=head1 Task 2: Copy Directory

Submitted by: Julien Fiegehenn

You are given path to two folders, $source and $target.

Write a script that recursively copy the directory from $source to $target
except any files.

=head2 Example

    Input: $source = '/a/b/c' and $target = '/x/y'

    Source directory structure:

    +-- a
    |   +-- b
    |       +-- c
    |           |-- 1
    |           |   +-- 1.txt
    |           |-- 2
    |           |   +-- 2.txt
    |           |-- 3
    |           |   +-- 3.txt
    |           |-- 4
    |           |-- 5
    |               +-- 5.txt

    Target directory structure:

    +-- x
    |   +-- y

    Expected Result:

    +-- x
    |   +-- y
    |       |-- 1
    |       |-- 2
    |       |-- 3
    |       |-- 4
    |       |-- 5

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use File::Find;
use File::Path qw/make_path/;
use Cwd qw/cwd/;

my $cases = [
    [['/a/b/c', '/x/y'], 1, 'Example 1'],
];

sub copy_directory
{
    my $source = '.' . $_[0]->[0];
    my $target = '.' . $_[0]->[1];

    my $dir = cwd;
    find(sub 
        {
           my $path = $File::Find::name;
           if (-d) {
               $path =~ s!^$source!$target!;
               $path = "$dir/$path";
               make_path($path) || die "mkdir $path failed: $!\n";;
           }
        },
        $source);

    print `find $target`, "\n";
    return 1;
}

`rm -rf x a`;
`mkdir -p a/b/c/1 a/b/c/2 a/b/c/3 a/b/c/4 a/b/c/5/8`;
`touch a/b/c/1/1.txt`;
`touch a/b/c/2/2.txt`;
`touch a/b/c/3/3.txt`;
`touch a/b/c/5/5.txt`;

for (@$cases) {
    is(copy_directory($_->[0]), $_->[1], $_->[2]);
}
done_testing();

`rm -rf x a`;

exit 0;

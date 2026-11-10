#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    {
        in  => "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2",
        out => 0
    },
    {
        in => "file1.txt\nfile2.ext\na.png",
        out => 9
    },
    {
        in => "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png",
        out => 38
    },
    {
        in => "root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt",
        out => 14
    },
    {
        in => "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt",
        out => 32
    },
);

is longest_absolute_path($_->{in}), $_->{out} foreach @examples;

done_testing;

sub longest_absolute_path($fs) {
    my %lens;
    my $max = 0;

    for my $line (split /\n/, $fs) {
        my $depth = $line =~ tr/\t//;
        my $name  = substr $line, $depth;
        my $len   = ($depth ? $lens{$depth - 1} + 1 : 0) + length $name;

        $lens{$depth} = $len;
        $max = $len > $max ? $len : $max if $name =~ /\./;
    }
    return $max;
}

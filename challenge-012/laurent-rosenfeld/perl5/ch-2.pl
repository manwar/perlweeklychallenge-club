#!/usr/bin/perl
use strict;
use warnings;
use feature "say";

die "This program needs a separator and at least 2 paths\n"
    if @ARGV < 3;
my ($separator, @paths) = @ARGV;
chomp @paths;
my @common_path = split $separator, shift @paths;
for my $new_path (@paths) {
    my @new_path_pieces = split $separator, $new_path;
    my $min_length = @new_path_pieces < @common_path ?
        @new_path_pieces : @common_path;
    for my $i (0..$min_length - 1) {
        if ($common_path[$i] ne $new_path_pieces[$i]) {
            @common_path = @common_path[0..$i-1];
            last;
        }
    }
}
say join $separator, @common_path;

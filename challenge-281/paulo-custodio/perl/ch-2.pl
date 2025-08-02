#!/usr/bin/env perl

# Challenge 281
#
# Task 2: Knight's Move
# Submitted by: Peter Campbell Smith
#
# A Knight in chess can move from its current position to any square two rows
# or columns plus one column or row away. So in the diagram below, if it starts
# a S, it can move to any of the squares marked E.
#
# Write a script which takes a starting position and an ending position and
# calculates the least number of moves required.
#
# Example 1
#
# Input: $start = 'g2', $end = 'a8'
# Ouput: 4
#
# g2 -> e3 -> d5 -> c7 -> a8
#
# Example 2
#
# Input: $start = 'g2', $end = 'h2'
# Ouput: 3
#
# g2 -> e3 -> f1 -> h2

use Modern::Perl;

@ARGV==2 or die "Usage: $0 start end\n";
my($start, $end) = @ARGV;
for ($start, $end) {
    /^[a-h][1-8]$/ or die "Usage: $0 start end\n";
}
say find_path_size($start, $end);

sub find_path_size {
    my($start, $end) = @_;

    my $min_path;
    my @paths = ([[$start], {$start=>1}]);
    while (@paths) {
        my @top = @{shift(@paths)};
        my @path = @{$top[0]};
        my %seen = %{$top[1]};

        # check if we found a solution
        if ($path[-1] eq $end) {                # found one solution
            if (!defined($min_path) || $min_path > scalar(@path)) {
                $min_path = scalar(@path);      # found shorter solution
            }
        }

        # prune the tree
        if (defined($min_path) && scalar(@path) > $min_path) {
            next;
        }

        # find 8 next positions and push them to @paths
        my @dest = knight_jump($path[-1]);
        for (@dest) {
            if (!$seen{$_}) {
                push @paths, [[@path, $_], {%seen, $_=>1}];
            }
        }
    }
    return $min_path-1;     # remove start position
}

sub row_col {
    my($coord) = @_;
    $coord =~ /^[a-h][1-8]$/ or die;
    my @coord = split //, $coord;
    my $row = 8 - $coord[1];
    my $col = (ord($coord[0])-ord('a'));
    return ($row, $col);
}

sub coord {
    my($row, $col) = @_;
    return if $row<0 || $row>7;
    return if $col<0 || $col>7;
    return chr($col+ord('a')).(8-$row);
}

sub knight_jump {
    my($start) = @_;
    my($row, $col) = row_col($start);
    my @dest;
    my $end;

    $end = coord($row-2, $col-1); push @dest, $end if defined $end;
    $end = coord($row-2, $col+1); push @dest, $end if defined $end;
    $end = coord($row+2, $col-1); push @dest, $end if defined $end;
    $end = coord($row+2, $col+1); push @dest, $end if defined $end;
    $end = coord($row-1, $col-2); push @dest, $end if defined $end;
    $end = coord($row+1, $col-2); push @dest, $end if defined $end;
    $end = coord($row-1, $col+2); push @dest, $end if defined $end;
    $end = coord($row+1, $col+2); push @dest, $end if defined $end;

    return @dest;
}

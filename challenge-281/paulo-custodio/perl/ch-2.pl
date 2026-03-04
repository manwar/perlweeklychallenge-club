#!/usr/bin/env perl

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
            next;
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

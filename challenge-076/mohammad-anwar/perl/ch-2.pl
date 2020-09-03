#!/usr/bin/perl

#
# Perl Weekly Challenge - 076
#
# Task #2: Word Search
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-076
#

$|=1;

use strict;
use warnings;

our $DEBUG = 0;

END {
    my $time = time - $^T;
    my $mm   = $time / 60;
    my $ss   = $time % 60;
    my $hh   = $mm / 60;
    $mm = $mm % 60;

    print sprintf("The program ran for %02d:%02d:%02d.\n", $hh, $mm, $ss);
}

if ($ARGV[0] eq '-h') {
    print STDOUT <<EOM;

perl ch-2.pl <word size> <path to search grid file> <path to dictionary file>

OPTIONS:
    <word size>
    The minimum word size to be search.

    <path to search grid file>
    Search grid file containing the grid provided in the task.

    <path to dictionary file>
    File containing words, one word per line. Default "/usr/share/dict/words".

EOM
    exit 1;
}

my $SIZE = $ARGV[0];
my $GRID = $ARGV[1];
my $DICT = $ARGV[2] || "/usr/share/dict/words";

die "ERROR: Missing word size.\n" unless defined $SIZE;
die "ERROR: Missing grid file.\n" unless defined $GRID;
die "ERROR: Invalid word size [$SIZE].\n"
    unless (($SIZE =~ /^\d+$/) && ($SIZE > 0));

my $words = search_words($DICT, $GRID, $SIZE);
if (keys %$words) {
    print sprintf("\nFound %d unique words:\n%s\n",
          scalar(keys %$words),
          join(", ", sort { $a cmp $b } keys %$words));
}
else {
    print sprintf("None word of size %d found.\n", $SIZE);
}


#
#
# METHODS

sub search_words {
    my ($dict, $grid, $size) = @_;

    my $words   = ();
    my $dicts   = fetch_dicts($dict, $size);
    my $puzzles = fetch_puzzles($grid, $size);
    if (scalar @$puzzles) {
        my $total = $#$puzzles + 1;
        my $index = 1;
        foreach my $puzzle (@$puzzles) {
            print sprintf("\rProcessing record %d of %d.", $index++, $total);
            $words = match_word($dicts, $puzzle, $words);
        }
    }

    return $words;
}

sub match_word {
    my ($dictionary, $puzzle, $words) = @_;

    foreach my $word (keys %$dictionary) {
        $words->{lc $word} = 1 if ($puzzle =~ /$word/i);
    }

    return $words;
}

sub fetch_dicts {
    my ($dictionary, $size) = @_;

    my $words = ();
    open(my $WORDS, "<", $dictionary)
        or die "ERROR: Can't open $dictionary file: $!.\n";
    while (my $word = <$WORDS>) {
        chomp $word;
        next unless (length($word) >= $size);
        $words->{lc $word} = 1;
    }
    close $WORDS;

    return $words;
}

sub fetch_puzzles {
    my ($grid, $size) = @_;

    my $data = fetch_data($grid);
    my ($origin, $matrix) = horizontals($size, $data);

    my $puzzles = [];
    if (@$origin) {
        $matrix = verticals($size, $origin, $matrix);
        $matrix = top_right_diagonal($size, $origin, $matrix);
        $matrix = top_left_diagonal($size, $origin, $matrix);

        my $cols = @{$origin->[0]};
        my $rows = @$origin;
        for my $string (sort { $matrix->{$b} <=> $matrix->{$a} } keys %$matrix) {
            print "$string =>" . $matrix->{$string} . "\n" if $DEBUG;
            push @$puzzles, $string;
        }

        print sprintf("Matrix [%d x %d]: %d unique records found.\n", $rows, $cols, (scalar @$puzzles));
    }

    return $puzzles;
}

sub horizontals {
    my ($size, $data) = @_;

    my $origin = [];
    my $matrix = {};
    foreach my $line (@$data) {
        chomp $line;
        $line =~ s/\s+//g;

        my $l = "";
        my @l = ();
        foreach my $char (split //,$line) {
            push @l, $char;
            $l .= $char;
        }
        next unless (length($l) >= $size);

        push @$origin, [ @l ];
        $matrix->{$l} = length($l);
        $matrix->{scalar reverse $l} = length($l);
    }

    return ($origin, $matrix);
}

sub verticals {
    my ($size, $origin, $matrix) = @_;

    my $cols = @{$origin->[0]};
    my $rows = @$origin;
    print "verticals() [$rows-1][$cols-1]\n" if $DEBUG;
    foreach my $c (0 .. $cols-1) {
        my $l = "";
        foreach my $r (0 .. $rows-1) {
            $l .= $origin->[$r][$c];
            print "[$r][$c]\n" if $DEBUG;
        }
        print "------\n" if $DEBUG;
        next unless (length($l) >= $size);

        $matrix->{$l} = length($l);
        $matrix->{scalar reverse $l} = length($l);
    }

    return $matrix;
}

sub top_right_diagonal {
    my ($size, $origin, $matrix) = @_;

    print "top_right_diagonal()\n" if $DEBUG;
    my ($row, $col);

    $row = 0;
    while($row < @$origin){
        my $l = "";
        my $r = $row;
        $col  = @{$origin->[0]}-1;
        while ($r >= 0) {
            $l .= $origin->[$r][$col];
            print "[$r][$col]\n" if $DEBUG;
            $r--;
            $col--;
        }
        $row++;
        print "------\n" if $DEBUG;
        next unless (length($l) >= $size);

        $matrix->{$l} = length($l);
        $matrix->{scalar reverse $l} = length($l);
    }

    $col = @{$origin->[0]} - 2;
    while ($col >= 0){
        my $l = "";
        my $c = $col;
        $row = @$origin - 1;
        while ($row >= 0 && $c >= 0){
            $l .= $origin->[$row][$c];
            print "[$row][$c]\n" if $DEBUG;
            $row--;
            $c--;
        }
        $col--;
        print "------\n" if $DEBUG;
        next unless (length($l) >= $size);

        $matrix->{$l} = length($l);
        $matrix->{scalar reverse $l} = length($l);
    }

    return $matrix;
}

sub top_left_diagonal {
    my ($size, $origin, $matrix) = @_;

    print "top_left_diagonal()\n" if $DEBUG;
    my ($row, $col);

    $row = 0;
    while($row < @$origin){
        my $l = "";
        $col  = 0;
        my $r = $row;
        while ($col < @{$origin->[0]} && $r >= 0) {
            $l .= $origin->[$r][$col];
            print "[$r][$col]\n" if $DEBUG;
            $r--;
            $col++;
        }
        $row++;
        print "------\n" if $DEBUG;
        next unless (length($l) >= $size);

        $matrix->{$l} = length($l);
        $matrix->{scalar reverse $l} = length($l);
    }

    $col = 1;
    while ($col < @{$origin->[0]}) {
        my $l = "";
        my $c = $col;
        $row  = @$origin - 1;
        while ($row >=0 && $c < @{$origin->[0]}){
            $l .= $origin->[$row][$c];
            print "[$row][$c]\n" if $DEBUG;
            $row--;
            $c++;
        }
        $col++;
        print "------\n" if $DEBUG;
        next unless (length($l) >= $size);

        $matrix->{$l} = length($l);
        $matrix->{scalar reverse $l} = length($l);
    }

    return $matrix;
}

sub fetch_data {
    my ($grid) = @_;

    open(my $FILE, "<", $grid)
        || die "ERROR: Can't open $grid: $!\n";
    my @data = <$FILE>;
    close $FILE;

    return \@data;
}

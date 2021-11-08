#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub populate {
    my ($rows, $cols) = @_;
    my @table;
    for my $x (1 .. $rows) {
        for my $y (1 .. $cols) {
            $table[ $x - 1 ][ $y - 1 ] = $x * $y;
        }
    }
    return \@table
}

sub header_line {
    my ($cols, $width, $header_width) = @_;
    printf "%${header_width}s |", 'x';
    print join ' ', map sprintf("%${width}d", $_), 1 .. $cols;
    print "\n";

    print '-' x $header_width, '-+';
    print '-' x $width;
    print '-' x $width, '-' for 2 .. $cols;
    print "\n";

}

sub distinct_term_counts {
    my ($rows, $cols) = @_;
    my $table = populate($rows, $cols);
    my $width = length $table->[-1][-1];
    my $header_width = length $rows;

    header_line($cols, $width, $header_width);

    my %distinct;
    for my $x (0 .. $rows - 1) {
        printf "%${header_width}d |", $x + 1;
        print join ' ', map {
            undef $distinct{ $table->[$x][$_] };
            sprintf "%${width}d", $table->[$x][$_];
        } 0 .. $cols - 1;
        print "\n";
    }
    say 'Distinct terms: ', join ', ', sort { $a <=> $b } keys %distinct;
    say 'Count: ', scalar keys %distinct;
}

distinct_term_counts(3, 5);

#!/usr/bin/perl
# Test: ./ch2.pl
use strict;
use warnings;

generate_x_table(11);

# Generates the multiplication table
sub generate_x_table {
    my $num = shift;

    for my $i (0..$num) {
        my $line = ($i == 0) ?
            _table_head($num) :
            _table_body($i, $num);
        print $line;
    }
}

# Returns the table head string
sub _table_head {
    my $num = shift;
    my $line = sprintf ("%4s|", 'x');

    for my $i (1..$num) {
        $line .= sprintf("%4i", $i);
    }

    return $line . "\n" . '----+' . '----' x $num . "\n";
}

# Returns the table row string for $i
sub _table_body {
    my ($current, $num) = @_;
    my $line = sprintf ("%4i|", $current);

    for my $i (1..$num) {
        $line .= ($current <= $i) ?
            sprintf("%4i", $i * $current) : ' ' x 4;
    }

    $line .= "\n";

    return $line;
}

#!/usr/bin/perl

# Write a script to print 11x11 multiplication table, only the top half triangle.

use strict;
use warnings;

# We do this so we can set it to any matrix size
my ($min,$max) = (1,11);
my $w = 1 + length $max**2;
my @range = ($min..$max);

# Headers
render_row(form_cell("x"), "|", map (form_cell($_), @range));
render_row(form_cell("-"x$w), "+", map (form_cell("-"x$w), @range));

# Data
for my $row_index (@range){
    # Don't you just love map?
    my @row = map { $row_index <= $_ ? form_cell( $row_index * $_ ) : form_cell("") } @range;

    render_row(form_cell( $row_index ),"|",@row);
}

sub form_cell{
    return sprintf "%".$w."s",shift;
}

sub render_row{
    my ($firstCol,$break,@cols) = @_;
    print $firstCol,$break,@cols,"\n";
}

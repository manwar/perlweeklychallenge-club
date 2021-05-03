#!/usr/bin/perl
# The Weekly Challenge #110 Task 2
# Transpose File
use strict;
use warnings;
use Text::CSV_XS qw/csv/;

my $file_name = $ARGV[0];

my $csv_file = csv (in => $file_name, sep_char => ",");

my $old_num_row = scalar @{$csv_file};
my $old_max_num_col = 1;
for my $field (@{$csv_file}) {
    my $len = scalar @{$field};
    $old_max_num_col = $len if $len > $old_max_num_col;
}

for my $i (0..$old_max_num_col-1) {
    print_item($csv_file->[0]->[$i]);
    for my $k (1..$old_num_row-1) {
        print ",";
        print_item($csv_file->[$k]->[$i]);
    }
    print "\n";
}

sub print_item {
    my $item = $_[0];
    if (defined($item)) {
        print "\"" if $item  =~ /,/;
        print $item;
        print "\"" if $item  =~ /,/;
    }
}

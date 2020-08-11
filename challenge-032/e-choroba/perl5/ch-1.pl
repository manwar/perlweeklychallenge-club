#! /usr/bin/perl
use warnings;
use strict;

use Getopt::Long;
use Text::CSV_XS qw{ csv };
use List::Util qw{ max };

use open IO => ':encoding(UTF-8)', ':std';

GetOptions(csv => \ my $csv_output);

my %count;
chomp, ++$count{$_} while <>;

if ($csv_output) {
    csv(in => [
        map [$_, $count{$_} ],
        sort { $count{$b} <=> $count{$a} }
        keys %count]);

} else {
    my $max_length = max(map length, keys %count);
    printf "%${max_length}s %d\n", $_, $count{$_}
        for sort { $count{$a} <=> $count{$b} } keys %count;
}

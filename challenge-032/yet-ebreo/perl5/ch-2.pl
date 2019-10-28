#!/usr/bin/perl
# Write a function that takes a hashref where the keys are labels 
# and the values are integer or floating point values. 
# Generate a bar graph of the data and display it to stdout.

# The input could be something like:

# $data = { apple => 3, cherry => 2, banana => 1 };
# generate_bar_graph($data);
# And would then generate something like this:

#  apple | ############
# cherry | ########
# banana | ####
# If you fancy then please try this as well: (a) the function could let you specify whether the chart should be ordered by (1) the labels, or (2) the values.
use strict;
use warnings;
use feature 'say';
sub generate_bar_graph {
    my @keys;
    my ($data,$opt) = @_;
    my $longest     = 0;
    my @sorted      = sort keys %{$data};
    for my $word (@sorted) {
        $longest = length $word if $longest < length $word;
    }
    
    @keys = ($opt eq "values")?sort { ${$data}{$b}-${$data}{$a} } @sorted:@sorted;
    
    for my $word (@keys) {
        printf ("%${longest}s | %s\n",$word, "####" x ${$data}{$word});
    }
}

my $data = { apple => 3, cherry => 2, banana => 1 };
say "Bar graph sorted by labels:";
generate_bar_graph($data,"labels");
say "\nBar graph sorted by values:";
generate_bar_graph($data,"values");
=begin
perl .\ch-2.pl
Bar graph sorted by labels:
 apple | ############
banana | ####
cherry | ########

Bar graph sorted by values:
 apple | ############
cherry | ########
banana | ####
=cut
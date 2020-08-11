#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );
use Data::Dumper;
$Data::Dumper::Terse = 1;
use Getopt::Long;

# Create a script that either reads standard input or one or more files specified on the command-line. Count the number of times and then print a summary, sorted by the count of each entry.
# For extra credit, add a -csv option to your script, which would generate, comma separated values.

my $csv;
my @file;
GetOptions (
	"csv"    => \$csv,
	"file=s" => \@file,
);
usage() unless (@file);
$csv = ($csv) ? ',' : '';

my $href = {};                                  # hash ref to hold results
foreach (@file) {                               # iterate over all the user supplied files
	open (my $fh, '<', $_) or do { warn "Can not open $_: $!"; next; };
	while (<$fh>) {        
		chomp;                          # remove newline char at end of string
		$_ =~ s/[^a-zA-Z0-9]/ /g;       # replace all non alpha chars with space 
		my @words = split(/ /, $_);     # split on space filling an array with words
		$href->{$_}++ foreach (@words); # count the word's occurance
	}
	close $fh;
}
# print out words in alphabetical order with counts
say "$_$csv $href->{$_}" foreach (sort {lc($a) cmp lc($b)} (keys %{$href}));

# save out hash ref for ch-2.pl to use as input
my $file_name = 'ch-1.data.out';
open(my $fh, '>', $file_name) or die "Could not open file '$file_name' $!";
print $fh Dumper($href);
close $fh;

sub usage {
        print <<EOU;
Usage:
$0 -csv -f filename -f filename ...
$0 -csv -f example1.txt -f example2.txt
EOU
        exit;
}

__END__

./ch-1.pl -f example1.txt
apple 3
banana 1
Broccoli 6
celery 6
cherry 2
kumquat 1
plum 2
tomato 1
zucchini 8

./ch-1.pl -f example1.txt -f example2.txt -csv
apple, 6
banana, 2
Broccoli, 12
celery, 14
cherry, 4
kumquat, 2
plum, 4
tomato, 2
zucchini, 16

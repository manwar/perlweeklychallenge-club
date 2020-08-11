#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );
use Getopt::Long;

# Create a script that accepts one or more files specified on the command-line and count the number of times letters appeared in the files.

my @file;
GetOptions (
	"file=s" => \@file,
);
usage() unless (@file);

my $href = {};                                  				# hash ref to hold results
foreach (@file) {                               				# Iterate over all the user supplied files
	open (my $fh, '<', $_) or do { warn "Can not open $_: $!"; next; };  	# If we can't open the file warn and move on
	while (<$fh>) {        							# Iterate over lines in the file
		my $line = lc($_);						# Convert chars to lower case
		$href->{$_} += () = $line =~ /$_/g foreach ('a' .. 'z');	# Populate results hosh with letter counts
	}
	close $fh;
}

# Print out the occurance of letters a .. z
say "$_: $href->{$_}" foreach ('a' .. 'z');

sub usage {
        print <<EOU;
Usage:
$0 -f filename -f filename ...
$0 -f quickbrownfox.txt
EOU
        exit;
}

__END__

./ch-1.pl 
Usage:
./ch-1.pl -f filename -f filename ...
./ch-1.pl -f quickbrownfox.txt

./ch-1.pl -f quickbrownfox.txt 
a: 1
b: 1
c: 1
d: 1
e: 3
f: 1
g: 1
h: 2
i: 1
j: 1
k: 1
l: 1
m: 1
n: 1
o: 4
p: 1
q: 1
r: 2
s: 1
t: 2
u: 2
v: 1
w: 1
x: 1
y: 1
z: 1

./ch-1.pl -f quickbrownfox.txt -f quickbrownfox.txt -f quickbrownfox.txt # <==== triple the letter counts by inputting same file 3 times
a: 3
b: 3
c: 3
d: 3
e: 9
f: 3
g: 3
h: 6
i: 3
j: 3
k: 3
l: 3
m: 3
n: 3
o: 12
p: 3
q: 3
r: 6
s: 3
t: 6
u: 6
v: 3
w: 3
x: 3
y: 3
z: 3


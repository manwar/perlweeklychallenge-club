#!/usr/bin/perl
# Count Letters (A..Z)
# Create a script that accepts one or more files specified on the command-line and count the number of times letters appeared in the files.
use strict;
use warnings;
use feature 'say';

die "Usage:\n\tch-1.pl <file1> .. <fileX>\n\n" if (!@ARGV);
my %hash;
for my $file (@ARGV) {
    open(my $fh, '<', $file);
    my @data = <$fh>;
    $hash{ +lc }++ for "@data"=~/\pL/g;
    close $fh;
    
}

for my $keys (sort keys %hash) {
    say "$keys: $hash{$keys}"
}

=begin
perl .\ch-1.pl .\sample.txt .\test.txt
a: 123
b: 12
c: 1
d: 16
e: 3
f: 1
g: 44
h: 9
i: 49
j: 1
k: 23
l: 22
m: 23
n: 63
o: 21
p: 13
q: 1
r: 3
s: 23
t: 15
u: 17
v: 1
w: 21
x: 1
y: 15
z: 1
Γ: 1
=cut
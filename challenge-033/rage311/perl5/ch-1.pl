#!/usr/bin/env perl

use 5.030;
use warnings;
use strict;

undef $/;

for my $file (@ARGV) {
  warn "$!" and next unless open my $fh, '<', $file;
  my %count;
  $count{$_}++ for grep { /[a-z]/ } map { lc } split //, <$fh>;
  say $file;
  say "$_: $count{$_}" for sort keys %count;
  print "\n";
}


__DATA__

Output:

ch-2.pl
a: 7
b: 3
c: 1
d: 3
e: 11
f: 5
g: 1
h: 1
i: 10
j: 1
l: 7
m: 4
n: 6
o: 4
p: 4
r: 8
s: 15
t: 11
u: 14
v: 1
w: 1
y: 5

example.txt
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


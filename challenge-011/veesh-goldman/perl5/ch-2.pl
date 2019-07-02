#! /usr/bin/env perl

# create the identity matrix of size n for any input n

my $usage = <<"EOF";
USAGE - $0 size
  size - the size of the desired identity matrix
EOF
my $size = shift or die $usage;

die "size must be a positive integer" unless $size > 0;

my @matrix; 
for my $y ( 0 .. $size - 1 ) {
  push @matrix, [];
  for my $x ( 0 .. $size - 1 ) {
    print $matrix[$y][$x] = 1 if $y == $x;
    print $matrix[$y][$x] = 0 if $y != $x;
  }
  print "\n";
}



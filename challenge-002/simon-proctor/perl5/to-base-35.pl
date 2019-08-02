use strict;
use v5.10;

my $in = shift @ARGV;
my @out = ();

my $c = 0;
my %map = map { $c++ => $_ } (0..9,"A".."Y");

while ( $in ) {
    my $rem = $in % 35;
    push @out, $map{$rem};
    $in = $in - $rem;
    $in = $in / 35;
}

say join( "", reverse @out );


#!/usr/bin/perl
use v5.34;

my $startCoord = $ARGV[0] ? $ARGV[0] : '';
my $endCoord   = $ARGV[1] ? $ARGV[1] : '';
my $verbose;
my @start;
my $path;
my $moves;
my ( $x2, $y2 );

while ( ! $startCoord || $startCoord !~ m/^[a-hA-H][1-8]$/ ) { 
    say "Enter a start coordinate of the form: A1-H8" ;
    $startCoord = <STDIN> ;
    $startCoord = uc($startCoord);
    chomp($startCoord);
}

my $x = ord( substr( lc($startCoord), 0, 1 ) ) - 96;
my $y = substr( $startCoord, 1, 1 );
print "$startCoord : ";
if   ( ( $x % 2 ) == ( $y % 2 ) ) { say "Dark";say "false"; ;}
else                              { say "Light";say "true"; ;}


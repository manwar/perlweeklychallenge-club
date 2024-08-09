#!/usr/bin/perl
use v5.34;

my $startCoord = $ARGV[0] ? $ARGV[0] : '';
my $endCoord   = $ARGV[1] ? $ARGV[1] : '';
my $verbose;
my @start;
my $path;
my $moves;
my ( $x2, $y2 );
my $help = "USAGE: ./ch-2.pl a1 h8";

if ( ! $startCoord || $startCoord !~ m/^[a-hA-H][1-8]$/ ) { say "Coordinates must be between 'A1'-'H8'"; say $help;exit }
if ( ! $endCoord   || $endCoord   !~ m/^[a-hA-H][1-8]$/ ) { say "Coordinates must be between 'A1'-'H8'"; say $help;exit }

my $x = ord( substr( lc($startCoord), 0, 1 ) ) - 96;
my $y = substr( $startCoord, 1, 1 );
push( @start, [ $x, $y, chr( $x + 64 ) . $y ] );

print "Start: " . uc($startCoord) . " : ";
if   ( ( $x % 2 ) == ( $y % 2 ) ) { say "Dark"; }
else                              { say "Light"; }

if ( $endCoord ) {
	$x2 = ord( substr( lc($endCoord), 0, 1 ) ) - 96;
	$y2 = substr( $endCoord, 1, 1 );
	print " Dest: " . uc( $endCoord ) . " : ";
    if   ( ( $x2 % 2 ) == ( $y2 % 2 ) ) { say "Dark"; }
    else                              { say "Light"; }
    
}

sub moveKnight() {
	$moves++;
	for my $l ( reverse(@start) ) {
		say "at: " . chr( $l->[0] + 64 ) . $l->[1] . "  path:$l->[2]" if $verbose;
		push( @start, [ $l->[0] + 2, $l->[1] + 1, $l->[2] . "->" . chr( $l->[0] + 64 + 2 ) . ( $l->[1] + 1 ) ] ) if ( $l->[0] < 7 && $l->[1] < 8 );
		push( @start, [ $l->[0] + 2, $l->[1] - 1, $l->[2] . "->" . chr( $l->[0] + 64 + 2 ) . ( $l->[1] - 1 ) ] ) if ( $l->[0] < 7 && $l->[1] > 1 );
		push( @start, [ $l->[0] - 2, $l->[1] + 1, $l->[2] . "->" . chr( $l->[0] + 64 - 2 ) . ( $l->[1] + 1 ) ] ) if ( $l->[0] > 2 && $l->[1] < 8 );
		push( @start, [ $l->[0] - 2, $l->[1] - 1, $l->[2] . "->" . chr( $l->[0] + 64 - 2 ) . ( $l->[1] - 1 ) ] ) if ( $l->[0] > 2 && $l->[1] > 1 );
		push( @start, [ $l->[0] + 1, $l->[1] + 2, $l->[2] . "->" . chr( $l->[0] + 64 + 1 ) . ( $l->[1] + 2 ) ] ) if ( $l->[0] < 8 && $l->[1] < 7 );
		push( @start, [ $l->[0] + 1, $l->[1] - 2, $l->[2] . "->" . chr( $l->[0] + 64 + 1 ) . ( $l->[1] - 2 ) ] ) if ( $l->[0] < 8 && $l->[1] > 2 );
		push( @start, [ $l->[0] - 1, $l->[1] + 2, $l->[2] . "->" . chr( $l->[0] + 64 - 1 ) . ( $l->[1] + 2 ) ] ) if ( $l->[0] > 2 && $l->[1] < 7 );
		push( @start, [ $l->[0] - 1, $l->[1] - 2, $l->[2] . "->" . chr( $l->[0] + 64 - 1 ) . ( $l->[1] - 2 ) ] ) if ( $l->[0] > 2 && $l->[1] > 2 );
	}

	for ( 0 .. scalar(@start) - 1 ) {
		if (   $start[$_][0] eq $x2
			&& $start[$_][1] eq $y2 )
		{
			$path++;
			print "Path $path: " ;
            local $| = 1;
            for my $char (split /(->)/, $start[$_][2]) {
                use Time::HiRes;Time::HiRes::sleep(0.06);
                print "$char";
            }  
            say ""
		}
	}

	if ($path) {
        say "In $moves moves";
		say $moves;
        exit
        } ;

	__SUB__->();
}

moveKnight() if ($endCoord);
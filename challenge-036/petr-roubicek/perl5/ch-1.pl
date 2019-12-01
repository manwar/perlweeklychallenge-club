#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw/sum/;

my $vin = uc( shift ) if @ARGV;
my $ok = 0;

if ( !defined $vin ) { print "Not defined VIN as program argument\n"; exit }
if ( length $vin != 17 ) { print "Not allowed length of VIN\n"; exit }
if ( $vin =~ /[IOQ]/ ) { print "Not allowed characters [IOQ] in VIN\n"; exit }

my ( $cr_code ) = $vin =~ /^(.{2})/;
print "Country or region code: ", $cr_code, "\n";

my $notation;
map{ $notation .= $_ }('A'..'Z',1..9,0);

# Unassigned country or ragion
my @ua_cr_def = qw/BS-B0 CS-C0 DS-D0 EL-E0 FL-F0 GA-G0 HA-H0 NS-N0 PS-P0 S5-S0 T2-T0 U8-U0 ZS-ZW Z6-Z0 30-30 83-80 90-90/;
my %ua_cr;
foreach ( @ua_cr_def ) {
	my @x = ( split //, $_ )[0,1,4];
	$x[2] = '' if $x[1] eq $x[2];
	my ( $range ) = $notation =~ /($x[1].*?$x[2])/;
	map{ $ua_cr{"$x[0]$_"} = 1 }split //, $range;
}

if ( defined $ua_cr{$cr_code} ) { print "Not allowed country or region code.\n"; exit  };

if ( $vin =~ /^[1-5|L]/ ) {
	@_ = $vin =~ /^./g;
	
	print $_[0] eq 'L' ? 'Chinese VIN testing ...\n' : 'North american VIN testing ...\n' ;
	
	# Transliteration
	my $tr = "A:1 B:2 C:3 D:4 E:5 F:6 G:7 H:8 J:1 K:2 L:3 M:4 N:5 P:7 R:9 S:2 T:3 U:4 V:5 W:6 X:7 Y:8 Z:9";
	my ( $t, $r );
	map{ my ($a,$b) = split /:/; $t.=$a; $r.=$b; }split /[ ]/, $tr;

	my $tr_vin;
	eval "\$tr_vin = (\$vin =~ tr/$t/$r/r)";

	# Weight factor
	my $weight = "1:8;2:7;3:6;4:5;5:4;6:3;7:2;8:10;9:0;10:9;11:8;12:7;13:6;14:5;15:4;16:3;17:2";
	my %weight = split /[;:]/, $weight;

	my $count;
	map{ ++$count; $weight{$count}=$weight{$count}*$_ }split //, $tr_vin;

	my $ninth = ( ( sum values %weight) % 11 ) == 10 ? 'X' : ( ( sum values %weight ) % 11 ) ;
	$ok = 1 if $vin =~ /.{8}$ninth./;
	print "Unexpected ninth char. Expected: $ninth.\n" if !$ok;
}
else {
	$ok = 1;
}

print "VIN: $vin > ";
print $ok ? "OK" : "NOK" ;

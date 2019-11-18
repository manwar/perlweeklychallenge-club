#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use Data::Dumper qw(Dumper);
use PDL;
use PDL::Core qw(pdl byte);
use PDL::IO::Image;
use PDL::ImageRGB;
use PDL::NiceSlice;

=head1 Perl Weekly Challenge #34 Task #2: Dispatch Table

This week PWC in Task #2 shall demonstrate a Dispatch Table

=head1 SYNOPSIS

 # perldoc ch-2.pl		- POD
 ./ch-2.pl <command>

 # ./ch-2.pl pdl		- Creates Hidden Grayscale from Colored Image
 # ./ch-2.pl array		- Array Version does NOT work properly
 # ./ch-2.pl html		- HTML/CSS in ch-1.html/pwc.css
 # ./ch-2.pl help		- Usage information

=head1 Dispatch Table

A Dispatch Table is simply a Hash that takes as value a code reference.
So the code can be executed when C<&{$dispatch{$command}($ARGV)}> is called,
see below:

 my $cmd = shift @ARGV;		# Read command
 $cmd = "help" if not $cmd;
 print "ch-2.pl (Version 1.0) PWC #34 Task #2: $cmd\n";

 # --- Dispatch Table
 my %dispatch = (
	html  => \&html,
	help  => \&usage,
	pdl   => \&create_with_pdl,
	array => \&create_with_array,
 );
 if( $dispatch{$command} ) { &{$dispatch{$command}}($ARGV[0]);
 else { &usage; }

=cut

my $cmd = shift @ARGV;		# Read command
$cmd = "help" if not $cmd;
print "ch-2.pl (Version 1.0) PWC #34 Task #2: $cmd\n";

# --- Dispatch Table
my %dispatch = (
	html  => \&html,
	help  => \&usage,
	pdl   => \&create_with_pdl,
	array => \&create_with_array,
);
if( $dispatch{$cmd} ) { &{$dispatch{$cmd}}; }
else { &usage; }


sub create_with_pdl {

# ------------ Read Image data: Using Hashes
my %image = (                # Initialize Hash
	base => "miracolous-image-400x533",
	file => "miracolous-image-400x533.png",
);
$image{data} = read_png($image{file}); # Assign Value to Hash Element
info_pdl($image{data},$image{file});   # Use Hash Values

# ----------- Separating RGB and Bit Plane: Hash Slices

@image{ 'red','green','blue' } = rgb($image{data});	# Assigning values to Hash slice

my @colors = ('red','green','blue');
@{ $image{bit_plane} }{ @colors } = (   # 
	[ bit_plane($image{red}) ],
	[ bit_plane($image{green}) ],
	[ bit_plane($image{blue}) ],
);
my %hidden;
@hidden{ 'bit7','bit6','bit5' } = (
	$image{bit_plane}{red}[0],
	$image{bit_plane}{green}[0],
	$image{bit_plane}{blue}[0],
);
$hidden{data} = ($hidden{bit7} << 7) | ($hidden{bit6} << 6) | ($hidden{bit5} << 5);

# ------------ Write hidden image to file ----------

my $base = "hidden-pdl";

$hidden{slice} = zeroes(byte(),200,265); # PDL with 200x265 zeroes
my $tmp = $hidden{data};    # It seems PDL::Slice does not work with complex data types
$hidden{slice} .= $tmp(0:199,0:264);      # PDL Slice with PDL::NiceSlice
write_png($hidden{slice},"$base-200x265.png"); # Write file with Hidden Image
info_pdl($hidden{slice},"$base-200x265.png");  # Info PDL of Hidden Image

write_png($hidden{data},"$base-400x533.png");  # Write file with Hidden Bit Planes
info_pdl($hidden{data},"$base-400x533.png");   # Info PDL of Hidden Bit Planes

} # --------------------------------------------------------


sub create_with_array {

# ------------ Read Image data: Using Hashes
my %image = (                # Initialize Hash
	base => "miracolous-image-400x533",
	file => "miracolous-image-400x533.png",
);
$image{data} = read_png($image{file}); # Assign Value to Hash Element
info_pdl($image{data},$image{file});   # Use Hash Values

# ----------- Separating RGB and Bit Plane: Hash Slices

my $tmp1 = $image{data}->xchg(0,2);
info_pdl($tmp1,"Exchange");

$image{array} = $tmp1->unpdl;
@image{ 'red','green','blue' } = rgb_array($image{array});

info_array($image{array});
info_array($image{red});

my @colors = ('red','green','blue');
@{ $image{bit_plane} }{ @colors } = (   # Bit Plane
	bit_plane_array($image{red}),
	bit_plane_array($image{green}),
	bit_plane_array($image{blue}),
);

# ----------- Create hidden image ----------------
my %hidden;
@hidden{ 'bit7','bit6','bit5' } = (
	$image{bit_plane}{red}[0],
	$image{bit_plane}{green}[0],
	$image{bit_plane}{blue}[0],
);
my $tmp2 = recreate(@hidden{'bit7','bit6','bit5'});
info_array($tmp1);

my $tmp3 = pdl(byte(),$tmp1);
$hidden{data} = $tmp2->xchg(0,1);
info_pdl($hidden{data},"Recreate PDL");

# ------------ Write hidden image to file ----------

my $base = "hidden-array";

$hidden{slice} = zeroes(byte(),200,265); # PDL with 200x265 zeroes
my $tmp = $hidden{data};    # It seems PDL::Slice does not work with complex data types
$hidden{slice} .= $tmp(0:199,0:264);      # PDL Slice with PDL::NiceSlice
write_png($hidden{slice},"$base-200x265.png"); # Write file with Hidden Image
info_pdl($hidden{slice},"$base-200x265.png");  # Info PDL of Hidden Image

write_png($hidden{data},"$base-400x533.png");  # Write file with Hidden Bit Planes
info_pdl($hidden{data},"$base-400x533.png");   # Info PDL of Hidden Bit Planes

} # -----------------------------------------------

sub recreate {
	my ($bit7,$bit6,$bit5) = @_;
	my @res;
	for( my $w=0; $w<=$#$bit7; $w++ ) {   # Iterate Column
		my $col = $bit7->[$w];
		for( my $h=0; $h<=$#$col; $h++ ) {  # Iterate Row
			my $v7 = $bit7->[$w][$h] << 7;
			my $v6 = $bit6->[$w][$h] << 6;
			my $v5 = $bit5->[$w][$h] << 5;
			$res[$w][$h] = $v7 | $v6 | $v5;
		}
	}
	return \@res;
}


# --------------------------- Functions ----------------------------

sub read_png {
    my ($png) = @_; 
    my $cr = PDL->rpiccan('PNG');
    if(! $cr ) { print "Error (read): Png not allowed!\n"; return 0; }
    my $tmp = PDL::IO::Pic::rpic($png, {FORMAT => 'PNG'});
}

sub write_png {
    my ($img,$png) = @_; 
    my $cr = PDL->wpiccan('PNG');
    if(! $cr ) { print "Error (write): Png not allowed!\n"; return 0; }
    PDL::IO::Pic::wpic($img,$png, {FORMAT => 'PNG'});
}

sub bit_plane {	# raw|lsb|msb
	my ($layer,$type) = @_;
	$type = "raw" if not $type;
	my @bit_plane;
	my $mask = PDL::Core::pdl(PDL::Core::byte(),0b00000001);
	for(my $i=0;$i<=7;$i++) {
		$bit_plane[$i] = $layer & $mask;
		# print "$i ", $mask, "\n";
		$mask = $mask << 1;
		if($type eq "lsb") { $bit_plane[$i] = $bit_plane[$i] >> $i; }
		elsif($type eq "msb") { $bit_plane[$i] = $bit_plane[$i] << (7 - $i); }
	}
	return @bit_plane;
}
sub bit_plane_array {	# raw|lsb|msb
	my ($layer,$type) = @_;
	$type = "raw" if not $type;
	my @bit_plane;
	my $mask = 0b00000001;
	for( my $w=0; $w<=$#$layer; $w++ ) {   # Iterate Column
		my $col = $layer->[$w];
		for( my $h=0; $h<=$#$col; $h++ ) {  # Iterate Row
			for(my $i=0;$i<=7;$i++) {		# Iterate Mask
				my $val = $col->[$h];
				$bit_plane[$i][$w][$h] = $val & $mask;
				# print "$i ", $mask, "\n";
				$mask = $mask << 1;
				if($type eq "lsb") { $bit_plane[$i][$w][$h] = $bit_plane[$i][$w][$h] >> $i; }
				elsif($type eq "msb") { $bit_plane[$i][$w][$h] = $bit_plane[$i][$w][$h] << (7 - $i); }
			}
		}
	}
	return \@bit_plane;
}

sub rgb {
	my ($img) = @_;
	my $red   = $img((0),:,:);	# PDL::NiceSlice
	my $green = $img((1),:,:);
	my $blue  = $img((2),:,:);
	return ($red,$green,$blue);
}
sub rgb_array {
	my ($img) = @_;
	return @{$img}[0..2];    # Array Slice
}
sub read_jpeg {
    my ($jpg) = @_; 
    my $cr = PDL->rpiccan('JPEG');
    if(! $cr ) { print "Error (read): Jpeg not allowed!\n"; return 0; }
    my $tmp = PDL::IO::Pic::rpic($jpg, {FORMAT => 'JPEG'});
}
sub write_jpeg {
    my ($img,$jpg) = @_; 
    my $cr = PDL->wpiccan('JPEG');
    if(! $cr ) { print "Error (write): Jpeg not allowed!\n"; return 0; }
    PDL::IO::Pic::wpic($img,$jpg, {FORMAT => 'JPEG'});
}
sub info_array {
	my ($aref) = @_;
	print "Array: Size ";
	print "$#{$aref}" if ref($aref) eq "ARRAY";
	print " x $#{$aref->[0]} " if ref($aref->[0]) eq "ARRAY";
	print " x $#{$aref->[0]->[0]}" if ref($aref->[0][0]) eq "ARRAY";
	print "\n";
}

sub info_pdl {
    my ($image,$title) = @_;
    my $dt = $image->get_datatype;
    my @type = ("byte","short","ushort","long","indx","unknown","float","double");

    my $str = "$title: ";
    $str .= " Type " . $type[$dt]    . " (" . $dt . ")";
    $str .= " Dims " . $image->ndims . " (" . join("/",( $image->dims )) . ")";
    $str .= " #Ele " . $image->nelem;
    $str .= " Sum  " . $image->sum . "\n";
    print $str;
    return $str;
}

# ================================ Usage ============================
sub usage {
	print "./ch-2.pl <command>\n";
	print "\n";
	print "   command, pdl|array|html|help\n";
	print "      pdl,   Solution for Task #1 with PDL.\n";
	print "      array, Solution for Task #1 with Array.\n";
	print "      help,  Prints out some usage information.\n";
	print "      html,  Writes HTML and CSS from POD.\n";
	print "\n";
	print "   Examples:\n";
	print "      # perldoc ch-2.pl\n";
	print "      # ./ch-2.pl pdl\n";
	print "      # ./ch-2.pl array\n";
	print "      # ./ch-2.pl help\n";
	print "      # ./ch-2.pl html\n";
}

sub html {
	# ------------- Create HTML --------------
	qx[ pod2html --header --title \"Perl Weekly Challenge #34 Task #2, Demonstrate Display Table\" --css \"pwc.css\" ch-2.pl > ch-2.html ];

	# ------------- Create CSS --------------
	my $CSS =<<CSS;
body { margin-left:auto; margin-right:auto; width:80%; }
h1   { border-bottom:4px solid red; }
h2   { border-bottom:2px solid orange; }
pre  { border:2px solid grey; background-color:#eef; padding:10px; }
li   { padding:5px; }
a    { text-decoration:none; color:black; padding:4px; }
a:hover { background-color: brown; color:white; }
._podblock_ { width:100%; background-color:black; color:white; padding:10px; }
CSS

	open(CSS, ">pwc.css") or die "Cant open pwc.css!\n";
	print CSS $CSS;
	close CSS;
}

=head1 AUTHOR

Chuck

=cut

# ############################## END #############################################


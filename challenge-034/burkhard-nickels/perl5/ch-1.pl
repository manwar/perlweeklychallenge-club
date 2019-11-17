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

=head1 Perl Weekly Challenge #34 Task #1: Array/Hash slices

This week PWC in Task #1 shall demonstrate Array Slices or Hash slices.

=head1 SYNOPSIS

 # perldoc ch-1.pl		- POD
 ./ch-1.pl <command>

 # ./ch-1.pl pdl		- Creates Hidden Grayscale from Colored Image
 # ./ch-1.pl array		- Array Version does NOT work properly
 # ./ch-1.pl html		- HTML/CSS in ch-1.html/pwc.css
 # ./ch-1.pl help		- Usage information

=cut

print "ch-1.pl (Version 1.0) PWC #34 Task #1: \n";
my $cmd = shift @ARGV;		# Read command
if(!$cmd) { usage(); exit 0; }
elsif($cmd eq "html") { html(); exit 0; }
elsif($cmd eq "help") { usage(); exit 0; }
elsif(($cmd ne "pdl") and ($cmd ne "array")) { usage(); exit 0; }

# ====================== TASK 1 ==============================

=head1 Definition Task #1: Array Slices / Hash Slices

Write a program that demonstrates using hash slices and/or array slices.

=cut

# ====================== TASK 1 ==============================

=head1 Image Processing

To demonstate some different Array and Hash slicing features I do some image processing.
An image is "data" that can be stored in 2- or 3-dimensional Arrays. To separate
the data I will store the data in Hases (Named Lists). For example a coloured image
can be separated in its 'red', 'green' and 'blue' parts.

The source is a miracolous colored image from my son. This example creates a new
miracle image (Some odd inheritance).

The steps done in this example are:

=over 3

=item * Reading Image from PNG file: Using Hash

=item * Separate RGB and Bit Plane: Hash Slices

=item * Extract hidden image from Bit 0: Hash Slice

=item * Write hidden image to file: PDL::NiceSlice

=back

=head2 Reading Image from PNG file: General Usage of a Hash

A Hash is a List of Key/Value pairs, so that values can be accessed
easily by a name (key).
In Perl a Hash is declared with a percent sign "%" (i.e. C<%hash>) 
in front of the name. The Hash can be initialized with key/value pairs.

 %hash = ( key => $value, ... );       # Initialize Hash
 $hash{ key } = $value;                # Assign Value to Hash Element
 $var = $hash{ key };                  # Get Hash Value of Key

As example I read a PNG file and store every needed parameter in a hash.
In the below example the keys C<base> (basename of file), C<file> (filename) 
and C<data> (read PDL data) are used.

 my %image = (                          # Initialize Hash
	base => "miracolous-image-400x533",
	file => "miracolous-image-400x533.png",
 );
 $image{data} = read_png($image{file}); # Assign Value to Hash Element
 info_pdl($image{data},$image{file});   # Use Hash Values

=cut

# ------------ Read Image data: Using Hashes
my %image = (                # Initialize Hash
	base => "miracolous-image-400x533",
	file => "miracolous-image-400x533.png",
);
$image{data} = read_png($image{file}); # Assign Value to Hash Element
info_pdl($image{data},$image{file});   # Use Hash Values


=head2 Separating RGB and Bit Plane: Hash Slices

A Hash Slice represent more Hash elements at once. The At (C<@>) sign is used
to represent a hash slice.

 @list = @hash{'key1','key2'};			# Access Hash Slice
 @hash{ 'key1','key2','key3' } = ...;   # Assignment of Values to Hash Slice

In the example below we assign the RGB layers of the image to a Hash Slice.
Then we create a Hash Element named "bit_plane" and assign the bit planes (an array) 
of each color to the Hash Slice C<('red','green','blue')>.

 @image{ 'red','green','blue' } = rgb($image{data});	# Assigning values to Hash slice

 my @colors = ('red','green','blue');
 @{ $image{bit_plane} }{ @colors } = (   # 
	[ bit_plane($image{red}) ],
	[ bit_plane($image{green}) ],
	[ bit_plane($image{blue}) ],
 );

=head3 About Image Data

The miracolous image has a size of 3x400x533. The image has a size width x height of 400x533
and is composed of 3 color values red/green/blue (RGB). Each value has 8 Bit means
decimal from 0 to 255. One Red Pixel for examle has the R/G/B values of 255/0/0.

When we first separate the RGB values, we assign to C<$image{red}> an image of 400x533
only red pixel values. Afterwards we separate all 8 bit planes.

The 8 Bit Value of 255 is a binary value of 0b11111111. Separating the 8 bit planes means
we create an array of only Bit 0 (LSB), only Bit 1, ..., only Bit 7 (MSB). So the bit plane
of Bit 7 can have value 0 or 1, means in decimal 0 or 128 (because of MSB).

Representation of Bits and Significancy:

 Bit Number:    (MSB) 7           6           5           4   3  2  1  0 (LSB)
 Binary Value:        0b10000000, 0b01000000, 0b00100000, ...
 Decimal Value:       128,        64,         32,         16, 8, 4, 2, 1

So the most information of an image is in the highest bits. Only with Bits 5-7 it
is possible to get a visible image out of the data. In Bit 0 is the least information
of the image, this is rather some image noise in the LSB.

=cut

# ----------- Separating RGB and Bit Plane: Hash Slices

if($cmd eq "pdl") {
	@image{ 'red','green','blue' } = rgb($image{data});	# Assigning values to Hash slice

	my @colors = ('red','green','blue');
	@{ $image{bit_plane} }{ @colors } = (   # 
		[ bit_plane($image{red}) ],
		[ bit_plane($image{green}) ],
		[ bit_plane($image{blue}) ],
	);
}
elsif($cmd eq "array") {

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
}

=head2 Extract hidden image from Bit 0: Hash Slice

So in Bit 0 (Least Significant, Noise) of each RGB Value you can hide the 
Bits 5-7 (Most Significant) of another image. I separated a grayscale image
in its bit plane and put these 3 bit planes from Bit 5-7 into the Bit 0 of
the RGB. To extract the hidden image the process is vice versa.

Only the Bits are in Bit position 0, means they need to be shifted to their
origin Bit position and composed together, with Shift-Operator and binary
Or-Operator.

 my %hidden;
 @hidden{ 'bit7','bit6','bit5' } = (
	$image{bit_plane}{red}[0],
	$image{bit_plane}{green}[0],
	$image{bit_plane}{blue}[0],
 );
 $hidden{data} = ($hidden{bit7} << 7) | ($hidden{bit6} << 6) | ($hidden{bit5} << 5);

=cut

# ----------- Create hidden image ----------------
my %hidden;
if($cmd eq "pdl") {
	@hidden{ 'bit7','bit6','bit5' } = (
		$image{bit_plane}{red}[0],
		$image{bit_plane}{green}[0],
		$image{bit_plane}{blue}[0],
	);
	$hidden{data} = ($hidden{bit7} << 7) | ($hidden{bit6} << 6) | ($hidden{bit5} << 5);
}
elsif($cmd eq "array") {
	@hidden{ 'bit7','bit6','bit5' } = (
		$image{bit_plane}{red}[0],
		$image{bit_plane}{green}[0],
		$image{bit_plane}{blue}[0],
	);
	my $tmp1 = recreate(@hidden{'bit7','bit6','bit5'});
	info_array($tmp1);

	my $tmp2 = pdl(byte(),$tmp1);
	$hidden{data} = $tmp2->xchg(0,1);
	info_pdl($hidden{data},"Recreate PDL");
}

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
=head2 Write hidden image to file: PDL::NiceSlice

The hidden image was a grayscale with size 200x265. So I create an empty PDL object
with this size and assign a PDL::NiceSlice of that size from the composed data.
Afterwards the data is written to file.

 $hidden{slice} = zeroes(byte(),200,265);
 my $tmp = $hidden{data};
 $hidden{slice} .= $tmp(0:199,0:264);
 write_png($hidden{slice},"hidden-200x265.png");

=cut

# ------------ Write hidden image to file ----------
my $base;
if($cmd eq "pdl")      { $base = "hidden-pdl"; }
elsif($cmd eq "array") { $base = "hidden-array"; }

$hidden{slice} = zeroes(byte(),200,265); # PDL with 200x265 zeroes
my $tmp = $hidden{data};    # It seems PDL::Slice does not work with complex data types
$hidden{slice} .= $tmp(0:199,0:264);      # PDL Slice with PDL::NiceSlice
write_png($hidden{slice},"$base-200x265.png"); # Write file with Hidden Image
info_pdl($hidden{slice},"$base-200x265.png");  # Info PDL of Hidden Image

write_png($hidden{data},"$base-400x533.png");  # Write file with Hidden Bit Planes
info_pdl($hidden{data},"$base-400x533.png");   # Info PDL of Hidden Bit Planes

# --------------------------- Functions ----------------------------

=head1 Functions

=head2 $data = read_png($filename);

Reads an image file with PNG format and returns the PDL data.

=cut

sub read_png {
    my ($png) = @_; 
    my $cr = PDL->rpiccan('PNG');
    if(! $cr ) { print "Error (read): Png not allowed!\n"; return 0; }
    my $tmp = PDL::IO::Pic::rpic($png, {FORMAT => 'PNG'});
}

=head2 write_png($data,$filename);

Writes a PDL image as PNG file.

=cut

sub write_png {
    my ($img,$png) = @_; 
    my $cr = PDL->wpiccan('PNG');
    if(! $cr ) { print "Error (write): Png not allowed!\n"; return 0; }
    PDL::IO::Pic::wpic($img,$png, {FORMAT => 'PNG'});
}

=head2 @bit_planes = bit_plane($data,$type);

Separates $data in its @bit_planes. The $type can be 'raw'|'msb'|'lsb'.

=cut

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

=head2 ($red,$green,$blue) = rgb($data);

Returns the RED/GREEN/BLUE layers of a coloured image PDL $data.

=cut

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
	print "./ch-1.pl <command>\n";
	print "\n";
	print "   command, pdl|array|html|help\n";
	print "      pdl,   Solution for Task #1 with PDL.\n";
	print "      array, Solution for Task #1 with Array.\n";
	print "      help,  Prints out some usage information.\n";
	print "      html,  Writes HTML and CSS from POD.\n";
	print "\n";
	print "   Examples:\n";
	print "      # perldoc ch-1.pl\n";
	print "      # ./ch-1.pl pdl\n";
	print "      # ./ch-1.pl array\n";
	print "      # ./ch-1.pl help\n";
	print "      # ./ch-1.pl html\n";
}

sub html {
	# ------------- Create HTML --------------
	qx[ pod2html --header --title \"Perl Weekly Challenge #34 Task #1, Demonstrate Array/Hash Slices\" --css \"pwc.css\" ch-1.pl > ch-1.html ];

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


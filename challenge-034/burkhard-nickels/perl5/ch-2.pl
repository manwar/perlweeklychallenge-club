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

This week PWC in Task #2 shall demonstrate a Dispatch Table. We use the Dispatch
Table to call different functions according to command line arguments.

These different functions do some different kinds of image processing. Mainly
we want to create a miraculous image. Means we want to hide one grayscale image
within a bigger colored image. Some intermediate steps of this image processing
can be printed to file with command line arguments.

In Task #1 of PWC #34 you could already see how to reveal the hidden image.
The functions used there are not explained anymore in Task #2. Also some basic
explanations on Hash Slices and Array Slices are in Task #1. But in Task #2
we try to use Slices were ever possible.

=head1 SYNOPSIS

 # perldoc ch-2.pl		- POD
 ./ch-2.pl <command>

 # ./ch-2.pl pdl		- Creates Hidden Grayscale from Colored Image
 # ./ch-2.pl array		- Array Version does NOT work properly
 # ./ch-2.pl html		- HTML/CSS in ch-2.html/pwc.css
 # ./ch-2.pl help		- Usage information

=cut

# ===================================================================

=head1 Hide a Secret image in a Vessel image

The big image is the "vessel", where I want to hide the "secret" grayscale
image. The resulting image looks like the "vessel", but in each LSB of the
R/G/B channels are hidden the MSB's (Bit 7/6/5) of the secret image. This is
possible because the LSB does not add much significancy to the "vessel" image.

=begin html

<table><tr>
	<td><img style="padding:10px;" width=250 src="ch2-400x533.png"></td>
	<td style="font-size:50px; font-weight:bold;"> + </td>
	<td><img style="padding:10px;" src="ch2-200x265.png"></td>
	<td style="font-size:50px; font-weight:bold;"> = </td>
	<td><img style="padding:10px;" width=250 src="miraculous-image-400x533.png"></td>
	<td><b>ch2-400x533.png<br>
	    ch2-200x265.png<br>
		=<br>
	    miraculous-image-400x533.png<br></b>
	</td>
</tr></table>

=end html

Below you can see the steps done to create this B<Miraculous Image>.

=over 1

=item * Read the "Secret" image and split it into its Bit Planes. We hide Bit 7/6/5.

=item * Read the "Vessel" image and split it into its R/G/B values. Then split each R/G/B into its Bit Planes.

=item * Hide Bit 7/6/5 of "Secret" in Bit 0 of each R/G/B of "Vessel".

=item * Write Miraculous Image to PNG file.

=back

=cut

# ===================================================================

=head1 Main Program

The main program starts with the definition of some variables.
This is not really necessary for the keys of the Hashes. But I use
it to explain them in the beginning, because they are used everywhere.

So lets start with the array C<@RGB>. It is used to create a RGB Slice
a little bit easier:

 my @RGB = ('red','green','blue'); # For creating Hash Slices

i.e. the below Hash Slice becomes a little bit shorter:

 @vessel{'red','green','blue'} = rgb($vessel{data});
 @vessel{@RGB}                 = rgb($vessel{data});

Our "Secret" Image has a filenam "name" and reads the PDL "data".
It is splitted in a "bit_plane" in 3 variants: "lsb", "msb", "raw".

 my %secret = (
	name => "ch2-200x265.png",
	data => 0,
	bit_plane => {
		lsb => [],
		msb => [],
		raw => [],
	},
 );

Similar Hash Keys we use for the "Vessel" Image. But because it is a
coloured image we split the image in its "red", "green" and "blue" channels.
Also the "bit_plane" is split into "red", "green" and "blue".

 my %vessel = (
	name => "ch2-400x533.png",  # file name
	data => 0,                  # PDL data
	bit_plane => {              # Bit Plane
		red   => [],
		green => [],
		blue  => [],
	},
	red   => 0,
	green => 0,
	blue  => 0,
 );

The "Composed" Image is defined here only with the filename "name".
All other Hash Keys are defined somewhere else in the program.

 my %composed = (
	name => "composed-400x533.png",
 );


=cut

my @RGB = ('red','green','blue'); # For creating Hash Slices
my %secret = (
	name => "ch2-200x265.png",
	data => 0,
	bit_plane => {
		lsb => [],
		msb => [],
		raw => [],
	},
);
my %vessel = (
	name => "ch2-400x533.png",  # file name
	data => 0,                  # PDL data
	bit_plane => {              # Bit Plane
		red   => [],
		green => [],
		blue  => [],
	},
);
my %composed = (
	name => "composed-400x533.png",
);

# ===================================================================

=head1 Dispatch Table

We use a Dispatch Table to call the different functions of the program.
So our main program mainly consists of this Dispatch Table.

A Dispatch Table is simply a Hash that takes as value a code reference.
So the code can be executed when C<&{$dispatch{$command}($ARGV[0])}> is called,
see below:

 my $cmd = shift @ARGV;		# Read command
 $cmd = "help" if not $cmd;
 print "ch-2.pl (Version 1.0) PWC #34 Task #2: $cmd\n";

 # --- Dispatch Table
 my %dispatch = (
	html             => \&html,
	help             => \&usage,
	print_secret_raw => \&print_secret_raw,
	print_secret_msb => \&print_secret_msb,
	print_vessel_rgb => \&print_vessel_rgb,
	print_vessel_lsb => \&print_vessel_lsb,
	print_composed_examples   => \&print_composed_examples,
	compose          => \&compose,
 );
 if( $dispatch{$command} ) { &{$dispatch{$command}}($ARGV[0]);
 else { &usage; }

The "print_*" commands only prints the intermediate images that you can see
in this Blog. Only the "compose" option creates the B<Miraculous Image>.

=cut


my $cmd = shift @ARGV;		# Read command
$cmd = "help" if not $cmd;
print "ch-2.pl (Version 1.0) PWC #34 Task #2: $cmd\n";

# --- Dispatch Table
my %dispatch = (
	html  => \&html,
	help  => \&usage,
	print_secret_raw => \&print_secret_raw,
	print_secret_msb => \&print_secret_msb,
	print_vessel_rgb => \&print_vessel_rgb,
	print_vessel_lsb => \&print_vessel_lsb,
	print_composed_examples => \&print_composed_examples,
	compose => \&compose,
);
if( $dispatch{$cmd} ) { &{$dispatch{$cmd}}($ARGV[0]); }
else { &usage; }



# =========================== SECRET ==============================

=head1 Secret Image

What we need from the B<Secret Image> is the Bit Plane. Every Bit Plane
is needed on LSB, because we want to hide this information in LSB of the
B<Vessel Image>. So we would only need to call the Bit Plane function 
C<bit_plane($secret{data},"lsb")> with the "lsb" option. 

The assignment to the C<%secret> Hash is done via a Hash Slice.

 sub secret {
	$secret{data} = read_png($secret{name});
	@{ $secret{bit_plane} }{'lsb','msb','raw'} = (
		[ bit_plane($secret{data},"lsb") ],
		[ bit_plane($secret{data},"msb") ],
		[ bit_plane($secret{data},"raw") ],
	);
 }

=cut

sub secret {
	print "---- Read Secret Data ----\n";
	$secret{data} = read_png($secret{name});
	@{ $secret{bit_plane} }{'lsb','msb','raw'} = (
		[ bit_plane($secret{data},"lsb") ],
		[ bit_plane($secret{data},"msb") ],
		[ bit_plane($secret{data},"raw") ],
	);
	info_pdl($secret{data}  , "\tSecret Data");
	info_pdl($secret{bit_plane}{raw}->[7], "\t Secret Bit 7");
	info_pdl($secret{bit_plane}{raw}->[6], "\t Secret Bit 6");
	info_pdl($secret{bit_plane}{raw}->[5], "\t Secret Bit 5");
}

=head2 print_secret_raw()

The function C<print_secret_raw()> prints some intermediate steps in
our hiding process. It prints the bit planes for bit 7, 6, 5 and the
composed image of the 3 bit planes to the below files. The composed
image is also the image that we want to hide in the vessel image.

=begin html

<table><tr>
	<td><img src="tmp/secret-bp-7-raw.png"></td>
	<td><img src="tmp/secret-bp-6-raw.png"></td>
	<td><img src="tmp/secret-bp-5-raw.png"></td>
	<td>
	<b># ./ch-2.pl print_secret_raw</b><br>
		<br>
		secret-bp-7-raw.png<br>
	    secret-bp-6-raw.png<br>
	    secret-bp-5-raw.png<br>
	<br>
	<b><i>These "Secret" 3 Bit Planes shall be hidden in "Vessel".</i></b>
	</td>
</tr><tr>
	<td colspan=3 style="text-align:center;"><img src="tmp/secret-bp-765.png"></td>
	<td>secret-bp-765.png</td>
</tr></table>

=end html

First the secret image is read from PNG file. Second the image data is split
into its bit planes, the option "raw" preserves the bit position within the
byte of each pixel. The 3 most significant bits (MSB) are binary ORed to a new
image. All 4 images are printed to a PNG file.

 sub print_secret_raw {

	# ------- read secret image
	$secret{data} = read_png($secret{name}); 

	# ------- separate image into its bit planes, preserve bit position
	@{ $secret{bit_plane_raw} } = bit_plane($secret{data},"raw");

	# ------- binary OR of bit plane 7/6/5
	my $new_secret = 
		$secret{bit_plane_raw}->[7] |
		$secret{bit_plane_raw}->[6] |
		$secret{bit_plane_raw}->[5];

	# ------- write image data to PNG file
	write_png($new_secret,"secret-bp-765.png");
	write_png($secret{bit_plane_raw}->[7],"secret-bp-7-raw.png");
	write_png($secret{bit_plane_raw}->[6],"secret-bp-6-raw.png");
	write_png($secret{bit_plane_raw}->[5],"secret-bp-5-raw.png");
 }

=cut

sub print_secret_raw {
	# $secret{data} = read_png($secret{name});
	# @{ $secret{bit_plane_raw} } = bit_plane($secret{data},"raw");

	secret();

	my $new_secret = 
		$secret{bit_plane}{raw}->[7] |
		$secret{bit_plane}{raw}->[6] |
		$secret{bit_plane}{raw}->[5];

	write_png($new_secret,"secret-bp-765.png");
	write_png($secret{bit_plane}{raw}->[7],"secret-bp-7-raw.png");
	write_png($secret{bit_plane}{raw}->[6],"secret-bp-6-raw.png");
	write_png($secret{bit_plane}{raw}->[5],"secret-bp-5-raw.png");
}
=head2 print_secret_msb()

The function C<print_secret_msb()> makes each bit plane a little bit
more visible. It shifts each bit up to bit 7 (MSB). So the intensity
of the two values 0/1 is in decimal 0/128. The following 3 images
are the same bits 7/6/5.

=begin html

<table><tr>
	<td><img src="tmp/secret-bp-7-msb.png"></td>
	<td><img src="tmp/secret-bp-6-msb.png"></td>
	<td><img src="tmp/secret-bp-5-msb.png"></td>
	<td><b># ./ch-2.pl print_secret_msb</b><br>
		<br>
		secret-bp-7-msb.png<br>
	    secret-bp-6-msb.png<br>
	    secret-bp-5-msb.png<br>
	</td>
</tr></table>

=end html

The important difference in this code is the call of function C<bit_plane()>
with the option "msb".

 sub print_secret_msb {
	$secret{data} = read_png($secret{name});
	@{ $secret{bit_plane_msb} } = bit_plane($secret{data},"msb");

	write_png($secret{bit_plane_msb}->[7],"secret-bp-7-msb.png");
	write_png($secret{bit_plane_msb}->[6],"secret-bp-6-msb.png");
	write_png($secret{bit_plane_msb}->[5],"secret-bp-5-msb.png");
 }

=cut

sub print_secret_msb {
	# $secret{data} = read_png($secret{name});
	# @{ $secret{bit_plane_msb} } = bit_plane($secret{data},"msb");
	secret();
	write_png($secret{bit_plane}{msb}->[7],"secret-bp-7-msb.png");
	write_png($secret{bit_plane}{msb}->[6],"secret-bp-6-msb.png");
	write_png($secret{bit_plane}{msb}->[5],"secret-bp-5-msb.png");
}

# =========================== VESSEL ==============================

=head1 Vessel Image




=cut

sub vessel {

	print "---- Read Vessel Data ----\n";
	$vessel{data} = read_png($vessel{name});

	@vessel{'red','green','blue'} = rgb($vessel{data});

	# ---- Print some information for PDL
	info_pdl($vessel{red}  , "\tVessel RED");
	info_pdl($vessel{green}, "\tVessel GRN");
	info_pdl($vessel{blue} , "\tVessel BLU");

	@{ $vessel{bit_plane} }{@RGB} = (
		[ bit_plane($vessel{red})   ],
		[ bit_plane($vessel{green}) ],
		[ bit_plane($vessel{blue})  ],
	);

	# ---- Again some information for PDL, because Hash Slice above was not easy.
	info_pdl($vessel{bit_plane}{red}[0]  ,"\tVessel Bit Plane RED");
	info_pdl($vessel{bit_plane}{green}[0],"\tVessel Bit Plane GRN");
	info_pdl($vessel{bit_plane}{blue}[0] ,"\tVessel Bit Plane BLU");
}

=head2 print_vessel_rgb()

This intermediate step extracts the R/G/B channels of the coloured B<Vessel Image>.
From each channel another RGB Image is created by setting the other 2 colors to zero.
These resulting images are written to PNG file.

=begin html

<table><tr>
	<td><img width=250 src="tmp/vessel-red.png"></td>
	<td><img width=250 src="tmp/vessel-grn.png"></td>
	<td><img width=250 src="tmp/vessel-blu.png"></td>
	<td>
	<b># ./ch-2.pl print_vessel_rgb</b><br>
		<br>
		vessel-red.png<br>
	    vessel-grn.png<br>
	    vessel-blu.png<br>
	<br>
	<b><i>Each R/G/B Channel of "Vessel" is used to hide one Bit (7/6/5) of "Secret".</i></b>
	</td>
</tr></table>

=end html

 sub print_vessel_rgb {

	$vessel{data} = read_png($vessel{name});
	@vessel{'red','green','blue'} = rgb($vessel{data});

	my $red = one_color($vessel{red},"red");
	my $grn = one_color($vessel{green},"green");
	my $blu = one_color($vessel{blue},"blue");

	write_png($red,"vessel-red.png");
	write_png($grn,"vessel-grn.png");
	write_png($blu,"vessel-blu.png");
 }

=cut

sub print_vessel_rgb {
	# $vessel{data} = read_png($vessel{name});
	# @vessel{'red','green','blue'} = rgb($vessel{data});
	vessel();
	my $red = one_color($vessel{red},"red");
	my $grn = one_color($vessel{green},"green");
	my $blu = one_color($vessel{blue},"blue");
	write_png($red,"vessel-red.png");
	write_png($grn,"vessel-grn.png");
	write_png($blu,"vessel-blu.png");
}

=head2 print_vessel_lsb()

The LSB of each R/G/B channel has not much information, it becomes more or less Noise.

=begin html

<table><tr>
	<td><img width=250 src="tmp/vessel-red-lsb.png"></td>
	<td><img width=250 src="tmp/vessel-grn-lsb.png"></td>
	<td><img width=250 src="tmp/vessel-blu-lsb.png"></td>
	<td>
	<b># ./ch-2.pl print_vessel_lsb</b><br>
		<br>
		vessel-red-lsb.png<br>
	    vessel-grn-lsb.png<br>
	    vessel-blu-lsb.png<br>
	<br>
	<b><i>Each Bit 0 (LSB) of R/G/B Channel of "Vessel" is used to hide one Bit (7/6/5) of "Secret".<br><br>
	LSB is mostly Noise.
	</i></b>
	</td>
</tr></table>

=end html

Most of the code we know already. Complicate here is the Hash Slice for the Bit Plane.
The function C<bit_plane()> returns a list, but how to assign 3 arrays to a Hash Slice
of arrays? So I had to assign an array ref to the Hash Slice.

To make a Bit Plane better visible, we shifted the LSB to the MSB. Now I multiplicate
the LSB with 255. This is even better visible, because the binary 0/1 values become 0/255 
(before 0/128).

 sub print_vessel_lsb {

	# ---- Read PNG and convert rot R/G/B
	$vessel{data} = read_png($vessel{name});
	@vessel{'red','green','blue'} = rgb($vessel{data});

	# ---- Print some information for PDL
	info_pdl($vessel{red}  , "Vessel RED");
	info_pdl($vessel{green}, "Vessel GRN");
	info_pdl($vessel{blue} , "Vessel BLU");

	# ---- Get Bit Plane of each R/G/B
	@{ $vessel{bit_plane} }{@RGB} = (
		[ bit_plane($vessel{red})   ],
		[ bit_plane($vessel{green}) ],
		[ bit_plane($vessel{blue})  ],
	);

	# ----  Alternative to get Bit Plane, without Hash Slice
	# @{ $vessel{bit_plane}{red} }   = bit_plane($vessel{red},"raw");
	# @{ $vessel{bit_plane}{green} } = bit_plane($vessel{green},"raw");
	# @{ $vessel{bit_plane}{blue} }  = bit_plane($vessel{blue},"raw");

	# ---- Again some information for PDL, because Hash Slice above was not easy.
	info_pdl($vessel{bit_plane}{red}[0],"Vessel Bit Plane RED");
	info_pdl($vessel{bit_plane}{green}[0],"Vessel Bit Plane GRN");
	info_pdl($vessel{bit_plane}{blue}[0],"Vessel Bit Plane BLU");

	# ---- Make RGB from each channel, but no shift to MSB, instead
	#      multiplicate with 255.  
	my $red = one_color(($vessel{bit_plane}{red}[0]*255)  ,"red");
	my $grn = one_color(($vessel{bit_plane}{green}[0]*255),"green");
	my $blu = one_color(($vessel{bit_plane}{blue}[0]*255) ,"blue");

	# ---- Write PDL data to PNG file
	write_png($red,"vessel-red-lsb.png");
	write_png($grn,"vessel-grn-lsb.png");
	write_png($blu,"vessel-blu-lsb.png");
 }

The following output is generated for the B<print_vessel_lsb> Option.
We can see that for every PDL an info is printed. This we needed to
debug the code above. It was difficult to get the Hash Slice working.
The direct assignment as a Hash Value (see above alternative) was easier.

 # ./ch-2.pl print_vessel_lsb
 ch-2.pl (Version 1.0) PWC #34 Task #2: print_vessel_lsb
 Vessel RED:  Type byte (0) Dims 2 (400/533) #Ele 213200 Sum  30696312
 Vessel GRN:  Type byte (0) Dims 2 (400/533) #Ele 213200 Sum  28325969
 Vessel BLU:  Type byte (0) Dims 2 (400/533) #Ele 213200 Sum  22381809
 Vessel Bit Plane RED:  Type byte (0) Dims 2 (400/533) #Ele 213200 Sum  98516
 Vessel Bit Plane GRN:  Type byte (0) Dims 2 (400/533) #Ele 213200 Sum  111231
 Vessel Bit Plane BLU:  Type byte (0) Dims 2 (400/533) #Ele 213200 Sum  109309

=cut

sub print_vessel_lsb {

	# ---- Read PNG and convert rot R/G/B
	# $vessel{data} = read_png($vessel{name});
	# @vessel{'red','green','blue'} = rgb($vessel{data});
	vessel();

	# ---- Print some information for PDL
	# info_pdl($vessel{red}  , "Vessel RED");
	# info_pdl($vessel{green}, "Vessel GRN");
	# info_pdl($vessel{blue} , "Vessel BLU");

	# ---- Get Bit Plane of each R/G/B
	# @{ $vessel{bit_plane} }{@RGB} = (
	# 	[ bit_plane($vessel{red})   ],
	# 	[ bit_plane($vessel{green}) ],
	# 	[ bit_plane($vessel{blue})  ],
	# );

	# ----  Alternative to get Bit Plane, without Hash Slice
	# @{ $vessel{bit_plane}{red} }   = bit_plane($vessel{red},"raw");
	# @{ $vessel{bit_plane}{green} } = bit_plane($vessel{green},"raw");
	# @{ $vessel{bit_plane}{blue} }  = bit_plane($vessel{blue},"raw");

	# ---- Again some information for PDL, because Hash Slice above was not easy.
	info_pdl($vessel{bit_plane}{red}[0],"Vessel Bit Plane RED");
	info_pdl($vessel{bit_plane}{green}[0],"Vessel Bit Plane GRN");
	info_pdl($vessel{bit_plane}{blue}[0],"Vessel Bit Plane BLU");

	# ---- Make RGB from each channel, but no shift to MSB, instead
	#      multiplicate with 255.  
	my $red = one_color(($vessel{bit_plane}{red}[0]*255)  ,"red");
	my $grn = one_color(($vessel{bit_plane}{green}[0]*255),"green");
	my $blu = one_color(($vessel{bit_plane}{blue}[0]*255) ,"blue");

	# ---- Write PDL data to PNG file
	write_png($red,"vessel-red-lsb.png");
	write_png($grn,"vessel-grn-lsb.png");
	write_png($blu,"vessel-blu-lsb.png");
}

# -------------------- compose vessel and secret ---------------------

=head1 Compose Vessel and Secret

In the former code we only read the B<Vessel> and B<Secret> Image from PNG
file and decomposed them into the B<Colour Channels> and B<Bit Planes>.

Now we need to compose Bit 7/6/5 of the Secret Image into the LSB of the
three Colour Channels (RGB). Depending on the Option B<zero|mid|slice> the
Secret image is hidden in the left-bottom corner (zero), in the middle (mid)
or in every second column (slice).

 sub compose {
	my ($type) = @_;         # zero|mid|slice
	$type = "zero" if not $type;

	secret();                # Read and split "Secret" image.
	vessel();                # Read and split "Vessel" image.

	print "---- Compose Vessel/Secret $type ----\n";

	# Get reference to Bit 0, PDL::NiceSlice otherwise will not work.
	my $red = $vessel{bit_plane}{red}->[0];   
	my $grn = $vessel{bit_plane}{green}->[0];
	my $blu = $vessel{bit_plane}{blue}->[0];

	if($type eq "zero") {    # Put "Secret" in left-bottom corner of "Vessel", with PDL::NiceSlice.
		$red(0:199,0:264) .= $secret{bit_plane}{lsb}->[7];
		$grn(0:199,0:264) .= $secret{bit_plane}{lsb}->[6];
		$blu(0:199,0:264) .= $secret{bit_plane}{lsb}->[5];
	}
	elsif($type eq "mid") {  # Put "Secret" in the middle of "Vessel", with PDL::NiceSlice.
		$red(100:299,132:396) .= $secret{bit_plane}{lsb}->[7];
		$grn(100:299,132:396) .= $secret{bit_plane}{lsb}->[6];
		$blu(100:299,132:396) .= $secret{bit_plane}{lsb}->[5];
	}
	elsif($type eq "slice") {  

		# Get reference to "Secret" Bit 7/6/5, PDL::NiceSlice otherwise will not work.
		my $sec_red = $secret{bit_plane}{lsb}->[7];
		my $sec_grn = $secret{bit_plane}{lsb}->[6];
		my $sec_blu = $secret{bit_plane}{lsb}->[5];

		for(my $i=0; $i<=199; $i++) {

			# Put Slices of "Secret" in every second row, with PDL::NiceSlice.
			$red(($i*2),132:396) .= $sec_red(($i),:);
			$grn(($i*2),132:396) .= $sec_grn(($i),:);
			$blu(($i*2),132:396) .= $sec_blu(($i),:);
		}
	}

	# Rebuild the Bit Planes of the 3 Colours
	$composed{red}   = rebuild_bit_plane($vessel{bit_plane}{red});
	$composed{green} = rebuild_bit_plane($vessel{bit_plane}{green});
	$composed{blue}  = rebuild_bit_plane($vessel{bit_plane}{blue});

	# Compose final image
	$composed{data} = torgb(@composed{@RGB}); # Hash Slice
	write_png(@composed{'data','name'});      # Hash Slice
 }

=begin html

<table><tr>
	<td><img width=180 src="tmp/composed-zero-red-bit7.png"></td>
	<td><img width=180 src="tmp/composed-zero-grn-bit6.png"></td>
	<td><img width=180 src="tmp/composed-zero-blu-bit5.png"></td>
	<td><img width=180 src="tmp/composed-zero-color-lsb.png"></td>
	<td>
	<b># ./ch-2.pl print_composed_examples zero</b><br>
		<br>
	    composed-zero-red-bit7.png<br>
	    composed-zero-red-bit6.png<br>
	    composed-zero-red-bit5.png<br>
		<br>
		<b><i> Secret image is hidden at position "zero",
			in left-bottom corner.
		</i></b>
	</td>
</tr><tr>
	<td><img width=180 src="tmp/composed-mid-red-bit7.png"></td>
	<td><img width=180 src="tmp/composed-mid-grn-bit6.png"></td>
	<td><img width=180 src="tmp/composed-mid-blu-bit5.png"></td>
	<td><img width=180 src="tmp/composed-mid-color-lsb.png"></td>
	<td>
	<b># ./ch-2.pl print_composed_examples mid</b><br>
		<br>
	    composed-mid-red-bit7.png<br>
	    composed-mid-grn-bit6.png<br>
	    composed-mid-blu-bit5.png<br>
		<br>
		<b><i> Secret image is hidden in the middle of the
			vessel image.
		</i></b>
	</td>
</tr><tr>
	<td><img width=180 src="tmp/composed-slice-red-bit7.png"></td>
	<td><img width=180 src="tmp/composed-slice-grn-bit6.png"></td>
	<td><img width=180 src="tmp/composed-slice-blu-bit5.png"></td>
	<td><img width=180 src="tmp/composed-slice-color-lsb.png"></td>
	<td>
	<b># ./ch-2.pl print_composed_examples slice</b><br>
		<br>
	    composed-slice-red-bit7.png<br>
	    composed-slice-grn-bit6.png<br>
	    composed-slice-blu-bit5.png<br>
		<br>
		<b><i> Secret image is hidden vertically in the middle and
			horizontally in every second column of the vessel image.
		</i></b>
	</td>
</tr></table>
<table><tr>
	<td><img width=200 src="tmp/composed-zero-color-msb.png"></td>
	<td style="font-size:50px; font-weight:bold;"> ... </td>
	<td><img width=200 src="tmp/composed-zero-color-lsb.png"></td>
	<td style="font-size:50px; font-weight:bold;"> = </td>
	<td><img width=200 src="composed-400x533.png"></td>
</tr><tr>
	<td style="font-size:25px; font-weight:bold;"> Vessel Bit 7 </td>
	<td></td>
	<td style="font-size:25px; font-weight:bold;"> Vessel Bit 0<br>Secret </td>
	<td></td>
	<td style="font-size:25px; font-weight:bold;"> Miraculous Image </td>
</tr></table>

=end html


=cut

sub compose {
	my ($type) = @_;         # zero|mid|slice
	$type = "zero" if not $type;

	secret(); # Read and split "Secret" image.
	vessel(); # Read and split "Vessel" image.

	print "---- Compose Vessel/Secret $type ----\n";

	# Get reference to Bit 0, PDL::NiceSlice otherwise will not work.
	my $red = $vessel{bit_plane}{red}->[0];   
	my $grn = $vessel{bit_plane}{green}->[0];
	my $blu = $vessel{bit_plane}{blue}->[0];

	if($type eq "zero") {    # Put "Secret" in left-bottom corner of "Vessel".
		$red(0:199,0:264) .= $secret{bit_plane}{lsb}->[7];
		$grn(0:199,0:264) .= $secret{bit_plane}{lsb}->[6];
		$blu(0:199,0:264) .= $secret{bit_plane}{lsb}->[5];
	}
	elsif($type eq "mid") {  # Put "Secret" in the middle of "Vessel".
		$red(100:299,132:396) .= $secret{bit_plane}{lsb}->[7];
		$grn(100:299,132:396) .= $secret{bit_plane}{lsb}->[6];
		$blu(100:299,132:396) .= $secret{bit_plane}{lsb}->[5];
	}
	elsif($type eq "slice") {  
		# Get reference to "Secret" Bit 7/6/5, PDL::NiceSlice otherwise will not work.
		my $sec_red = $secret{bit_plane}{lsb}->[7];
		my $sec_grn = $secret{bit_plane}{lsb}->[6];
		my $sec_blu = $secret{bit_plane}{lsb}->[5];
		for(my $i=0; $i<=199; $i++) {
			# Put Slices of "Secret" in every second row.
			$red(($i*2),132:396) .= $sec_red(($i),:);
			$grn(($i*2),132:396) .= $sec_grn(($i),:);
			$blu(($i*2),132:396) .= $sec_blu(($i),:);
		}
	}

	$composed{red}   = rebuild_bit_plane($vessel{bit_plane}{red});
	$composed{green} = rebuild_bit_plane($vessel{bit_plane}{green});
	$composed{blue}  = rebuild_bit_plane($vessel{bit_plane}{blue});

	$composed{data} = torgb(@composed{@RGB});
	write_png(@composed{'data','name'});
}

=head2 print_composed_examples()

The previous showed intermediate images have been printed with the option 
B<print_composed_examples>.


 sub print_composed_examples {
	my ($type) = @_;
	$type = "zero" if not $type;

	compose($type);

	# --- Bit 0 multiplied with 255 and create a RGB image with 2 colors set to "0".
	my $red = one_color($vessel{bit_plane}{red}->[0]*255,"red");
	my $grn = one_color($vessel{bit_plane}{green}->[0]*255,"green");
	my $blu = one_color($vessel{bit_plane}{blue}->[0]*255,"blue");

	# --- Compose only Bit 0 to a RGB image, each multiplied with 255.
	my $color0 = torgb(
		$vessel{bit_plane}{red}->[0]*255,
		$vessel{bit_plane}{green}->[0]*255,
		$vessel{bit_plane}{blue}->[0]*255,
	);
	# --- Compose only Bit 7 to a RGB image
	my $color7 = torgb(
		$vessel{bit_plane}{red}->[7],
		$vessel{bit_plane}{green}->[7],
		$vessel{bit_plane}{blue}->[7],
	);

	write_png($red,"tmp/composed-$type-red-bit7.png");
	write_png($grn,"tmp/composed-$type-grn-bit6.png");
	write_png($blu,"tmp/composed-$type-blu-bit5.png");
	write_png($color0,"tmp/composed-$type-color-lsb.png");
	write_png($color7,"tmp/composed-$type-color-msb.png");
 }

=cut

sub print_composed_examples {
	my ($type) = @_;
	$type = "zero" if not $type;

	compose($type);

	my $red = one_color($vessel{bit_plane}{red}->[0]*255,"red");
	my $grn = one_color($vessel{bit_plane}{green}->[0]*255,"green");
	my $blu = one_color($vessel{bit_plane}{blue}->[0]*255,"blue");

	my $color0 = torgb(
		$vessel{bit_plane}{red}->[0]*255,
		$vessel{bit_plane}{green}->[0]*255,
		$vessel{bit_plane}{blue}->[0]*255,
	);
	my $color7 = torgb(
		$vessel{bit_plane}{red}->[7],
		$vessel{bit_plane}{green}->[7],
		$vessel{bit_plane}{blue}->[7],
	);
	# ---- Reveal Hidden Image of Green Channel in Bit 0
	write_png($red,"tmp/composed-$type-red-bit7.png");
	write_png($grn,"tmp/composed-$type-grn-bit6.png");
	write_png($blu,"tmp/composed-$type-blu-bit5.png");
	write_png($color0,"tmp/composed-$type-color-lsb.png");
	write_png($color7,"tmp/composed-$type-color-msb.png");
}

# --------------------------- Functions ----------------------------

=head1 Functions

Here are some new functions implemented, that we did not need in Task #1.

=over 1

=item * $data = one_color($rgb_data,$color)

=item * $data = rebuild_bit_plane($bit_plane);

=item * $data = torgb($red,$green,$blue);

=back


Some functions used in Task #2 are explained already in Task #1 of PWC #34.

=over

=item - read_png()

=item - write_png()

=item - bit_plane()

=item - bit_plane_array()

=item - rgb()

=item - rgb_array()

=item - info_pdl()

=item - info_array()

=back


=head2 $data = one_color($rgb_data,$color)

The function C<one_color()> creates a RGB image with one color channel
set to its value, but the two other colors are set to zero. This is done
to better visualize the splitted channels of a RGB image.

 sub one_color {
	my ($img,$color) = @_;   # $color = red|green|blue

	# ------- Create image data of same dimension with only zeroes
	my $result = zeroes(byte(),3,$img->dims);

	# ------- Assign image data to choosen channel
	my %c = ( red=>0, green=>1, blue=>2 );
	for(my $i=0; $i<3; $i++) {
		if($i == $c{$color}) { $result(($i),:,:) .= $img; }	# PDL::NiceSlice
	}
	return ($result); # Return new image
 }

=cut

sub one_color {
	my ($img,$color) = @_;
	my $result = zeroes(byte(),3,$img->dims);
	my %c = ( red=>0, green=>1, blue=>2 );
	for(my $i=0; $i<3; $i++) {
		if($i == $c{$color}) { $result(($i),:,:) .= $img; }	# PDL::NiceSlice
	}
	return ($result);
}

=head2 $data = rebuild_bit_plane($bit_plane);

The argument is an array ref to the C<@bit_plane> array. It returns the composed
image data.

 sub rebuild_bit_plane {
	my ($bp) = @_;             # array ref to bit plane
	my $result = zeroes(       # empty PDL of same size
		byte(),                # PDL type byte
		$bp->[0]->dims         # PDL dimenstion of bit plane bit 0.
	);
	for(my $i=0;$i<=7;$i++) {  # iterate each bit position
		$result |= $bp->[$i];  # binary OR of each bit plane
	}
	return $result;            # return result
 }

=cut

sub rebuild_bit_plane {
	my ($bp) = @_;
	my $result = zeroes(byte(),$bp->[0]->dims);
	for(my $i=0;$i<=7;$i++) {
		$result |= $bp->[$i];
	}
	return $result;
}

=head2 $data = torgb($red,$green,$blue);

The three single R/G/B channels are composed to one RGB image.
Takes a list of the 3 channels C<$red,$green,$blue> and returns
the composed image data.

 sub torgb {
	my ($r,$g,$b) = @_;
	my $img = zeroes(byte(),3,$r->dims); # Create empty PDL with same dimenstion
	$img((0),:,:) .= $r; # Assign Value to PDL::NiceSlice
	$img((1),:,:) .= $g;
	$img((2),:,:) .= $b;
	return $img;         # Return composed coloured image
 }

=cut

sub torgb {
	my ($r,$g,$b) = @_;
	my $img = zeroes(byte(),3,$r->dims);
	$img((0),:,:) .= $r;
	$img((1),:,:) .= $g;
	$img((2),:,:) .= $b;
	return $img;
}
# =====================================================================

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
	print "Write PNG file $png\n";
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
	qx[ pod2html --header --title \"Perl Weekly Challenge #34 Task #2, Demonstrate Dispatch Table\" --css \"pwc.css\" ch-2.pl > ch-2.html ];

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


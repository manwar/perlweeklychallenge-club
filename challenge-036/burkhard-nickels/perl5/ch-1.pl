#!/usr/bin/perl

use strict;
use warnings;

=head1 Perl Weekly Challenge #36 Task #1: Validate Vehicle Identification Number VIN

The validation of the VIN is done via C<map> function and a hash table. Then the 
calculation according to the web page below on wikipedia.org is done.

=begin html

<h2> Download and References </h2>
<b>Download File:</b><a href="ch-1.pl" download>Solution PWC #36 Task #1 ch-1.pl</a><br>
<b>Download File:</b><a href="ch-2.pl" download>Solution PWC #36 Task #2 ch-2.pl</a><br>
<br>
<a target=_blank href="https://en.wikipedia.org/wiki/Vehicle_identification_number">https://en.wikipedia.org/wiki/Vehicle_identification_number</a>

=end html

=head1 SYNOPSIS

 # perldoc ch-1.pl		- POD
 ./ch-1.pl <command|string> [string]
 # ./ch-1.pl html		- HTML/CSS in ch-1.html/pwc.css
 # ./ch-1.pl help		- Usage information
 # ./ch-1.pl validate 1M8GDM9AXKP042788

=cut

my (@weight,%transl);
my $cmd = shift @ARGV;		# Read command or text string
if(!$cmd) { 
	print "ch-1.pl (Version 1.0) PWC #36 Task #1: Validate VIN.\n";
	usage(); 
	exit 0; 
}
elsif($cmd eq "html") { html(); exit 0; }
elsif($cmd eq "help") { usage(); exit 0; }
elsif($cmd eq "validate") {
	init();
	validate($ARGV[0]);
}
else {
}

# ====================== TASK 1 ==============================

=head1 Definition Task #1: Validate VIN

Write a program to validate given Vehicle Identification Number (VIN). 
For more information, please checkout wikipedia.

=cut

# ====================== TASK 1 ==============================

=head1 Validation of VIN

On the above mentioned wikipedia.org web page is an example on how to validate
a vehicle identification number (VIN).

I take this example of the VIN 1M8GDM9AXKP042788 to implement the validation.
The VIN consists of 17 characters. 

First all letters are changed to a number with C<map> function and a hash table.
Then this number is multiplicated with a weight of each number. This weight for
each number is fixed. Last all this multiplications are summed and divided by 11.
The rest of the division is the same value then the 8th number of the VIN.
Then the VIN is valid.

The execution of the examples from Wikipedia.org outputs the following results:

 ./ch-1.pl validate 1M8GDM9AXKP042788
 VIN 1M8GDM9AXKP042788 is valid:  10 == X
 ./ch-1.pl validate 5GZCZ43D13S812715
 VIN 5GZCZ43D13S812715 is valid:  1 == 1
 ./ch-1.pl validate SGZCZ43D13S812715
 VIN SGZCZ43D13S812715 is NOT valid:  10 != 1
 ./ch-1.pl validate WP0ZZZ99ZTS392124
 VIN WP0ZZZ99ZTS392124 is NOT valid:  8 != Z
 ./ch-1.pl validate KLATF08Y1VB363636
 VIN KLATF08Y1VB363636 is NOT valid:  4 != 1

=head1 Functions

=head2 init()

First we need to initialize the "weight" of each number and the hash table to
translate each letter of the VIN to a value.

 sub init {

	@weight = (8,7,6,5,4,3,2,10,0,9,8,7,6,5,4,3,2); 
	%transl = (
	A => 1,	B => 2,	C => 3,	D => 4, E => 5, F => 6,     G => 7, H => 8,     I => "N/A",
	J => 1, K => 2, L => 3, M => 4, N => 5, O => "N/A", P => 7, Q => "N/A", R => 9,
 	        S => 2, T => 3,	U => 4,	V => 5,	W => 6,     X => 7, Y => 8,     Z => 9,
	);
 }

=cut

# ---- Code of Functions

sub init {

	@weight = (8,7,6,5,4,3,2,10,0,9,8,7,6,5,4,3,2); 
	%transl = (
	A => 1,	B => 2,	C => 3,	D => 4, E => 5, F => 6,     G => 7, H => 8,     I => "N/A",
	J => 1, K => 2, L => 3, M => 4, N => 5, O => "N/A", P => 7, Q => "N/A", R => 9,
 	        S => 2, T => 3,	U => 4,	V => 5,	W => 6,     X => 7, Y => 8,     Z => 9,
	);

}

=head2 validate()

The procedure here is describe already above:

=over 2

=item  1. Split all chars

=item  2. Use map and hash table to trnslate letters

=item  3. Multiplicate number with weight

=item  4. Sum all multiplications

=item  5. Get Rest of Division of Sum with "11".

=item  6. VIN is valid if Rest equals 8th character of VIN.

=back

 sub validate {
	my ($vin) = @_;
	my @n = split(//,$vin);              # 1. Split all chars of VIN

	my @o = map {                        # 2. Use map function to translate letters
		if($transl{$_}) { 
			$transl{$_};                 # Translate if letter in hash
		} else { $_;}                    # Else take original char.
	} @n;

	my $s = 0;
	for( my $i=0; $i<=$#o; $i++ ) {      # Iterate through numbers
		my $v = $o[$i] * $weight[$i];    # 3. Multiplicate number with weight
		$s += $v;                        # 4. Sum all Multiplications
	}
	my $res = $s % 11;                   # 5. Get Rest of division with modulo operator

	if($n[8] eq "X") { $o[8] = 10; }     # Validation Value "X" is Value 10.
	if( $res == $o[8] ) {                # 6. VIN is valid 
		print "VIN $vin is valid:  $res == $n[8]\n";    # Output of result.
	}
	else {                               # VIN is not valid
		print "VIN $vin is NOT valid:  $res != $n[8]\n";
	}
 }

=cut

sub validate {
	my ($vin) = @_;
	# print "  VIN: ", $vin, "\n";
	my @n = split(//,$vin);

	my @o = map { if($transl{$_}) { $transl{$_}; } else { $_;} } @n;
	# print "Value: ", join("",@o), "\n";

	my $s = 0;
	for( my $i=0; $i<=$#o; $i++ ) {
		my $v = $o[$i] * $weight[$i];
		$s += $v;
		# printf("%2d %2s %2d %2d %3d %3d\n", $i, $n[$i], $o[$i], $weight[$i], $v, $s);
	}
	my $res = $s % 11;

	if($n[8] eq "X") { $o[8] = 10; }
	if( $res == $o[8] ) { 
		print "VIN $vin is valid:  $res == $n[8]\n";
	}
	else {
		print "VIN $vin is NOT valid:  $res != $n[8]\n";
	}
}

# ================================ Usage ============================
sub usage {
	print "./ch-1.pl <command|string>\n";
	print "\n";
	print "   command, html|help\n";
	print "      help,  Prints out some usage information.\n";
	print "      html,  Writes HTML and CSS from POD.\n";
	print "      validate <VIN>, validates the given WIN.\n";
	print "\n";
	print "   Examples:\n";
	print "      # perldoc ch-1.pl\n";
	print "      # ./ch-1.pl help\n";
	print "      # ./ch-1.pl html\n";
	print "      # ./ch-1.pl validate 1M8GDM9AXKP042788\n";
}

sub html {
	# ------------- Create HTML --------------
	qx[ pod2html --header --title \"Perl Weekly Challenge #36 Task #1, Validate VIN\" --css \"pwc.css\" ch-1.pl > ch-1.html ];

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


#!/usr/bin/perl

use strict;
use warnings;
use Text::Morse;
use Term::ANSIColor;
use Term::ANSIScreen qw(:color :cursor :screen);
use Term::Size::Perl qw(chars);
use Time::HiRes qw(usleep);

=head1 Perl Weekly Challenge #35 Task #1: Text into binary encoded morse code.

This week PWC in Task #1 shall encode text into binary morse code. In this example
it is done with a Hash Table to translate each letter in a binary string. First all
unwanted characters are filtered.

I made trials to use Audio::Beep or MIDI::Music to output the Morse code as sound.
Unfortunately I was not able to get a sound out of my loudspeakers with this two modules.
They work on OSS, but ALSA is installed and the compatibility modules to OSS did
not work.

Than I tried to create a lightful morse code output with the following modules.

=over 3

=item * Term::Size::Perl chars, to determine the width of the terminal

=item * Term::ANSIScreen, for coloured output on the same line.

=item * Text::Morse, alternative presentation of morse code.

=item * Time::HiRes usleep, for sleeping in micro seconds granularity.

=back


=begin html

<h2> Download and References </h2>
<b>Download File:</b><a href="ch-1.pl" download>Solution PWC #35 Task #1 ch-1.pl</a><br>
<b>Download File:</b><a href="ch-2.pl" download>Solution PWC #35 Task #2 ch-2.pl</a><br>
<br>
<a target=_blank href="https://en.wikipedia.org/wiki/Morse_code">https://en.wikipedia.org/wiki/Morse_code</a>

=end html

=head1 SYNOPSIS

 # perldoc ch-1.pl		- POD
 ./ch-1.pl <command|string> [string]
 # ./ch-1.pl "My name is? hello123!"
 # ./ch-1.pl "SOS SOS"
 # ./ch-1.pl light "SOS SOS"
 # ./ch-1.pl morse "SOS SOS"
 # ./ch-1.pl html		- HTML/CSS in ch-1.html/pwc.css
 # ./ch-1.pl help		- Usage information


=head1 Main program

In the main program the used modules are included and the hashes for the binary morse
transformation are defined. Next the command or test string are read from the argument
list. I use two standard commands, "help" and "html".

 use strict;
 use warnings;
 use Text::Morse;
 use Term::ANSIScreen qw(:color :cursor :screen);
 use Term::Size::Perl qw(chars);
 use Time::HiRes qw(usleep);

 my (%code,%gap);
 my $cmd = shift @ARGV;		# Read command or text string
 if(!$cmd) { 
	print "ch-1.pl (Version 1.0) PWC #35 Task #1: Encode Text to Binary Morse Code\n";
	usage(); 
	exit 0; 
 }
 elsif($cmd eq "html") { html(); exit 0; }
 elsif($cmd eq "help") { usage(); exit 0; }

=head2 Solution with module Text::Morse

This is not the required solution, but it exists a module Text::Morse that makes it
very easy to encode the morse alphabet.

 elsif($cmd eq "morse") {
	my $m = new Text::Morse;
	my $encoded = $m->Encode($ARGV[0]);
	print "$encoded\n";
 }

The output is a dot-hyphen combination with every word on a new line.

 # ./ch-1.pl morse "SOS SOS SOS"
 ... --- ... 
 ... --- ... 
 ... --- ... 

=head2 Solution with Term::ANSIScreen

With Term::ANSIScreen it is possible to change the colour in the rhythm of the morse
code, so you create a visible morse message. The sleep time is done with C<Time::HiRes
usleep()> function, because the sleep in seconds seems too long for the morse dot.
See more below in the C<multi_line()> and C<morse_light()> functions.

 elsif($cmd eq "light") {
	init();
	my $filtered = filter($ARGV[0]);
	my $encoded  = translate($filtered);
	multi_line($filtered,$encoded);
 }

 # ./ch-1.pl light "SOS SOS"
 Sentence: SOS SOS
 Sentence: 1010100011101110111000101010000000101010001110111011100010101


 SOS
 101010001110111011100010101

=head2 Required solution as binary encoded string

This default execution is doing the job: Initialize hash table, 
filtering not encodable characters and translate the string into binary.
The functions are explained in more details below.

 else {
	init();
	my $filtered = filter($cmd);
	my $encoded  = translate($filtered);
	print "$encoded\n";
 }

The output is the wished binary morse string.

 # ./ch-1.pl "SOS SOS"
 1010100011101110111000101010000000101010001110111011100010101

When used with a pipe and xargs to the script for Task #2, then it can be
converted back to the string.

 ./ch-1.pl "SOS SOS" | xargs ./ch-2.pl
 SOS SOS

 ./ch-1.pl "sos sos" | xargs ./ch-2.pl
 SOS SOS

=cut

my (%code,%gap);
my $cmd = shift @ARGV;		# Read command or text string
if(!$cmd) { 
	print "ch-1.pl (Version 1.0) PWC #35 Task #1: Encode Text to Binary Morse Code\n";
	usage(); 
	exit 0; 
}
elsif($cmd eq "html") { html(); exit 0; }
elsif($cmd eq "help") { usage(); exit 0; }
elsif($cmd eq "morse") {
	my $m = new Text::Morse;
	my $encoded = $m->Encode($ARGV[0]);
	print "$encoded\n";
}
elsif($cmd eq "light") {
	init();
	my $filtered = filter($ARGV[0]);
	my $encoded  = translate($filtered);
	multi_line($filtered,$encoded);
}
else {
	init();
	my $filtered = filter($cmd);
	my $encoded  = translate($filtered);
	print "$encoded\n";
}

# ====================== TASK 1 ==============================

=head1 Definition Task #1: Encode Text to Binary Morse Code

Write a program to encode text into binary encoded morse code.

Pay attention to any changes which might need to be made to the text to make it valid morse code.

Morse code consists of dots, dashes and gaps. It can be encoded in binary in the following fashion:
dot: 1
dash: 111
intra-character gap: 0
character gap: 000
word gap: 0000000

An intra-character gap is inserted between the dots and dashes in a character.

=cut

# ====================== TASK 1 ==============================

=head1 Functions

=head2 init()

The init() function initializes the hash table to translate each letter
into the binary string.

 sub init {
	%code = (
		'A' => "10111",
		'B' => "111010101",
		'C' => "11101011101",
		'D' => "1110101",
		'E' => "1",
		'F' => "101011101",
		'G' => "111011101",
		'H' => "1010101",
		'I' => "101",
		'J' => "1011101110111",
		'K' => "111010111",
		'L' => "101110101",
		'M' => "1110111",
		'N' => "11101",
		'O' => "11101110111",
		'P' => "10111011101",
		'Q' => "1110111010111",
		'R' => "1011101",
		'S' => "10101",
		'T' => "111",
		'U' => "1010111",
		'V' => "101010111",
		'W' => "101110111",
		'X' => "11101010111",
		'Y' => "1110101110111",
		'Z' => "11101110101",
		'1' => "10111011101110111",
		'2' => "101011101110111",
		'3' => "1010101110111",
		'4' => "10101010111",
		'5' => "101010101",
		'6' => "11101010101",
		'7' => "1110111010101",
		'8' => "111011101110101",
		'9' => "11101110111011101",
		'0' => "1110111011101110111"
	);
	%gap = (
		'cg' => "000",	# character gap
		'wg' => "0000000"	# word gap
	);
 }

=cut

sub init {
	%code = (
		'A' => "10111",
		'B' => "111010101",
		'C' => "11101011101",
		'D' => "1110101",
		'E' => "1",
		'F' => "101011101",
		'G' => "111011101",
		'H' => "1010101",
		'I' => "101",
		'J' => "1011101110111",
		'K' => "111010111",
		'L' => "101110101",
		'M' => "1110111",
		'N' => "11101",
		'O' => "11101110111",
		'P' => "10111011101",
		'Q' => "1110111010111",
		'R' => "1011101",
		'S' => "10101",
		'T' => "111",
		'U' => "1010111",
		'V' => "101010111",
		'W' => "101110111",
		'X' => "11101010111",
		'Y' => "1110101110111",
		'Z' => "11101110101",
		'1' => "10111011101110111",
		'2' => "101011101110111",
		'3' => "1010101110111",
		'4' => "10101010111",
		'5' => "101010101",
		'6' => "11101010101",
		'7' => "1110111010101",
		'8' => "111011101110101",
		'9' => "11101110111011101",
		'0' => "1110111011101110111"
	);
	%gap = (
		'cg' => "000",	# character gap
		'wg' => "0000000"	# word gap
	);
}

=head2 $filtered = filter($string)

The C<$string> is filtered to characters that can be encoded in morse alphabet and
returned as C<$filtered> string.

 sub filter {
	my ($in) = @_;
	$in =~ tr/a-z/A-Z/;   # Small to Capital letters
	$in =~ s/\W/ /g;      # Non-Word to Space
	$in =~ s/ +/ /g;      # 1-or-more spaces make one space
	$in =~ s/\s*$//;      # Eleminate Spaces at end.
	return $in;
}

=cut

sub filter {
	my ($in) = @_;
	$in =~ tr/a-z/A-Z/;   # Small to Capital letters
	$in =~ s/\W/ /g;      # Non-Word to Space
	$in =~ s/ +/ /g;      # 1-or-more spaces make one space
	$in =~ s/\s*$//;      # Eleminate Spaces at end.
	return $in;
}

=head2 $encoded = translate($filtered)

The C<$filtered> string is encoded in binary morse alphabet and returned as C<$encoded>.

 sub translate {
	my ($in) = @_;                      # filtered text string
	my $b;                              # binary result
	my @chars = split(//,$in);          # array of every character
	my $type = "";
	for( my $i=0; $i<=$#chars; $i++ ) { # loop over every char
		my $e = $chars[$i];
		my $n = $chars[$i+1];
		if($e eq " ") { 
			$b .= $gap{wg};             # if space, word gap
			next; 
		}
		else { 
			$b .= $code{$e};            # encode char
		}            
		if($i<$#chars) {                # gap not for last character
			if($n ne " ") {             # only if next is not SPACE
				$b .= $gap{cg};         # character gap
			}
		}
	}
	return $b;                          # return binary result
 }

=cut

sub translate {
	my ($in) = @_;                      # filtered text string
	my $b;                              # binary result
	my @chars = split(//,$in);          # array of every character
	my $type = "";
	for( my $i=0; $i<=$#chars; $i++ ) { # loop over every char
		my $e = $chars[$i];
		my $n = $chars[$i+1];
		if($e eq " ") { 
			$b .= $gap{wg};             # if space, word gap
			next; 
		}
		else { 
			$b .= $code{$e};            # encode char
		}            
		if($i<$#chars) {                # gap not for last character
			if($n ne " ") {             # only if next is not SPACE
				$b .= $gap{cg};         # character gap
			}
		}
	}
	return $b;                          # return binary result
}

=head2 multi_line($txt,$str)

The function C<multi_line()> is printing the Word and Binary representation of the 
input to a defined position on the screen during the morse code is played. 
The morse code is played on a defined line to visually show the morsed text.

On line 5 each word is printed as it is morsed.

On line 6 each binary is printed as it is morsed.

On line 7 is the morse light show.

 sub multi_line {
	my ($txt,$str) = @_;
	local $| = 1; # This autoflush is really necessary.
	cls;
	locate 1,0; print "Words: $txt";  # Print whole Text
	locate 2,0; print "Bin  : $str";  # Print whole binary
	locate 5,0; clline;               # Clear line 5
	locate 6,0; clline;               # Clear line 6

	sleep 1;
	my @s = split(//,$str);           # Split binary string in each bit.
	my @t = split(" ",$txt);          # Split text string in each word.
	my $pos = 1;                      # X-Poxition for output
	my $c;                            # Binary characters.
	locate 5,1; print shift @t;
	for( my $i=0; $i<=$#s; $i++ ) {   # Collect sequence of "0" or "1".
		$c .= $s[$i];
		next if defined($s[$i+1]) and $s[$i+1] eq $s[$i];

		my $len = length($c);         # Determine length of sequence.
		my $on  = substr($c,0,1);     # Determine if "0" or "1"
		locate 6,$pos; print "$c";    # Print Sequence
		$pos += $len;                 # Increase position according to length
		morse_light($on,$len);        # MORSE visual

		if(($on eq "0") and ($len == 7)) { # Clear line at end of each word.
			locate 5,0; clline; $pos = 1; 
			locate 6,0; clline; $pos = 1; 
			locate 5,1; print shift @t;
		}
		$c = "";
	} 	
 }

=cut

sub multi_line {
	my ($txt,$str) = @_;
	local $| = 1; # This autoflush is really necessary.
	cls;
	locate 1,0; print "Words: $txt";  # Print whole Text
	locate 2,0; print "Bin  : $str";  # Print whole binary
	locate 5,0; clline;               # Clear line 5
	locate 6,0; clline;               # Clear line 6

	sleep 1;
	my @s = split(//,$str);           # Split binary string in each bit.
	my @t = split(" ",$txt);          # Split text string in each word.
	my $pos = 1;                      # X-Poxition for output
	my $c;                            # Binary characters.
	locate 5,1; print shift @t;
	for( my $i=0; $i<=$#s; $i++ ) {   # Collect sequence of "0" or "1".
		$c .= $s[$i];
		next if defined($s[$i+1]) and $s[$i+1] eq $s[$i];

		my $len = length($c);         # Determine length of sequence.
		my $on  = substr($c,0,1);     # Determine if "0" or "1"
		locate 6,$pos; print "$c";    # Print Sequence
		$pos += $len;                 # Increase position according to length
		morse_light($on,$len);        # MORSE visual

		if(($on eq "0") and ($len == 7)) { # Clear line at end of each word.
			locate 5,0; clline; $pos = 1; 
			locate 6,0; clline; $pos = 1; 
			locate 5,1; print shift @t;
		}
		$c = "";
	} 	
}

=head2 morse_light($on,$length)

The C<morse_light()> function is doing the visual morse in line 7. First the max width
of the terminal is determined with C<Term::Size::Perl char()> function. Then the position
on the terminal is set with C<Term::ANSIScreen locate()> function. The color is changed
with C<color()> function and Spaces are printed in that new color. An usleep keeps the color
for the morse time and everything is resetted to original color.

 sub morse_light {
	my ($on,$length) = @_;   # $on = 0|1, $length is the length for the morse sign.
	my $max = chars;         # Terminal width

	locate 7,1;              # Set position
	if($on) { color 'white on red'; clline; } # Set color for ON
	print " " x $max;        # Print Spaces
	usleep 200000 * $length; # Sleep length of morse sign.

	print color 'reset';     # Reset color for location and print spaces.
	locate 7,1;
	print " " x $max;
 }

=cut

sub morse_light {
	my ($on,$length) = @_;   # $on = 0|1, $length is the length for the morse sign.
	my $max = chars;         # Terminal width

	locate 7,1;              # Set position
	if($on) { color 'white on red'; clline; } # Set color for ON
	print " " x $max;        # Print Spaces
	usleep 200000 * $length; # Sleep length of morse sign.

	print color 'reset';     # Reset color for location and print spaces.
	locate 7,1;
	print " " x $max;
}

# ================================ Usage ============================
sub usage {
	print "./ch-1.pl <command|string>\n";
	print "\n";
	print "   command, html|help\n";
	print "      help,  Prints out some usage information.\n";
	print "      html,  Writes HTML and CSS from POD.\n";
	print "\n";
	print "   Examples:\n";
	print "      # perldoc ch-1.pl\n";
	print "      # ./ch-1.pl help\n";
	print "      # ./ch-1.pl html\n";
}

sub html {
	# ------------- Create HTML --------------
	qx[ pod2html --header --title \"Perl Weekly Challenge #35 Task #1, Encode Morse\" --css \"pwc.css\" ch-1.pl > ch-1.html ];

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


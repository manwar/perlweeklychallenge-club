#!/usr/bin/perl

use strict;
use warnings;

=head1 Perl Weekly Challenge #34 Task #2: Decode Binary Morse Code

This week PWC in Task #2 shall decode binary morse code. In Task #2 it is done
the same way as in Task #1 only vice versa. A hash table is used to translate
every binary representation to a letter.

The output of Task #1 can be used as input of Task #2 with the use of Pipe "|"
and xargs, see below.

=begin html

<h2> Download and References </h2>
<b>Download File:</b><a href="ch-1.pl" download>Solution PWC #35 Task #1 ch-1.pl</a><br>
<b>Download File:</b><a href="ch-2.pl" download>Solution PWC #35 Task #2 ch-2.pl</a><br>
<br>
<a target=_blank href="https://en.wikipedia.org/wiki/Morse_code">https://en.wikipedia.org/wiki/Morse_code</a>

=end html

=head1 SYNOPSIS

 # perldoc ch-2.pl		- POD
 ./ch-2.pl <command|string>
 # ./ch-2.pl html		- HTML/CSS in ch-1.html/pwc.css
 # ./ch-2.pl help		- Usage information

 # ./ch-1.pl "My name is? hello123!"
 11101110001110101110111000000011101000101110001110111000100000001010001010100000001010101000100010111010100010111010100011101110111000101110111011101110001010111011101110001010101110111

 # ./ch-2.pl "11101110001110101110111000000011101000101110001110111000100000001010001010100000001010101000100010111010100010111010100011101110111000101110111011101110001010111011101110001010101110111"
 MY NAME IS HELLO123

 # ./ch-1.pl "My name is? hello123!" | xargs ./ch-2.pl
 MY NAME IS HELLO123

=head1 Definition Task #2

Write a program to decode binary morse code.

Consider how it might be possible to recover from badly formed morse code.
a) by splitting the morse code on gaps
b) without looking further than one digit ahead

=head1 Main program

The main program defines the hashes to translate from binary morse code to
text, reads the arguments and does the translation.

 my (%code,%gap);           # Define Hash tables
 my $cmd = shift @ARGV;		# Read command or text string.
 if(!$cmd) { 
	print "ch-2.pl (Version 1.0) PWC #35 Task #2: Decode Binary Morse Code\n";
	usage(); 
	exit 0; 
 }
 elsif($cmd eq "html") { html(); exit 0; }
 elsif($cmd eq "help") { usage(); exit 0; }
 else {
	init();                           # Initialize hash table.
	my $decoded  = translate($cmd);   # Decode from binary to text.
	print "$decoded\n";               # Print decoded string.
 }

=cut

my (%code,%gap);
my $cmd = shift @ARGV;		# Read command or text string
if(!$cmd) { 
	print "ch-2.pl (Version 1.0) PWC #35 Task #2: Decode Binary Morse Code\n";
	usage(); 
	exit 0; 
}
elsif($cmd eq "html") { html(); exit 0; }
elsif($cmd eq "help") { usage(); exit 0; }
else {
	init();
	my $decoded  = translate($cmd);
	print "$decoded\n";
}

=head2 init()

The C<init()> function initializes the hash table to translate letters to binary
morse code and to translate the gaps inbetween.

 sub init {
	%code = (
		'10111' => "A",
		'111010101' => "B",
		'11101011101' => "C",
		'1110101' => "D",
		'1' => "E",
		'101011101' => "F",
		'111011101' => "G",
		'1010101' => "H",
		'101' => "I",
		'1011101110111' => "J",
		'111010111' => "K",
		'101110101' => "L",
		'1110111' => "M",
		'11101' => "N",
		'11101110111' => "O",
		'10111011101' => "P",
		'1110111010111' => "Q",
		'1011101' => "R",
		'10101' => "S",
		'111' => "T",
		'1010111' => "U",
		'101010111' => "V",
		'101110111' => "W",
		'11101010111' => "X",
		'1110101110111' => "Y",
		'11101110101' => "Z",
		'10111011101110111' => "1",
		'101011101110111' => "2",
		'1010101110111' => "3",
		'10101010111' => "4",
		'101010101' => "5",
		'11101010101' => "6",
		'1110111010101' => "7",
		'111011101110101' => "8",
		'11101110111011101' => "9",
		'1110111011101110111' => "0",
	);
	%gap = (
		'cg' => "000",	# character gap
		'wg' => "0000000"	# word gap
	);
 }


=cut

sub init {
	%code = (
		'10111' => "A",
		'111010101' => "B",
		'11101011101' => "C",
		'1110101' => "D",
		'1' => "E",
		'101011101' => "F",
		'111011101' => "G",
		'1010101' => "H",
		'101' => "I",
		'1011101110111' => "J",
		'111010111' => "K",
		'101110101' => "L",
		'1110111' => "M",
		'11101' => "N",
		'11101110111' => "O",
		'10111011101' => "P",
		'1110111010111' => "Q",
		'1011101' => "R",
		'10101' => "S",
		'111' => "T",
		'1010111' => "U",
		'101010111' => "V",
		'101110111' => "W",
		'11101010111' => "X",
		'1110101110111' => "Y",
		'11101110101' => "Z",
		'10111011101110111' => "1",
		'101011101110111' => "2",
		'1010101110111' => "3",
		'10101010111' => "4",
		'101010101' => "5",
		'11101010101' => "6",
		'1110111010101' => "7",
		'111011101110101' => "8",
		'11101110111011101' => "9",
		'1110111011101110111' => "0",
	);
	%gap = (
		'cg' => "000",	# character gap
		'wg' => "0000000"	# word gap
	);
}

=head2 translate($in)

The C<translate()> function in Task #2 is doing the translation from binary code
back to text. The whole binary string is first split at word gap "0000000".
A second split is done for every word at character gap "000". Then the letter
is searched in a hash table and concatenated to one string.

 sub translate {
	my ($in) = @_;                           # binary string
	my @words = split(/$gap{wg}/,$in);       # array of every word
	my @strings;
	for( my $i=0; $i<=$#words; $i++ ) {      # loop over every char
		my @a = split(/$gap{cg}/,$words[$i]);
		my $s;                               # word
		foreach my $a (@a) {
			if(!$code{$a}) { $s .= "ERROR($a)"; } # Letter not found
			$s .= $code{$a};
		}
		push(@strings,$s);
	}
	return join(" ",@strings);               # return string result
 }

The following command shows the output of a proper binary string, followed by
the output of 2 missing "11" digits for the "O", and followed by 1 missing "1"
digit, that leads to an error message included in the output string.

 ./ch-2.pl 1010100011101110111000101010000000101010001110111011100010101
 SOS SOS

 ./ch-2.pl 10101000111010111000101010000000101010001110111011100010101
 SKS SOS

 ./ch-2.pl 101010001110110111000101010000000101010001110111011100010101
 S(ERROR 1110110111)S SOS

=cut

sub translate {
	my ($in) = @_;                           # binary string
	my @words = split(/$gap{wg}/,$in);       # array of every word
	my @strings;
	for( my $i=0; $i<=$#words; $i++ ) {      # loop over every char
		my @a = split(/$gap{cg}/,$words[$i]);
		my $s;                               # word
		foreach my $a (@a) {
			if(!$code{$a}) { $s .= "(ERROR $a)"; } # Letter not found
			else { $s .= $code{$a}; }
		}
		push(@strings,$s);
	}
	return join(" ",@strings);               # return string result
}


# ================================ Usage ============================
sub usage {
	print "./ch-2.pl <command|string>\n";
	print "\n";
	print "   command, html|help\n";
	print "      help,  Prints out some usage information.\n";
	print "      html,  Writes HTML and CSS from POD.\n";
	print "   string,  The binary string to decode.\n";
	print "\n";
	print "   Examples:\n";
	print "      # perldoc ch-2.pl\n";
	print "      # ./ch-2.pl help\n";
	print "      # ./ch-2.pl html\n";
}

sub html {
	# ------------- Create HTML --------------
	qx[ pod2html --header --title \"Perl Weekly Challenge #35 Task #2, Decode binary morse code.\" --css \"pwc.css\" ch-2.pl > ch-2.html ];

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


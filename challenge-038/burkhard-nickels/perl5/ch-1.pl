#!/usr/bin/perl

use strict;
use warnings;
use DateTime;
use Try::Tiny;

=head1 Perl Weekly Challenge #38 Task #1: Date Finder

The B<Date Finder> shall convert Digits to a Valid Date.

The digits are separated by the Matching Operator C<=~>. The Date is created
with the DateTime Module and returned in the proper format with the DateTime->ymd()
Methode. In case of wrong digits, the DateTime Module throws an exception that
can be caught by the Try::Tiny Module.

=over 3

=item * DateTime

=item * Try::Tiny

=back


=begin html

<h2> Download and References </h2>
<b>Download File:</b><a href="ch-1.pl" download>Solution PWC #38 Task #1 ch-1.pl</a><br>
<b>Download File:</b><a href="ch-2.pl" download>Solution PWC #38 Task #2 ch-2.pl</a><br>
<br>

=end html

=head1 SYNOPSIS

 # perldoc ch-1.pl		- POD
 ./ch-1.pl <command|string> [string]
 # ./ch-1.pl html		- HTML/CSS in ch-1.html/pwc.css
 # ./ch-1.pl help		- Usage information

 #  ./ch-1.pl 2191215
 Convert 2191215 to date 2019-12-15
 # ./ch-1.pl 2191235
 Error: Digits out of range: 2191235!
 # ./ch-1.pl 219123A
 Error: Digits are not numbers: 219123A !

=cut

my $cmd = shift @ARGV;		# Read command or text string
if(!$cmd) { 
	print "ch-1.pl (Version 1.0) PWC #38 Task #1: DateFinder\n";
	usage(); 
	exit 0; 
}
elsif($cmd eq "html") { html(); exit 0; }
elsif($cmd eq "help") { usage(); exit 0; }
else {
	my $result = convert($cmd);
	print "Convert $cmd to date $result\n";
}

# ====================== TASK 1 ==============================

=head1 Definition Task #1: Date Finder

Create a script to accept a 7 digits number, where the first number can only be 1 or 2. 
The second and third digits can be anything 0-9. The fourth and fifth digits corresponds 
to the month i.e. 01, 02, 03 ..., 11, 12. And the last 2 digits respresents the days 
in the month i.e. 01, 02, 03 ..., 29, 30, 31. Your script should validate if the given 
number is valid as per the rule and then convert into human readable format date.

B<RULES>

=over 2

=item 1) If 1st digit is 1, then prepend 20 otherwise 19 to the 2nd and 3rd digits to make it 4-digits year.

=item 2) The 4th and 5th digits together should be a valid month.

=item 3) The 6th and 7th digits together should be a valid day for the above month.

=back

For example, the given number is 2230120, it should print 1923-01-20.

=cut

# ====================== TASK 1 ==============================

=head2 Function convert()

 sub convert {
   my ($digits) = @_;

   # ----- Vars
   my %cent = ( '1' => 19, '2' => 20 );
   my ($dt, $c,$y,$m,$d);

   # ----- Extract single digits
   if( ! (($c,$y,$m,$d) = ($digits =~ /(\d{1})(\d{2})(\d{2})(\d{2})/)) ) {
     die "Error: Digits are not numbers: $digits !\n";
   }

   # ----- Set Date in DateTime
   try {
     $dt = DateTime->new(
       year       => "$cent{$c}$y",
       month      => $m,
       day        => $d,
     );

   # ----- Use Try::Tiny to evaluate and catch errors from DateTime
   } catch {
     die "Error: Digits out of range: $digits!\n";
   };
   my $result = $dt->ymd;
 }

=cut

sub convert {
	my ($digits) = @_;

	# ----- Vars
	my %cent = ( '1' => 19, '2' => 20 );
	my ($dt, $c,$y,$m,$d);

	# ----- Extract single digits
	if( ! (($c,$y,$m,$d) = ($digits =~ /(\d{1})(\d{2})(\d{2})(\d{2})/)) ) {
		die "Error: Digits are not numbers: $digits !\n";
	}

	# ----- Set Date in DateTime
	try {
		$dt = DateTime->new(
			year       => "$cent{$c}$y",
			month      => $m,
			day        => $d,
		);
	} catch {
		die "Error: Digits out of range: $digits!\n";
	};
	my $result = $dt->ymd;
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


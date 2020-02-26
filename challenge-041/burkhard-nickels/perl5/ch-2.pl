#!/usr/bin/perl

use strict;
use warnings;

=head1 Perl Weekly Challenge #41 Task #2: Leonardo Numbers

<Explanation of the created solution>

=over 3

=item * <Used modules and for what used>

=item * <Used modules and for what used>

=back


=begin html

<h2> Download and References </h2>
<b>Download File:</b><a href="ch-1.pl" download>Solution PWC #40 Task #1 ch-1.pl</a><br>
<b>Download File:</b><a href="ch-2.pl" download>Solution PWC #40 Task #2 ch-2.pl</a><br>
<br>
<a target=_blank href="https://en.wikipedia.org/wiki/Leonardo_number">
https://en.wikipedia.org/wiki/Leonardo_number
</a>

=end html

=head1 SYNOPSIS

 # perldoc ch-2.pl		- POD
 ./ch-2.pl <command|string> [string]
 # ./ch-2.pl html		- HTML/CSS in ch-2.html/pwc.css
 # ./ch-2.pl help		- Usage information


=cut

print "ch-2.pl (Version 1.0) PWC #40 Task #2: Leonardo Numbers\n";
my $cmd = shift @ARGV;		# Read command or text string
if(!$cmd) { $cmd = ""; }
if($cmd eq "html") { html(); exit 0; }
elsif($cmd eq "help") { usage(); exit 0; }

# ====================== TASK 2 ==============================

=head1 Definition Task #2: Leonardo Numbers

Write a script to display first 20 Leonardo Numbers. 
Please checkout wiki page for more information.

For example:
L(0) = 1
L(1) = 1
L(2) = L(0) + L(1) + 1 = 3
L(3) = L(1) + L(2) + 1 = 5

and so on.

=cut

# ====================== TASK 2 ==============================

=head1 Functions


=cut

my $max = 8;

print "Function leonardo1() with recursive function call ...\n";
foreach my $i (0 .. $max) {
	my $cnt = 0;
	my $nr = leonardo1($i,\$cnt); 
	print "L($i) = $nr ($cnt)\n";
}

sub leonardo1 {
	my ($nr,$cnt) = @_;
	$$cnt++;
	if( $nr == 0 or $nr == 1 ) { return 1; }
	else {
		return leonardo1($nr-1,$cnt) + leonardo1($nr-2,$cnt) + 1;
	}
}

print "Function leonardo2() with storing values in Array ...\n";
my @L;
foreach my $i (0 .. $max) {
	my $cnt = 0;
	my $nr = leonardo2($i,\$cnt); 
	$L[$i] = $nr;
	print "L($i) = $nr ($cnt)\n";
}

sub leonardo2 {
	my ($nr,$cnt) = @_;
	$$cnt++;
	if( $nr == 0 or $nr == 1 ) { return 1; }
	else { return $L[$nr-1] + $L[$nr-2] + 1; }
}



# ================================ Usage ============================
sub usage {
	print "./ch-2.pl [help|html]\n";
	print "\n";
	print "   command, html|help\n";
	print "      help,  Prints out some usage information.\n";
	print "      html,  Writes HTML and CSS from POD.\n";
	print "\n";
	print "   Examples:\n";
	print "      # ./ch-2.pl\n";
	print "      # perldoc ch-2.pl\n";
	print "      # ./ch-2.pl help\n";
	print "      # ./ch-2.pl html\n";
}

sub html {
	# ------------- Create HTML --------------
	qx[ pod2html --header --title \"Perl Weekly Challenge #35 Task #2, Encode Morse\" --css \"pwc.css\" ch-2.pl > ch-2.html ];

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


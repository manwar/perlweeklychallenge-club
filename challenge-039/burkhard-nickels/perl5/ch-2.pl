#!/usr/bin/perl

use strict;
use warnings;
use Math::RPN;

=head1 Perl Weekly Challenge #39 Task #2: RPN

RPN - Reverse Polish Notation has several Modules on CPAN. I installed C<Math::RPN>
to show RPN.

=over 3

=item * Math::RPN

=back


=begin html

<h2> Download and References </h2>
<b>Download File:</b><a href="ch-1.pl" download>Solution PWC #39 Task #1 ch-1.pl</a><br>
<b>Download File:</b><a href="ch-2.pl" download>Solution PWC #39 Task #2 ch-2.pl</a><br>
<br>
<a href="https://en.wikipedia.org/wiki/Reverse_Polish_notation">
https://en.wikipedia.org/wiki/Reverse_Polish_notation</a><br>

=end html

=head1 SYNOPSIS

 # perldoc ch-2.pl		- POD
 ./ch-2.pl [html|help]
 # ./ch-2.pl            - Executes the program.
 # ./ch-2.pl html		- HTML/CSS in ch-2.html/pwc.css
 # ./ch-2.pl help		- Usage information

 ./ch-2.pl 
 ch-2.pl (Version 1.0) PWC #39 Task #2: RPN
 IN: 2,3,+,10,+,5,-
 Result: 10

=cut

print "ch-2.pl (Version 1.0) PWC #39 Task #2: RPN\n";
my $cmd = shift @ARGV;		# Read command or text string
if(!$cmd) { $cmd = ""; } 
if($cmd eq "html") { html(); exit 0; }
elsif($cmd eq "help") { usage(); exit 0; }
else {
	calculate_rpn();
}

# ====================== TASK 2 ==============================

=head1 Definition Task #2: RPN

Write a script to demonstrate Reverse Polish Notation(RPN). 
Checkout the wiki page for more information about RPN.

=cut

# ====================== TASK 2 ==============================

=head1 RPN with Math::RPN

Reverse Polish Notation is a mathematical calculation with the operator after the operands.
In the example some simple add and substract is used.
The RPN C< my $rpn = "2,3,+,10,+,5,-"; > is doing the mathematical:

 2  +  3 = 5
 5  + 10 = 15
 15 -  5 = 10

So the result of these operations is 10.

	use Math::RPN;

	my $rpn = "2,3,+,10,+,5,-";
	my $value = rpn(split(",",$rpn));

	print "IN: $rpn\n";
	print "Result: $value\n";

=cut

sub calculate_rpn {

	my $rpn = "2,3,+,10,+,5,-";
	my $value = rpn(split(",",$rpn));
	my @array = rpn(split(",",$rpn));

	print "IN: $rpn\n";
	print "Result: $value\n";
	print "Array: ", join(",",@array), "\n";
}

# ================================ Usage ============================
sub usage {
	print "./ch-2.pl [html|help]\n";
	print "\n";
	print "      help,  Prints out some usage information.\n";
	print "      html,  Writes HTML and CSS from POD.\n";
	print "\n";
	print "   Examples:\n";
	print "      # perldoc ch-2.pl\n";
	print "      # ./ch-2.pl\n";
	print "      # ./ch-2.pl help\n";
	print "      # ./ch-2.pl html\n";
}

sub html {
	# ------------- Create HTML --------------
	qx[ pod2html --header --title \"Perl Weekly Challenge #39 Task #2, RPN\" --css \"pwc.css\" ch-2.pl > ch-2.html ];

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


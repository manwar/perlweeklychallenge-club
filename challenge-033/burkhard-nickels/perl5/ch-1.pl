#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use IO::All;
use Data::Dumper qw(Dumper);

=head1 Perl Weekly Challenge #33 Task #1: Count letters

This week PWC in Task #1 shall "Count letters" from sentences in one or
more files.

For counting the letters I chose the perl module IO::All to read the whole
files, filtering with grep and split and using for/foreach loops for
printing the results. And I created a solution as one-liner that uses
the C<-F> option to already split the input.

=begin html

<h2> Download and References </h2>
<b>Download File:</b><a href="ch-1.pl" download>Solution PWC #33 Task #1 ch-1.pl</a><br>
<br><br>

=end html

=head1 SYNOPSIS

 # perldoc ch-1.pl		- POD
 # ./ch-1.pl html		- HTML/CSS in ch-1.html/pwc.css
 # ./ch-1.pl help		- Usage information

 ./ch-1.pl [<command>] [<files>]

 # ./ch-1.pl one example.txt
 # ./ch-1.pl task1 example.txt

=cut

# ====================== TASK 1 ==============================

=head1 Definition Task #1: Count Letters (A..Z)

Create a script that accepts one or more files specified on the command-line and count the number of times letters appeared in the files.

So with the following input file sample.txt

 The quick brown fox jumps over the lazy dog.

the script would display something like:

 a: 1
 b: 1
 c: 1
 d: 1
 e: 3
 f: 1
 g: 1
 h: 2
 i: 1
 j: 1
 k: 1
 l: 1
 m: 1
 n: 1
 o: 4
 p: 1
 q: 1
 r: 2
 s: 1
 t: 2
 u: 2
 v: 1
 w: 1
 x: 1
 y: 1
 z: 1

=cut

# ====================== TASK 1 ==============================

=head1 Solution Task #1: Count letters

In line 2 the C<IO::All slurp()> function reads the files that are
given in C<@ARGV>. Line 5 is doing a C<split> on every character and
the C<grep> on letters that are than stored in C<@items>. The C<foreach>
loop in line 9 increases a counter for every lower case, C<lc()>,
letter. In the one-liner this is done via the C<map()> function.
The result is printed in a C<foreach> loop from line 12 to 14.

  1 my $lines;
  2 foreach(@ARGV) { $lines .= io($_)->slurp; }
  3
  4 # ---------- Input and grep letters ---------
  5 my @items = grep { /[a-zA-Z]/ } split //,$lines;
  6
  7 # ---------- Count letters ------------
  8 my %sum;
  9 foreach my $i (@items) { $sum{lc($i)}++; }
 10
 11 # -------- Output --------------
 12 foreach my $i (sort keys %sum) { 
 13 	print "$i: $sum{$i}\n"; 
 14 }

=cut

sub task1 {
	my $lines;
	foreach(@ARGV) { $lines .= io($_)->slurp; }

	# ---------- Input and grep letters ---------
	my @items = grep { /[a-zA-Z]/ } split //,$lines;

	# ---------- Count letters ------------
	my %sum;
	foreach my $i (@items) { $sum{lc($i)}++; }

	# -------- Output --------------
	foreach my $i (sort keys %sum) { 
		print "$i: $sum{$i}\n"; 
	}
}

=head2 One-Liner

I also tried to create the whole script in one line. The C<-F//> Option
defines a character to split the input. I used two C<-e> Options, which
each defines a line of perl code. 

On the first line the splitted string
is stored in the list C<@F>. With C<grep> are filtered all letters and
mapped into the hash C<%s>.

On the second line a C<for> loop prints the result. In file F<example.txt>
is the sentence from Task #1. When two the same files are the input, the
values are the double.

 # ./pwc33.pl one example.txt example.txt
 pwc33.pl (Version 1.0): One-Liner
 One liner: example.txt example.txt
 Command: perl -F// -e 'map { $_ => ++$s{lc($_)} } grep {/[a-zA-Z]/} @F;' -e 'END{ for(keys %s) { print "$_:$s{$_}\n";} }' example.txt example.txt
 y:2
 z:2
 x:2
 p:2
 d:2
 a:2
 v:2
 T:2
 n:2
 w:2
 u:4
 c:2
 g:2
 e:6
 f:2
 l:2
 o:8
 q:2
 m:2
 h:4
 r:4
 k:2
 i:2
 t:2
 b:2
 s:2
 j:2

=cut


sub task1_one_liner {
	my $file = join(" ",@ARGV);
	print "One liner: $file\n";
	my $cmd = 'perl -F// -e \'map { $_ => ++$s{$_} } grep {/[a-zA-Z]/} @F;\' -e \'END{ for(keys %s) { print "$_:$s{$_}\n";} }\'';

	print "Command: $cmd $file\n";
	system( "$cmd $file" );
}

# ----------------- Global Vars -----------------

# ----------------- Main program -----------------
print "ch-1.pl (Version 1.0) PWC #33 Task #1: ";

my $command = shift @ARGV;		# Read command

# -- Verify file for commands "one", "task1" 
if($command and ($command eq "one" or $command eq "task1")) { 
	if(! $ARGV[0]) { die "Error: Missing file name!\n"; }
	if(! -f $ARGV[0]) { die "Error: File does not exist $ARGV[0]!\n"; }
}

# -- Execution of simple commands -----------------
if(! $command) { # if no command print usage
	print "Usage\n"; 
	usage(); 
}
elsif($command eq "html") { # if command html or help
	print "HTML\n"; 
	html(); 
}
elsif($command eq "help") { 
	print "Help\n"; 
	usage(); 
}
elsif($command eq "one") { 
	print "One-Liner\n";
	task1_one_liner(); 
}
elsif($command eq "task1") { 
	print "Task #1\n";
	task1(); 
}

# ================================ Usage ============================
sub usage {
	print "./ch-1.pl [<command>] [<files>]\n";
	print "\n";
	print "   command, help|html|task1|one \n";
	print "      help,  Prints out some usage information.\n";
	print "      html,  Writes HTML and CSS from POD.\n";
	print "      task1, Solution for Task #1.\n";
	print "      one,   Solution for Task #1 as One-Liner.\n";
	print "   files, list of filenames.\n";
	print "\n";
	print "   Examples:\n";
	print "      # perldoc ch-1.pl\n";
	print "      # ./ch-1.pl help\n";
	print "      # ./ch-1.pl html\n";
	print "      # ./ch-1.pl one example.txt\n";
	print "      # ./ch-1.pl task1 example.txt\n";
}

sub html {
	# ------------- Create HTML --------------
	qx[ pod2html --header --title \"Perl Weekly Challenge #33 Task #1, Count Letters\" --css \"pwc.css\" ch-1.pl > ch-1.html ];

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


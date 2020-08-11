#!/usr/bin/perl

use strict;
use warnings;

=head1 Perl Weekly Challenge #40 Task #1: Show multiple arrays content.

The code is an iteration with a C<for> loop through its elements by index.

I compare three solutions, first with Perl5, second with Perl6 and third
also with Python. For me it is a learning excercise in Perl6 and Python.

So the special thing here are the 3 used script languages:

=over 3

=item * Perl5 Solution

=item * Perl6 Solution

=item * Python Solution

=back


=begin html

<h2> Download and References </h2>
<b>Download File:</b><a href="ch-1.pl" download>Solution PWC #40 Task #1 ch-1.pl</a><br>
<b>Download File:</b><a href="ch-2.pl" download>Solution PWC #40 Task #2 ch-2.pl</a><br>
<b>Download File:</b><a href="ch-1.p6" download>Solution PWC #40 Task #1 ch-1.p6</a><br>
<b>Download File:</b><a href="ch-2.p6" download>Solution PWC #40 Task #2 ch-2.p6</a><br>
<b>Download File:</b><a href="ch-1.py" download>Solution PWC #40 Task #1 ch-1.py</a><br>
<b>Download File:</b><a href="ch-2.py" download>Solution PWC #40 Task #2 ch-2.py</a><br>
<br>

<b> Perl5 to Perl6 in a Nutshell </b><br>
<a target=_blank href="https://docs.perl6.org/language/5to6-nutshell">
https://docs.perl6.org/language/5to6-nutshell</a><br>
<br>
<b> Raku Website </b><br>
<a target=_blank href="https://raku.org/">
https://raku.org/</a><br>

=end html

=head1 SYNOPSIS

 # ./ch-1.pl
 ch-1.pl (Version 1.0) PWC #40 Task #1: Show multiple arrays content.
 I 2 !
 L 4 ?
 O 0 P 
 V 3 $
 E 2 %
 Y 0 ^
 O 1 &
 U 9 *

 # perldoc ch-1.pl		- POD
 # ./ch-1.pl html		- HTML/CSS in ch-1.html/pwc.css
 # ./ch-1.pl help		- Usage information

=cut

print "ch-1.pl (Version 1.0) PWC #40 Task #1: Show multiple arrays content.\n";

my $cmd = shift @ARGV;		# Read command or text string
if($cmd and $cmd eq "html") { 
	html(); exit 0; 
}
elsif($cmd and $cmd eq "help") { 
	usage(); exit 0; 
}

# ====================== TASK 1 ==============================

=head1 Definition Task #1: Show multiple arrays content

You are given two or more arrays. 
Write a script to display values of each list at a given index.

For example:

 Array 1: [ I L O V E Y O U ]
 Array 2: [ 2 4 0 3 2 0 1 9 ]
 Array 3: [ ! ? P $ % ^ & * ]

We expect the following output:

 I 2 !
 L 4 ?
 O 0 P
 V 3 $
 E 2 %
 Y 0 ^
 O 1 &
 U 9 *

=cut

# ====================== TASK 1 ==============================

=head1 Perl5 Solution

The three arrays are initialized with its values. With a C<for> loop
an iteration over the indices is done. Than every array element is
printed with the index.

 #!/usr/bin/perl

 use strict;
 use warnings;

 print "ch-1.pl (Version 1.0) PWC #40 Task #1: Show multiple arrays content.\n";

 my @a1 = ('I','L','O','V','E','Y','O','U');
 my @a2 = ('2','4','0','3','2','0','1','9');
 my @a3 = ('!','?','P','$','%','^','&','*');

 for( my $i=0; $i<=$#a1; $i++ ) {
	print "$a1[$i] $a2[$i] $a3[$i]\n";
 }

=cut

my @a1 = ('I','L','O','V','E','Y','O','U');
my @a2 = ('2','4','0','3','2','0','1','9');
my @a3 = ('!','?','£','$','%','^','&','*');

# Pound Sign: <AltGr><Shift><3> on Debian with german keyboard

for( my $i=0; $i<=$#a1; $i++ ) {
	print "$a1[$i] $a2[$i] $a3[$i]\n";
}

=head1 Perl6 Solution

The Perl6 Solution is similar to Perl5. A for C<loop> is used to iterate
through the elements. But the most significant change is, that
the C<for> keyword in Perl5 is now C<loop> in Perl6.

What are the differences here to make it working:

=over 3

=item * ch-1.p6, instead of ch-1.pl

=item * Shebang: #!/home/chuck/rakudo/bin/perl6 instead #!/usr/bin/perl.
 (I installed rakudo to user home.)

=item * loop, instead of for keyword

=item * blank after loop: "loop ("

=item * @a1.end, instead of $#a1

=item * @a1[$i], instead of $a1[$i] for each list element

=item * Execution time for perl6 is much longer then for perl5, see below.

=back

Following is the code for the Perl6 solution.

 #!/home/chuck/rakudo/bin/perl6

 use strict;

 print "ch-1.p6 (Version 1.0) PWC #40 Task #1: Show multiple arrays content.\n";

 my @a1 = ('I','L','O','V','E','Y','O','U');
 my @a2 = ('2','4','0','3','2','0','1','9');
 my @a3 = ('!','?','P','$','%','^','&','*');

 loop ( my $i = 0; $i <= @a1.end; $i++ ) {
	print "@a1[$i] @a2[$i] @a3[$i]\n";
 }

=cut

=head1 Python Solution

Some syntactical differences in Python are, C<import> instead of C<use>,
curly braces, double colon after C<for> loop, no sigil for variables, ...

Because this is also my first Python Script, have a look on it for yourself:

 #!/usr/bin/python

 import array as arr

 print "ch-1.py (Version 1.0) PWC #40 Task #1: Show multiple arrays content."

 a1 = ['I','L','O','V','E','Y','O','U']
 a2 = ['2','4','0','3','2','0','1','9']
 a3 = ['!','?',u"\xA3",'$','%','^','&','*']
 A1 = arr.array('c', a1)

 for i in range(0,len(a1)):
	print A1[i], " ", a2[i], " ", a3[i]

=cut


=head1 Runtime Comparision

Below is a comparision of the runtime. Perl5 is the fastest, Python is
close to Perl5, but Perl6 takes much longer to run this Script.

 # time ./ch-1.p6
 ch-1.p6 (Version 1.0) PWC #40 Task #1: Show multiple arrays content.
 I 2 !
 L 4 ?
 O 0 P
 V 3 $
 E 2 %
 Y 0 ^
 O 1 &
 U 9 *
 
 real	0m0,356s
 user	0m0,516s
 sys	0m0,028s
 
 # time ./ch-1.pl
 ch-1.pl (Version 1.0) PWC #40 Task #1: Show multiple arrays content.
 I 2 !
 L 4 ?
 O 0 P
 V 3 $
 E 2 %
 Y 0 ^
 O 1 &
 U 9 *
 
 real	0m0,017s
 user	0m0,012s
 sys	0m0,004s
 
 # time ./ch-1.py
 ch-1.py (Version 1.0) PWC #40 Task #1: Show multiple arrays content.
 I   2   !
 L   4   ?
 O   0   P
 V   3   $
 E   2   %
 Y   0   ^
 O   1   &
 U   9   *
 
 real	0m0,032s
 user	0m0,028s
 sys	0m0,000s

=cut

# ================================ Usage ============================
sub usage {
	print "./ch-1.pl [<command>]\n";
	print "\n";
	print "   command, html|help\n";
	print "      help,  Prints out some usage information.\n";
	print "      html,  Writes HTML and CSS from POD.\n";
	print "\n";
	print "   Examples:\n";
	print "      # ./ch-1.pl\n";
	print "      # perldoc ch-1.pl\n";
	print "      # ./ch-1.pl help\n";
	print "      # ./ch-1.pl html\n";
}

sub html {
	# ------------- Create HTML --------------
	qx[ pod2html --header --title \"Perl Weekly Challenge #40 Task #1, Show Multiple Array Contents\" --css \"pwc.css\" ch-1.pl > ch-1.html ];

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


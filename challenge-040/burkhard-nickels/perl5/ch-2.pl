#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper qw(Dumper);
$Data::Dumper::Indent=0;

=head1 Perl Weekly Challenge #40 Task #2: Sort SubList

The code for the sorting of a SubList is mainly the C<sort()> function
applied on an array slice. I use a simple way of output with the Data::Dumper
module.

I compare also in Task#2 three solutions, first with Perl5, second with Perl6 and third
with Python. For me it is a learning excercise in Perl6 and Python.

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

=end html

=head1 SYNOPSIS

 # ./ch-2.pl
 ch-2.pl (Version 1.0) PWC #40 Task #2: Sort SubList.
 Before:$VAR1 = [10,4,1,8,12,3];
 After: $VAR1 = [1,4,3,8,12,10];

 ./ch-2.pl [<command>]
 # perldoc ch-2.pl		- POD
 # ./ch-2.pl html		- HTML/CSS in ch-2.html/pwc.css
 # ./ch-2.pl help		- Usage information

=cut

print "ch-2.pl (Version 1.0) PWC #40 Task #2: Sort SubList.\n";

my $cmd = shift @ARGV;		# Read command or text string
if($cmd and $cmd eq "html") { 
	html(); exit 0; 
}
elsif($cmd and $cmd eq "help") { 
	usage(); exit 0; 
}

# ====================== TASK 2 ==============================

=head1 Definition Task #2: Sort SubList

You are given a list of numbers and set of indices belong to the list. 
Write a script to sort the values belongs to the indices.

For example,

 List: [ 10, 4, 1, 8, 12, 3 ]
 Indices: 0,2,5

We would sort the values at indices 0, 2 and 5 i.e. 10, 1 and 3.

Final List would look like below:

 List: [ 1, 4, 3, 8, 12, 10 ]

=cut

# ====================== TASK 2 ==============================

=head1 Perl5 Solution

The sorting of a SubList is done on an Array Slice with the C<sort()> function.
The sorted Array Slice is assigned back to the same Array Slice.

Data::Dumper is used for the output. The C<$Data::Dumper::Indent> variable is
set to "0" that means no indentation.

 #!/usr/bin/perl

 use strict;
 use warnings;
 use Data::Dumper qw(Dumper);
 $Data::Dumper::Indent=0;

 my @a = (10,4,1,8,12,3); # Initialize Array
 my @i = (0,2,5);         # Initialize Indices, not used here.

 print "Before:", Dumper(\@a), "\n";
 @a[0,2,5] = sort { $a <=> $b } ( @a[0,2,5] ); # sort on array slice
 print "After: ", Dumper(\@a), "\n";

=cut

my @a = (10,4,1,8,12,3);
my @i = (0,2,5);
print "Before:", Dumper(\@a), "\n";

@a[0,2,5] = sort { $a <=> $b } ( @a[0,2,5] );
print "After: ", Dumper(\@a), "\n";


=head1 Perl6 Solution

What are some differences here between Perl5 and Perl6: The C<sort()> methode
is called C<@d.sort()>. In Perl5 subroutines are called with an arrow. The
C<.Int> as the sorting function I still do not understand. Like I said before,
this is my first Perl6 Script.

 #!/home/chuck/rakudo/bin/perl6

 use strict;

 print "ch-2.p6 (Version 1.0) PWC #40 Task #2: Sort SubList\n";

 # -----------------------------------------------
 my @a = (10,4,1,8,12,3);
 my @i = (0,2,5);

 print "Before:", join(" - ", @a), "\n";
 my @d = @a[0,2,5];
 @a[0,2,5] = @d.sort( { .Int } );  # sort on array slice
 print "After: ", join(" - ", @a), "\n";

 # -----------------------------------------------
 # p6doc -f Type::List.sort

=cut

=head1 Python Solution

What special can we find here? The C<numpy> Python Module is used
because of the C<sort()> Methode. Syntactial it is different to Perl.

But see yourself the code below:

 #!/usr/bin/python

 import array as arr
 import numpy as np 

 a = arr.array('i', [10,4,1,8,12,3])
 b = [10,4,1,8,12,3]
 print(a)
 print(b)

 print(a[slice(0,2,5)])

 # -------------------------------------------------  
 B = np.array(b) 

 R = B[np.array([0,2,5])]
 R.sort()
 B[np.array([0,2,5])] = R
 print(" Result: ", B )

=cut

# ================================ Usage ============================
sub usage {
	print "./ch-2.pl [<command>]\n";
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
	qx[ pod2html --header --title \"Perl Weekly Challenge #40 Task #2, Sort SubList\" --css \"pwc.css\" ch-2.pl > ch-2.html ];

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


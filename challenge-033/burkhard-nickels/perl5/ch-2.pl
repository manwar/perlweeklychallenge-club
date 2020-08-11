#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use PDL;
use PDL::NiceSlice;
use Data::Dumper qw(Dumper);

=head1 Perl Weekly Challenge #33 Task #2: Multiplication Table

This week PWC in Task #2 shall print a multiplication table.

For the multiplication table I chose a more difficult approach with Perl
Data Language (PDL) to do the calculation of the table and the Perl format
function for printing the results.

=begin html

<h2> Download and References </h2>
<b>Download File:</b><a href="ch-2.pl" download>Solution PWC #33 Task #2 ch-2.pl</a><br>
<br><br>
<a target=_blank href="http://pdl.perl.org/content/pdl-book-toc.html">pdl.perl.org: PDL Book</a><br>
<br>
<a target=_blank href="http://pdl.perl.org/">pdl.perl.org</a><br>
<br>

=end html

=head1 SYNOPSIS

 # perldoc ch-2.pl		- POD
 # ./ch-2.pl html		- HTML/CSS in ch-2.html/pwc.css
 # ./ch-2.pl help		- Usage information

 ./ch-2.pl <command> [<options>]

 # perldoc ch-2.pl
 # ./ch-2.pl help
 # ./ch-2.pl html
 # ./ch-2.pl task2
 # ./ch-2.pl task2 -p
 # ./ch-2.pl task2 --pdl
 # ./ch-2.pl task2 --array
 # ./ch-2.pl task2 --simple
 # ./ch-2.pl task2 --slice

=cut

# ====================== TASK 2 ==============================

=head1 Definition Task #2: Formatted Multiplication Table

Write a script to print 11x11 multiplication table, only the top half triangle.

  x|   1   2   3   4   5   6   7   8   9  10  11
---+--------------------------------------------
  1|   1   2   3   4   5   6   7   8   9  10  11
  2|       4   6   8  10  12  14  16  18  20  22
  3|           9  12  15  18  21  24  27  30  33
  4|              16  20  24  28  32  36  40  44
  5|                  25  30  35  40  45  50  55
  6|                      36  42  48  54  60  66
  7|                          49  56  63  70  77
  8|                              64  72  80  88
  9|                                  81  90  99
 10|                                     100 110
 11|                                         121

=cut

# ====================== Solution TASK 2 ==============================

sub task2_pdl {
	my ($n,$e) = (12,1);
	my $a  = xvals($n,$n) * yvals($n,$n);  # Calculate the Matrix.
	foreach my $y (2..11) { 
		$a(1:$e++,($y)) .= 0;              # Set "0" Zero to one Half.
	}
	output_pdl($a);                        # Output of Matrix.
}

=head1 Solution Task #2: PDL Perl Data Language

First I tried a not so easy solution for a rather easy task. Because PDL,
the Perl Data Language, needs a lot effort to understand 
before you can use it. PDL is more meant for big matrix calculations.

PDL allows you to do matrix calcuations in a rather
fast way. Matrix can also for example mean Image Processing. And for Image
Processing some performance is needed.

But I wanted to try it here, to recall some knowledge about PDL.
So the resulting calculation of the Matrix looks small and easy:

 use PDL;                               # Include PDL Module.
 my ($n,$e) = (12,1);
 my $a  = xvals($n,$n) * yvals($n,$n);  # Calculate the Matrix.
 foreach my $y (2..11) { 
 	$a(1:$e++,($y)) .= 0;               # Set "0" Zero to one Half.
 }
 output_pdl($a);                        # Output of Matrix.

=head2 PDL xvals() / yvals()

With the PDL function xvals() you can create a matrix with X index values.
The Index of a Matrix/Array goes from 0 to N. And this Index you can create
in a 2-dimensional Matrix in several rows. In our example we create a
12x12 Matrix of the X and Y Index.

Create an example Index Matrix with xvals():

 perl -e 'use PDL; print xvals(12,2);'
 [
  [ 0  1  2  3  4  5  6  7  8  9 10 11]
  [ 0  1  2  3  4  5  6  7  8  9 10 11]
 ]

Create an example Index Matrix with yvals():

 perl -e 'use PDL; print yvals(2,12);'

 [
  [ 0  0]
  [ 1  1]
  [ 2  2]
  [ 3  3]
  [ 4  4]
  [ 5  5]
  [ 6  6]
  [ 7  7]
  [ 8  8]
  [ 9  9]
  [10 10]
  [11 11]
 ]

So we create our two index matrices 12x12, because we need values
from 0 to 11:

 my $xi = xvals(12,12);
 my $yi = yvals(12,12);

More details on the xvals() and yvals() functions can be found in:

 perldoc PDL::Basics

=head2 PDL Multiplication

Now we do a multiplication of the single values of these two matrices.
When you work with PDL, the objects you work with are called Piddles.
These Piddles (PDL Matrices) can be used in several types of operations.
So you can also use simple Matrix operations on them.

The xvals()/yvals() functions return a piddle object. The multiplication
of them returns another piddle object. A piddle object can be printed
simply with a print statement. The result below contains already the
data we wanted to have. Only some extra values are disturbing a little bit.

 my $a  = xvals($n,$n) * yvals($n,$n);  # Calculate the Matrix.
 print $a;

 [
  [  0   0   0   0   0   0   0   0   0   0   0   0]
  [  0   1   2   3   4   5   6   7   8   9  10  11]
  [  0   2   4   6   8  10  12  14  16  18  20  22]
  [  0   3   6   9  12  15  18  21  24  27  30  33]
  [  0   4   8  12  16  20  24  28  32  36  40  44]
  [  0   5  10  15  20  25  30  35  40  45  50  55]
  [  0   6  12  18  24  30  36  42  48  54  60  66]
  [  0   7  14  21  28  35  42  49  56  63  70  77]
  [  0   8  16  24  32  40  48  56  64  72  80  88]
  [  0   9  18  27  36  45  54  63  72  81  90  99]
  [  0  10  20  30  40  50  60  70  80  90 100 110]
  [  0  11  22  33  44  55  66  77  88  99 110 121]
 ]

=head2 PDL Slices

PDL has an easy way to view only a part of your Matrix.
Details on this are documented in C<perldoc PDL::NiceSlice>.
You can create a slice of that Matrix with typing the
wanted index. This Slice is not a copy of your Matrix, only
a different view, so you need to know that you are working on 
your original data.

 my $b = $a(1:11,1:11);
 print $b;

 [
  [  1   2   3   4   5   6   7   8   9  10  11]
  [  2   4   6   8  10  12  14  16  18  20  22]
  [  3   6   9  12  15  18  21  24  27  30  33]
  [  4   8  12  16  20  24  28  32  36  40  44]
  [  5  10  15  20  25  30  35  40  45  50  55]
  [  6  12  18  24  30  36  42  48  54  60  66]
  [  7  14  21  28  35  42  49  56  63  70  77]
  [  8  16  24  32  40  48  56  64  72  80  88]
  [  9  18  27  36  45  54  63  72  81  90  99]
  [ 10  20  30  40  50  60  70  80  90 100 110]
  [ 11  22  33  44  55  66  77  88  99 110 121]
 ]

=head2 Setting Values with Slices.

So with this slicing feature we can set also values to these Slices.
We use it to set our not wanted values to Zero. In our solution we
work on the original Matrix, not on the above extract that already
excluded row one and column 0 (that has only zeroes). So we start
on Index 2. Means in our first iteration we call

 $a(1:1,(2));

We take the whole row 2 "(2)" with column from index 1 to index 1.
We change only one value to Zero. And in our second iteration we call

 $a(1:2,(3));

Means in row 3 we change 2 values to Zero.

 foreach my $y (2..11) { 
 	$a(1:$e++,($y)) .= 0;               # Set "0" Zero to one Half.
 }

 [
  [  0   0   0   0   0   0   0   0   0   0   0   0]
  [  0   1   2   3   4   5   6   7   8   9  10  11]
  [  0   0   4   6   8  10  12  14  16  18  20  22]
  [  0   0   0   9  12  15  18  21  24  27  30  33]
  [  0   0   0   0  16  20  24  28  32  36  40  44]
  [  0   0   0   0   0  25  30  35  40  45  50  55]
  [  0   0   0   0   0   0  36  42  48  54  60  66]
  [  0   0   0   0   0   0   0  49  56  63  70  77]
  [  0   0   0   0   0   0   0   0  64  72  80  88]
  [  0   0   0   0   0   0   0   0   0  81  90  99]
  [  0   0   0   0   0   0   0   0   0   0 100 110]
  [  0   0   0   0   0   0   0   0   0   0   0 121]
 ]

Now we have set all our values properly, only we have some extra Zero
values in our Matrix. We saw already that we can exclude row 1 and
column 1 with our Slicing feature and could simply print it.

But Task #2 requires some special output formatting. This we will
do in a second step now.

=cut

# ------------------------------------------------------------------

sub output_pdl {      # Print PDL piddle
	my ($pdl) = @_;   # Input parameter is our Matrix $pdl
	my ($i,@a);       # Declaration of our 2 format Vars.

# ----- format function for output
format STDOUT_TOP =
   x|   1   2   3   4   5   6   7   8   9  10  11
 ---+--------------------------------------------
.
format STDOUT =
 @>>|@>>>@>>>@>>>@>>>@>>>@>>>@>>>@>>>@>>>@>>>@>>>
  $i, @a
.

	foreach $i (1..11) {                # iterate each row
		my @tmp = list $pdl(1:11,($i)); # extrace row piddle and convert to perl list.
		@a = map { $_==0?(" "):($_) } @tmp; # set zero values to empty string.
		write;                          # write format to stdout.
	}
}

=head2 Output of PDL Piddle with perl format

For the printing of the result we use the Perl format function.
Again a little bit more effort is needed to understand it than to 
simply use a C<print> or C<printf>, but not everything shall be easy.
The explanation of format is in C<perldoc -f format> or C<perldoc perlform>.

And we need the PDL Slicing again and also the PDL list() function to
create a perl array/list for printing.

The output_pdl() function looks like this:

 sub output_pdl {     # Print PDL piddle
	my ($pdl) = @_;   # Input parameter is our Matrix $pdl
	my ($i,@a);       # Declaration of our 2 format Vars.

 # ----- format function for output
 format STDOUT_TOP =
   x|   1   2   3   4   5   6   7   8   9  10  11
 ---+--------------------------------------------
 .
 format STDOUT =
 @>>|@>>>@>>>@>>>@>>>@>>>@>>>@>>>@>>>@>>>@>>>@>>>
  $i, @a
 .

	foreach $i (1..11) {                # iterate each row
		my @tmp = list $pdl(1:11,($i)); # extrace row piddle and convert to perl list.
		@a = map { $_==0?(" "):($_) } @tmp; # set zero values to empty string.
		write;                          # write format to stdout.
	}
 }

The format is defined in STDOUT_TOP, simply a string that is printed as header.
And format STDOUT with the Vars $i and @a, that is magically printing each line
to stdout with the C<write> statement.

Here we use the PDL Slicing feature to create each line:

 $pdl(1:11,($i));

And the PDL list function to convert it to a perl array:

 list $pdl(1:11,($i));

Afterwards we C<map> each Zero value to an empty string:

 @a = map { $_==0?(" "):($_) } @tmp;

So the resulting output looks exactly what was required in Task #2:

   x|   1   2   3   4   5   6   7   8   9  10  11
 ---+--------------------------------------------
   1|   1   2   3   4   5   6   7   8   9  10  11
   2|       4   6   8  10  12  14  16  18  20  22
   3|           9  12  15  18  21  24  27  30  33
   4|              16  20  24  28  32  36  40  44
   5|                  25  30  35  40  45  50  55
   6|                      36  42  48  54  60  66
   7|                          49  56  63  70  77
   8|                              64  72  80  88
   9|                                  81  90  99
  10|                                     100 110
  11|                                         121

=cut

# ------------------------------------------------------------------

=head1 Task #2: Some other Solutions

I created some other functions that solves Task #2 slightly different.

=over 3

=item * task2_slice()
 is printing the intermediate results of the
 multiplication, the slicing, the slices with zero values and
 the final result.

=item * task2_simple()
 is the most obvious solution that creates the matrix with
 two for loops and immediately prints the result.

=item * task2_create_array()
 is first creating an array and then using the function output_array()
 to print the array.

=back

=head2 task2_slice()

All the theory behing this code has already be explained in the previous chapters.

 sub task2_slice {
	my $n = 12;
	my $a  = xvals($n,$n) * yvals($n,$n);
	print $a;
	my $b = $a(1:11,1:11);
	print $b;

	my $e = 0;
	foreach my $y (1..10) { $b(0:$e++,($y)) .= 0; }
	print $b;
	output_pdl($a);
 }

=cut

sub task2_slice {
	my $n = 12;
	my $a  = xvals($n,$n) * yvals($n,$n);
	print $a;
	my $b = $a(1:11,1:11);
	print $b;

	my $e = 0;
	foreach my $y (1..10) { $b(0:$e++,($y)) .= 0; }
	print $b;
	output_pdl($a);
}

=head2 task2_simple()

In Task #2 Simple the whole task is solved in a rather simple perl way
with C<for> and C<printf>.

 sub task2_simple {
	print "   x|"; for(1..11) { printf("%4s",$_); } print "\n";
	print "----+"; for(1..11) { printf("%4s","----"); } print "\n";

	my $s = 1;
	for(my $x=1;$x<=11;$x++) {
		printf("%4s|",$x);
		for(my $y=1;$y<=11;$y++) {
			my $v = " ";
			if($y >= $s) { $v = $x * $y; }
			printf("%4s", $v);
		}
		$s++;
		print "\n";
	}
 }

=cut

sub task2_simple {
	print "   x|"; for(1..11) { printf("%4s",$_); } print "\n";
	print "----+"; for(1..11) { printf("%4s","----"); } print "\n";

	my $s = 1;
	for(my $x=1;$x<=11;$x++) {
		printf("%4s|",$x);
		for(my $y=1;$y<=11;$y++) {
			my $v = " ";
			if($y >= $s) { $v = $x * $y; }
			printf("%4s", $v);
		}
		$s++;
		print "\n";
	}
}

=head2 task2_create_array() and output_array()

This code I show here also without any further explanatios.
Only the array is calculated in the function C<task2_create_array()>
and returned as an array ref. So it can be further used.
The result is printed in C<output_array($aref)>. The function
takes the before created C<$aref>.

 sub task2_create_array {
	my @a;
	my $s = 0;                     # Counter to determine Zero Values
	for(my $x=0;$x<=10;$x++) {     # X-Value
		for(my $y=0;$y<=10;$y++) { # Y-Value
			my $v = 0;             # Resulting Multiplication
			if($y >= $s) {         # Determine Zero Values
				$v = ($x+1)*($y+1);# Multiplication
			}
			$a[$x][$y] = $v;       # Store Value in Array
		}
		$s++;                      # Increase of Non-Valid Counter
	}
	return \@a;
 }

 sub output_array {
	my ($aref) = @_;
	print "   x|"; for(1..11) { printf("%4s",$_); } print "\n";
	print "----+"; for(1..11) { printf("%4s","----"); } print "\n";

	my $row = 1;
	foreach my $x (@$aref) {
		printf("%4s|",$row++);
		foreach my $y (@$x) {
			my $v = " ";
			if($y) { $v = $y; }
			printf("%4s", $v);
		}
		print "\n";
	}
 }

=cut

sub task2_create_array {
	my @a;
	my $s = 0;                     # Counter to determine Zero Values
	for(my $x=0;$x<=10;$x++) {     # X-Value
		for(my $y=0;$y<=10;$y++) { # Y-Value
			my $v = 0;             # Resulting Multiplication
			if($y >= $s) {         # Determine Zero Values
				$v = ($x+1)*($y+1);# Multiplication
			}
			$a[$x][$y] = $v;       # Store Value in Array
		}
		$s++;                      # Increase of Non-Valid Counter
	}
	return \@a;
}

sub output_array {
	my ($aref) = @_;
	print "   x|"; for(1..11) { printf("%4s",$_); } print "\n";
	print "----+"; for(1..11) { printf("%4s","----"); } print "\n";

	my $row = 1;
	foreach my $x (@$aref) {
		printf("%4s|",$row++);
		foreach my $y (@$x) {
			my $v = " ";
			if($y) { $v = $y; }
			printf("%4s", $v);
		}
		print "\n";
	}
}

# ======================= Main Program ================================

# ----------------- Global Vars -----------------

# ----------------- Main program -----------------
print "ch-2.pl (Version 1.0) PWC #33 Task #2: ";

my $command = shift @ARGV;		# Read command

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
elsif($command eq "task2") { 
	print "Task #2\n";
	my $opts = options();
	if($opts->{array}) {
		my $aref = task2_create_array(); 
		output_array($aref);
	}
	elsif($opts->{simple}) {
		task2_simple(); 
	}
	elsif($opts->{pdl}) {
		task2_pdl(); 
	}
	elsif($opts->{slice}) {
		task2_slice(); 
	}
	else { task2_pdl(); }
}

# -- Options for "simple" command

sub options {
	my %opts = ( array => 0, simple => 0, pdl => 0, slice => 0 );
	my $o = GetOptions ( # Read options
		"array"  => \$opts{array},
		"simple" => \$opts{simple},
		"pdl"    => \$opts{pdl},
		"slice"  => \$opts{slice}, 
	);		
	if(!$o) { usage(); die("Error in command line arguments.\n"); }
	return \%opts;
}

# ================================ Usage ============================
sub usage {
	print "./ch-2.pl [<command>] [<options>]\n";
	print "\n";
	print "   command, help|html|task2 \n";
	print "      help,  Prints out some usage information.\n";
	print "      html,  Writes HTML and CSS from POD.\n";
	print "      task2, Solution for Task #2 (Default PDL). \n";
	print "   options:\n";
	print "      --pdl,    Task #2 PDL solution.\n";
	print "      --array,  Task #2 Array solution.\n";
	print "      --simple, Task #2 Simple solution.\n";
	print "      --slice,  Task #2 Slice solution.\n";
	print "\n";
	print "   Examples:\n";
	print "      # perldoc ch-2.pl\n";
	print "      # ./ch-2.pl help\n";
	print "      # ./ch-2.pl html\n";
	print "      # ./ch-2.pl task2\n";
	print "      # ./ch-2.pl task2 -p\n";
	print "      # ./ch-2.pl task2 --pdl\n";
	print "      # ./ch-2.pl task2 --array\n";
	print "      # ./ch-2.pl task2 --simple\n";
	print "      # ./ch-2.pl task2 --slice\n";
}

sub html {
	# ------------- Create HTML --------------
	qx[ pod2html --header --title \"Perl Weekly Challenge #33 Task #2, Multiplication Table\" --css \"pwc.css\" ch-2.pl > ch-2.html ];

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


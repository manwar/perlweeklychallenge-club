#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use Term::Size::Perl qw(chars pixels);

=head1 Perl Weekly Challenge #32

This week PWC shall count the number of occurence of terms in a list
and in Task #1 print the result to STDOUT.
Than in Task #2 a bar graph of the number shall be printed.

For both I created a simple solution in one function. For task #1 I
also showed a one-liner.

Then I saw it as one solution with different input, different sorting
and also different output methods:

=over 3

=item * Input: Files or STDIN.

=item * Sorting: Unsorted or per Name or Value.

=item * Output: And/Or List, CSV, Bar, Percentage.

=back

=begin html

<b>Download File:</b><a href="pwc32.pl" download>Solution PWC #32 pwc32.pl</a>

=end html

=head1 SYNOPSIS

 # perldoc pwc32.pl    	- POD
 # ./pwc32.pl html    	- HTML/CSS in pwc32.html/pwc32.css
 # ./pwc32.pl help    	- Usage information

 ./pwc32.pl <command> [<options>] [<files>]

  command, help|html|task1|task2|simple
     help, prints out some usage information.
     html, writes HTML and CSS from POD to pwc32.html and pwc32.css.
     task1, solution for task #1, reads from only one file.
     task2, solution for task #2, reads from only one file.
     simple, actual solution for task #1 and #2.
  options, control over simple solution.
     --sort=name|value, sorting of name, value or unsorted (default).
     --list, output in list form.
     --csv, output in CSV format.
     --bar, output in bar form.
     --pct, output in bar form with percentage.
  files, list of filenames with items.
     if no files are given, command line allows typing items.
     command line can be used several times to add items.
     command line can be aborted with <ctrl>-c.

  Examples:
     # ./pwc32.pl help
     # ./pwc32.pl html
     # ./pwc32.pl task1 example.txt
     # ./pwc32.pl task2 example.txt
     # ./pwc32.pl simple -b -l -c -p example.txt
     # ./pwc32.pl simple -bar -list -csv -pct example.txt
     # ./pwc32.pl simple --bar --list --csv --pct example.txt
     # ./pwc32.pl simple -p example.txt example.txt
     # ./pwc32.pl simple -p

=cut

# ====================== TASK 1 ==============================

=head1 Definition Task #1: Count number of occurence of items

Create a script that either reads standard input or one or more files specified
on the command-line. Count the number of times and then print a summary, sorted
by the count of each entry.

So with the following input in file example.txt

 apple
 banana
 apple
 cherry
 cherry
 apple

the script would display something like:

 apple     3
 cherry    2
 banana    1

For extra credit, add a -csv option to your script, which would generate:

 apple,3
 cherry,2
 banana,1

=cut

# ====================== TASK 2 ==============================

=head1 Definition Task #2: ASCII bar chart

Write a function that takes a hashref where the keys are labels and the values are
integer or floating point values. Generate a bar graph of the data and display it to stdout.

The input could be something like:

 $data = { apple => 3, cherry => 2, banana => 1 };
 generate_bar_graph($data);

And would then generate something like this:

 apple  | ############
 cherry | ########
 banana | ####

If you fancy then please try this as well:
(a) the function could let you specify whether the chart should be ordered by
(1) the labels, or (2) the values.

=cut


# ====================== Simple Solution TASK 1 ==============================

sub task1_simple {
    my ($file) = @_;
    my %sum;
    open(my $fh,$file) or die "Cant open $file!\n";
    my @items = <$fh>;
    close $fh;
    foreach my $i (@items) { chomp $i; $sum{$i}++; }
    my @sorted = sort { $sum{$b} <=> $sum{$a} } keys %sum;
    foreach my $i (@sorted) { print "$i\t$sum{$i}\n"; }
}

sub task1_one_liner {
    my ($file) = @_;
    qx[ perl -lne '\$sum{\$_}++; END { foreach( sort { \$sum{\$b} <=> \$sum{\$a} } keys %sum ) { print "\$i\t\$sum{\$i}"; } }' $file ];
}

=head1 Solution Task #1:

=head2 Simple solution

In the first simple solution the content of the file is read into an array.
Each string is made a hash key with increased value for every occurence.
Than the hash key is sorted with the sort() function dependant on the value
and each element is printed according to the sorted keys.

Read Filename from Arg, open file and read content to array:

 my $file = shift @ARGV or die "No file given!\n";
 open(my $fh,"$file") or die "Cant open $file!\n";
 my @items = <$fh>;
 close $fh;

Loop over all read items and create hash with item as key and value
as number of occurence:

 my %sum;
 foreach my $i (@items) { chomp $i; $sum{$i}++; }

Sort keys of hash according to values of hash with sort() function:

 my @sorted = sort { $sum{$b} <=> $sum{$a} } keys %sum;

Print each key/value of hash according to sorted keys array:

 foreach my $i (@sorted) { print "$i\t$sum{$i}\n"; }

The first simple solution for Task #1 is executed with the following command.

 # ./pwc32.pl task1 example.txt
 apple    3
 cherry    2
 banana    1

=head2 As one-liner

This whole thing, explained above, can be changed into an one-liner for the command line:

 perl -lne '$sum{$_}++; END { foreach( sort { $sum{$b} <=> $sum{$a} } keys %sum ) { print "$i\t$sum{$i}"; } }' example.txt

The options C<-lne> are documented in C<perldoc perlrun>.

=over 2

=item * -l automatically chomps the input separator when used together with -n or -p. And adds the output separator to each print statement.

=item * -n iterates with a loop over the content of the given file.

=item * -e executes the following perl commands.

=back

=cut

# ====================== Simple Solution TASK 1 ==============================

sub task2_simple {
    my ($file) = @_;
    my %sum;
    open(my $fh,$file) or die "Cant open $file!\n";
    my @items = <$fh>;
    close $fh;
    foreach my $i (@items) { chomp $i; $sum{$i}++; }
    my @sorted = sort { $sum{$b} <=> $sum{$a} } keys %sum;
    foreach my $i (@sorted) { printf("%10s: %s\n", $i, "#" x $sum{$i}); }
}

=head1 Solution Task #2: Simple solution

The solution for Task #2 in one function is similar to the solution for
Task #1. Only that the output is printing a bar.

 printf("%10s: %s\n", $i, "#" x $sum{$i});

The "x" Operator is used to print a number of "#" hash signs. For the output
the printf() functions is used, because it allows to specify the length of
each printed string.

The whole function with reading file, calculating the sum, sorting the values
and printing the sorted list is as follows:

 sub task2_simple {
    my ($file) = @_;
    my %sum;
    open(my $fh,$file) or die "Cant open $file!\n";
    my @items = <$fh>;
    close $fh;
    foreach my $i (@items) { chomp $i; $sum{$i}++; }
    my @sorted = sort { $sum{$b} <=> $sum{$a} } keys %sum;
    foreach my $i (@sorted) { printf("%10s: %s\n", $i, "#" x $sum{$i}); }
 }

The Task #2 can be executed with the following command:

 # ./pwc32.pl task2 example.txt
     apple: ###
    cherry: ##
    banana: #

=head1 Solution Task #1/#2: Different Input, Sorting, Output

In our comprehensive solution we put together the different ways for
input (STDIN and Files), sorting (unsorted, name or value) and output
(list, csv, bar, percentage).

All this needs a more comprehensive main program, that evaluates the
options and calls the necessary functions according to the options.

Some extracts from the main program:

=over 3

=item * Read first option, the command from argument array @ARGV.

 my $command = shift @ARGV;    	# Read command

=item * Read further options for sorting and output with module Getopt::Long.

 my %opts = ( sort => "", list => 0, bar => 0, csv => 0 );
 my $o = GetOptions ( # Read options
    "sort=s" => \$opts{sort},
    "list"   => \$opts{list},
    "bar"    => \$opts{bar},
    "csv"    => \$opts{csv},
    "pct"    => \$opts{pct},
 );
 if(!$o) { usage(); die("Error in command line arguments.\n"); }

=item * For command "simple", do either File input or STDIN input. Then call the
functions to calculate the sum, sort the list and print to stdout. The functions
are explained below in details.

 if($command eq "simple") {     # Read from one or more Files
    if( $ARGV[0] and -f $ARGV[0] ) {
    	my $items = read_files();
    	sum_up($items);			# Calculate Sum of items
    	sorting($opts{sort});	# Sort items: name, value or unsorted
    	output(\%opts);			# Output items: list, csv, bar, percentage
    }
    else {
    	while(1) {						# Command line loop
    		my $list = readstdin();		# Read from STDIN
    		next if ! $list;
    		sum_up($list);				# Calculate Sum of items
    		sorting($opts{sort});		# Sort items: name, value or unsorted
    		output(\%opts);				# Output items: list, csv, bar, percentage
    	}
    }
 }

=back

=cut

# ======================= Main Program ================================

# ----------------- Global Vars -----------------
my %sum;    # Hash for sum of items
my %pct;    # Hash for percentage values
my %blk;    # Hash for number of blocks in bar
my @sorted;    # Sorted array of Hash Keys
my $separator;    # Separator for "list" (\t) or "csv" (,).
my $max;    	# Max Value for percentage bar, calculated from Term width.

# ----------------- Main program -----------------
print "pwc32.pl (Version 1.0): List number of items.\n";

my $command = shift @ARGV;    	# Read command

# -- Verify file for 3 simple commands "one", "task1" and "task2"
if($command eq "one" or $command eq "task1" or $command eq "task2") {
    if(! $ARGV[0]) { die "Error: Missing file name!\n"; }
    if(! -f $ARGV[0]) { die "Error: File does not exist $ARGV[0]!\n"; }
}

# -- Execution of simple commands -----------------
if(! $command) { usage(); exit 0; }    			# if no command print usage
elsif($command eq "html") { html(); exit 0; }    # if command html or help
elsif($command eq "help") { usage(); exit 0; }

# -- Simple commands with one file as arg ----------
elsif($command eq "one") { task1_one_liner($ARGV[0]); exit 0; }
elsif($command eq "task1") { task1_simple($ARGV[0]); exit 0; }
elsif($command eq "task2") { task2_simple($ARGV[0]); exit 0; }

# -- Options for "simple" command
my %opts = ( sort => "", list => 0, bar => 0, csv => 0 );
my $o = GetOptions ( # Read options
    "sort=s" => \$opts{sort},
    "list"   => \$opts{list},
    "bar"    => \$opts{bar},
    "csv"    => \$opts{csv},
    "pct"    => \$opts{pct},
);
if(!$o) { usage(); die("Error in command line arguments.\n"); }

# -- "simple" command with different input, sorting and output.
if($command eq "simple") {     # Read from one or more Files
    if( $ARGV[0] and -f $ARGV[0] ) {
    	my $items = read_files();
    	sum_up($items);			# Calculate Sum of items
    	sorting($opts{sort});	# Sort items: name, value or unsorted
    	output(\%opts);			# Output items: list, csv, bar, percentage
    }
    else {
    	while(1) {						# Command line loop
    		my $list = readstdin();		# Read from STDIN
    		next if ! $list;
    		sum_up($list);				# Calculate Sum of items
    		sorting($opts{sort});		# Sort items: name, value or unsorted
    		output(\%opts);				# Output items: list, csv, bar, percentage
    	}
    }
}

# ======================= Input of Item List =====================

=head1 Input of Item List

Two different ways of input is required. First input from one or more
files and second input from STDIN. I created 3 function for the input.

=head2 readstdin()

In the redstdin() function a list is typed on the command line.
The list is splitted with the split() function into an array.
An array ref from the list is returned.

 sub readstdin {
    print "Type list (Ctrl-c)> ";		# Print prompt
    my $read = <STDIN>;					# Read from stdin
    chomp($read);						# Eleminate Newline
    my @list = split(" ",$read);		# Create Array
    return \@list;						# Return Items
 }

=head2 read_files()

The rest of the command line arguments array @ARGV is iterated in
a while loop. Each file is read with the read_file() function. Than
the items are pushed to the @items array. An array ref of the @items
is returned.

 sub read_files {
    my @items;
    while( my $file = shift @ARGV ) {	# Iterate @ARGV
    	my $i = read_file($file);		# Read each file
    	push(@items,@$i);				# Push to Items.
    }
    return \@items;                     # Return Items
 }

=head2 read_file()

The input argument is one filename. The file is opened, read at once
into an array, closed. Than the Items are returned.

 sub read_file {
    my ($file) = @_;                                   # IN: Filename
    open(my $fh,"$file") or die "Cant open $file!\n";  # Open file
    my @items = <$fh>;                                 # Read whole file in array
    close $fh;                                         # Close file
    return \@items;                                    # Return Items
 }

=cut

# --- Read from STDIN a list of items and return an array ref of the items
sub readstdin {
    print "Type list (Ctrl-c)> ";		# Print prompt
    my $read = <STDIN>; 				# Read stdin
    chomp($read);						# Eleminate Newline
    my @list = split(" ",$read);		# Split List
    return \@list;						# Return Items
}
# --- Read from a list of files
sub read_files {
    my @items;
    while( my $file = shift @ARGV ) {	# Iterate @ARGV
    	my $i = read_file($file);		# Read each file
    	push(@items,@$i);				# Push Items to Array
    }
    return \@items;						# Return Items.
}
# --- Read from one file
sub read_file {
    my ($file) = @_;        # IN: Filename
    open(my $fh,"$file") or die "Cant open $file!\n"; # Open file
    my @items = <$fh>;      # Read whole file in array
    close $fh;              # Close file
    return \@items;         # Return Items
}

# ====================== Calculate the Sum ==============================

=head1 Calculate the Sum

The number of occurences of each item is calculated with an iteration
over each item and incrementing a counter for each item.

=head2 sum_up($items)

The iteration is done with a foreach loop. Than each hash element of
%sum is incremented.

 sub sum_up {
    my ($items) = @_;
    foreach my $i (@$items) { chomp $i; $sum{$i}++; }
 }

=cut

# ----------------------------------------------------------

sub sum_up {
    my ($items) = @_;
    foreach my $i (@$items) { chomp $i; $sum{$i}++; }
}

# ======================= Sorting of Item List =====================

=head1 Sorting of Item List

The Item list can be sorted with the C<--sort=name|value> option.
When the option is not given than an unsorted list is printed.

=head2 sorting($sort)

The $sort option can be "name" or "value" or the list is unsorted.
The sorting is done with the C<sort()> function.

 @sorted = keys %sum;

Only the keys of the %sum hash are assigned to the @sorted array.

 @sorted = sort keys %sum;

The keys of the %sum hash are alphabetically sorted with the sort function.

 @sorted = sort { $sum{$b} <=> $sum{$a} } keys %sum;

The values of the %sum hash are sorted with the sort function. For details
on the sort function see C<perldoc -f sort>.

The sorting() function is doing the sort according to the given option.

 sub sorting {
    my ($sort) = @_; # "name|value" default "unsorted"

    if($sort eq "name") {
    	@sorted = sort keys %sum;
    }
    elsif($sort eq "value") {
    	@sorted = sort { $sum{$b} <=> $sum{$a} } keys %sum;
    }
    else {
    	@sorted = keys %sum;
    }
 }

=cut

sub sorting {
    my ($sort) = @_; # "name|value" default "unsorted"

    if($sort eq "name") {
    	@sorted = sort keys %sum;
    }
    elsif($sort eq "value") {
    	@sorted = sort { $sum{$b} <=> $sum{$a} } keys %sum;
    }
    else {
    	@sorted = keys %sum;
    }
}

# ======================= Output of Item List =====================

=head1 Output of Item List

For the output four different lists are possible:

=over 3

=item * List of items and numbers separated by TABS.

=item * List of items and numbers as CSV.

=item * List of items with Bars.

=item * List of items with Bars in Percentage Values.

=back

=head2 output($options)

According to the options C<--list>, C<--csv>, C<--bar> and C<--pct> the
lists are printed. All lists can be printed when all options are set.
If none of the options is set than the default list is printed.

 sub output {
    my ($o) = @_;	# IN: Option Hash Ref: \%opts

    if($o->{bar}) { print_bar(); }
    if($o->{pct}) { calculate_pct(); print_pct(); }
    if($o->{list}) { $separator = "\t"; print_list(); }
    if($o->{csv})  { $separator = ",";  print_list(); }
    if(!$o->{list} and !$o->{bar} and !$o->{csv} and !$o->{pct}) {
    	$separator = "\t"; print_list();
    }
 }

=head2 print_bar()

Prints an ascii bar according to a sorted list. The C<x> Operator is used
to print a "#" hash char for each value of each items sum.

 sub print_bar {
    foreach my $i (@sorted) { printf("%10s: %s\n", $i, "#" x $sum{$i}); }
 }

=head2 print_list()

Prints a list of items according to a sorted list.

 sub print_list {
    foreach my $i (@sorted) { print "$i$separator$sum{$i}\n"; }
 }

=head2 print_pct()

Prints a bar with percentage values according to a sorted list.
@sorted contains a sorted list of items, %sum contains the sum
of each item, %pct contains each percentage value, %blk contains
each length of the bar.

 sub print_pct {
    foreach my $i (@sorted) {
    	printf("%-10s (%2d): %-${max}s| %3.2f %%\n", $i,
    		$sum{$i}, ('#' x $blk{$i}), $pct{$i});
    }
 }

=head2 calculate_pct()

Calculates a percentage value of each item. The sum of all items
is 100%, this value is stored in the hash %pct. Also the width of
the terminal is determined with module Term::Size::Perl and function
chars() that returns the width of the terminal. The width is used
to adapt the blocks to the available width, this is stored in Hash %blk.

 sub calculate_pct {
    my $s;                        # Sum of all items
    foreach my $i (keys %sum) { $s += $sum{$i}; }
    my $width = chars();          # Width of terminal
    $max = int($width/2);         # Max is half of terminal width
    foreach my $i (keys %sum) {   # Calculate each percentage value
    	$pct{$i} = $sum{$i} * 100 / $s;
    	$blk{$i} = int( $sum{$i} * $max / $s );
    }
 }

=cut

sub output {
    my ($o) = @_;	# IN: Option Hash Ref: \%opts

    if($o->{bar}) { print_bar(); }
    if($o->{pct}) { calculate_pct(); print_pct(); }
    if($o->{list}) { $separator = "\t"; print_list(); }
    if($o->{csv})  { $separator = ",";  print_list(); }
    if(!$o->{list} and !$o->{bar} and !$o->{csv} and !$o->{pct}) {
    	$separator = "\t"; print_list();
    }
}

sub print_bar {
    foreach my $i (@sorted) { printf("%10s: %s\n", $i, "#" x $sum{$i}); }
}
sub print_list {
    foreach my $i (@sorted) { print "$i$separator$sum{$i}\n"; }
}
sub print_pct {
    foreach my $i (@sorted) {
    	printf("%-10s (%2d): %-${max}s| %3.2f %%\n", $i,
    		$sum{$i}, ('#' x $blk{$i}), $pct{$i});
    }
}

sub calculate_pct {
    my $s;
    foreach my $i (keys %sum) { $s += $sum{$i}; } # Sum of all items
    my $width = term_size(); # Width of terminal
    $max = int($width/2);    # Max is half width
    foreach my $i (keys %sum) {
    	$pct{$i} = $sum{$i} * 100 / $s; # Calculate each percentage value
    	$blk{$i} = int( $sum{$i} * $max / $s ); # Calculate each number blocks
    }
    # print "DEBUG: Sum $s, Max $max, Width $width\n";
}

sub term_size { # Return width of terminal with module Term::Size::Perl chars() function
    my $width   = chars();
    my ($c, $r) = Term::Size::Perl::chars;
    my ($x, $y) = Term::Size::Perl::pixels;
    # print "Term Size: $width, $c, $r ($x, $y)\n";
    return $width;
}

# ================================ Usage ============================
sub usage {
    print "./pwc32.pl <command> [<options>] [<files>]\n";
    print "\n";
    print "   command, help|html|task1|task2|simple \n";
    print "      help, prints out some usage information.\n";
    print "      html, writes HTML and CSS from POD to pwc32.html and pwc32.css.\n";
    print "      task1, solution for task #1, reads from only one file.\n";
    print "      task2, solution for task #2, reads from only one file.\n";
    print "      simple, \n";
    print "   options, control over simple solution.\n";
    print "      --sort=name|value, sorting of name, value or unsorted (default).\n";
    print "      --list, output in list form.\n";
    print "      --csv, output in CSV format.\n";
    print "      --bar, output in bar form.\n";
    print "      --pct, output in bar form with percentage.\n";
    print "   files, list of filenames with items.\n";
    print "      if no files are given, command line allows typing items.\n";
    print "      command line can be used several times to add items.\n";
    print "      command line can be aborted with <ctrl>-c.\n";
    print "\n";
    print "   Examples:\n";
    print "      # ./pwc32.pl help\n";
    print "      # ./pwc32.pl html\n";
    print "      # ./pwc32.pl task1 example.txt\n";
    print "      # ./pwc32.pl task2 example.txt\n";
    print "      # ./pwc32.pl simple -b -l -c -p example.txt\n";
    print "      # ./pwc32.pl simple -bar -list -csv -pct example.txt\n";
    print "      # ./pwc32.pl simple --bar --list --csv --pct example.txt\n";
    print "      # ./pwc32.pl simple -p example.txt example.txt\n";
    print "      # ./pwc32.pl simple -p\n";
}

sub html {
    # ------------- Create HTML --------------
    qx[ pod2html --header --title \"Perl Weekly Challenge #32, Number of occurences and bar chart\" --css \"pwc32.css\" pwc32.pl > pwc32.html ];

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

    open(CSS, ">pwc32.css") or die "Cant open pwc32.css!\n";
    print CSS $CSS;
    close CSS;
}

=head1 AUTHOR

Chuck

=cut

# ############################## END #############################################


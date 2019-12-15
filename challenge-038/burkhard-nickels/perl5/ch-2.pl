#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper qw(Dumper);
$Data::Dumper::Indent=0;

=head1 Perl Weekly Challenge #38 Task #2: Word Game

In the "Word Game" a word shall be created out of 7 letters. Every letter
used, gets points. You should find the word that creates the most points.

The program initializes a Hash with all letters, the number of letters in the Lot
and the point for each letter. First the Lot of all available letters is created
in an Array. Then randomly 7 letters are drawn from the Lot. 

From Command Line Input you shall type a word out of these 7 letters and the
points you get for the word are calculated.

The intention was to use a dictionary to verify the word and to find the word
with the most points out of this dictionary. I tried it with the Perl Module
Lingua::FreeLing3. Unfortunately I was not able to make it running.

On the "Freeling" website was version 4 of Freeling available, version 3 was not
available anymore. I installed version 4, but
I was not able to install the perl module "Lingua::FreeLing3" in my short time
I had for this task. So this is some
negative example of using a perl module with dependencies. 
I would need some more time to make it
running with a dictionary.

The module Data::Dumper is used for Debugging purposes.

=over 3

=item * Lingua::FreeLing3

=item * Data::Dumper

=back


=begin html

<h2> Download and References </h2>
<b>Download File:</b><a href="ch-1.pl" download>Solution PWC #38 Task #1 ch-1.pl</a><br>
<b>Download File:</b><a href="ch-2.pl" download>Solution PWC #38 Task #2 ch-2.pl</a><br>
<br>


FreeLing Homepage:<br>
<a target=_blank href="http://nlp.lsi.upc.edu/freeling/">http://nlp.lsi.upc.edu/freeling/</a>
<br>

FreeLing 4.1 User Manual:
<br>
<a target=_blank href="https://freeling-user-manual.readthedocs.io/en/v4.1/">
https://freeling-user-manual.readthedocs.io/en/v4.1/
</a>
<br>

FreeLing 4.1 Download on Github:
<br>
<a target=_blank href="https://github.com/TALP-UPC/FreeLing/releases">
https://github.com/TALP-UPC/FreeLing/releases
</a>
<br>

=end html

=head2 Install FreeLing

For the verification of the typed word, I will try to use the FreeLing Dictionary.
So it is only allowed to use words out of this Dictionary. Following is the installation
of the necessary Librarys and Perl Modules.

 Install with Synaptic:
   libboost-program-options1.62.0
   libboost-regex1.62.0

 # dpkg -i freeling-4.1-stretch-amd64.deb 
 Vormals nicht ausgewaehltes Paket freeling wird gewaehlt.
 (Lese Datenbank ... 170719 Dateien und Verzeichnisse sind derzeit installiert.)
 Vorbereitung zum Entpacken von freeling-4.1-stretch-amd64.deb ...
 Entpacken von freeling (4.1) ...
 freeling (4.1) wird eingerichtet ...

 # cpan
 cpan> install Lingua::FreeLing3

=head1 SYNOPSIS

 # perldoc ch-2.pl		- POD
 ./ch-2.pl <command|string> [string]
 # ./ch-2.pl html		- HTML/CSS in ch-2.html/pwc.css
 # ./ch-2.pl help		- Usage information

 # ./ch-2.pl
 ch-2.pl (Version 1.0) PWC #38 Task #2: Word Game
 type your word from 'bfigsaf' (or exit)> fig
 Word: 'fig', Points 5
 type your word from 'bfigsaf' (or exit)> hello
 Word: 'hello' NOT in 'bfigsaf'!
 type your word from 'bfigsaf' (or exit)> exit


=head1 Main program

 use strict;
 use warnings;
 use Data::Dumper qw(Dumper);
 $Data::Dumper::Indent=0;

 my (%T,@Lot,@Items);    # Tiles, Lot
 init();
 @Items = draw();
 input();

=cut

my (%T,@Lot,@Items);    # Tiles, Lot

my $cmd = shift @ARGV;		# Read command or text string
print "ch-2.pl (Version 1.0) PWC #38 Task #2: Word Game\n";
if(!$cmd) { $cmd = ""; }
if($cmd eq "html") { html(); exit 0; }
elsif($cmd eq "help") { usage(); exit 0; }
else {
	init();
	@Items = draw();
	input();
}

# ====================== TASK 2 ==============================

=head1 Definition Task #2: Word Game

Lets assume we have tiles as listed below, with an alphabet (A..Z) printed on them. 
Each tile has a value, e.g. A (1 point), B (4 points) etc. You are allowed to 
draw 7 tiles from the lot randomly. Then try to form a word using the 7 tiles with 
maximum points altogether. You don't have to use all the 7 tiles to make a word. 
You should try to use as many tiles as possible to get the maximum points.

For example, A (x8) means there are 8 tiles with letter A.
 1 point

    A (x8), G (x3), I (x5), S (x7), U (x5), X (x2), Z (x5)

 2 points

    E (x9), J (x3), L (x3), R (x3), V (x3), Y (x5)

 3 points

    F (x3), D (x3), P (x5), W (x5)

 4 points

    B (x5), N (x4)

 5 points

    T (x5), O (x3), H (x3), M (x4), C (x4)

 10 points

    K (x2), Q (x2)


=cut

# ====================== TASK 2 ==============================

=head1 Functions

=head2 init()

Creates a lot of tiles.

First a hash of the Lot data, with number of letters and points of each letter
is initialized, then an ARRAY C<@Lot> of all letters in the lot is created.

 sub init {
  %T = ( # Initializes the alphabet with number and points per letter.
    a => [8,1], b => [5,4], c => [4,5], d => [3,3], e => [9,2], f => [3,3], 
    g => [3,1], h => [3,5], i => [5,1], j => [3,2], k => [2,10], l => [3,2], 
    m => [4,5], n => [4,4], o => [3,5], p => [5,3], q => [2,10], r => [3,2], 
    s => [7,1], t => [5,5], u => [5,1], v => [3,2], w => [5,3], x => [2,1], 
    y => [3,2], z => [5,1], 
  );
  foreach my $e (keys %T) {  # Creates the "Lot" according to the number
    my $nr = $T{$e}[0];
    for(my $i=1; $i<=$nr; $i++) {
      push(@Lot,$e);
    }
  }
 }

=cut

sub init {
  %T = ( # Initializes the alphabet with number and points per letter.
    a => [8,1], b => [5,4], c => [4,5], d => [3,3], e => [9,2], f => [3,3], 
    g => [3,1], h => [3,5], i => [5,1], j => [3,2], k => [2,10], l => [3,2], 
    m => [4,5], n => [4,4], o => [3,5], p => [5,3], q => [2,10], r => [3,2], 
    s => [7,1], t => [5,5], u => [5,1], v => [3,2], w => [5,3], x => [2,1], 
    y => [3,2], z => [5,1], 
  );
  foreach my $e (keys %T) {  # Creates the "Lot" according to the number
    my $nr = $T{$e}[0];
    for(my $i=1; $i<=$nr; $i++) {
      push(@Lot,$e);
    }
  }
}


=head2 @tiles = draw($lot)

Draws 7 items randomly from the lot.

Here the C<splice()> function is used to delete the item from the Lot, because
other functions (undef, delete) only mark the item as C<undef>. C<splice> really
deletes the item and reduces the length of the array.

 sub draw {
  my @Items;
  for(my $i=0; $i<7;$i++) {  # Draw 7 items from Lot
    my $nr = $#Lot;          # Length of Lot
	my $element = int(rand($nr));  # Random Number of Lot
    push(@Items, splice(@Lot, $element, 1)); # Push Item to Items and delete from Lot
  }
  return @Items; # Return list of drawn items.
 }

=cut

sub draw {
  my @Items;
  for(my $i=0; $i<7;$i++) {  # Draw 7 items from Lot
    my $nr = $#Lot;          # Length of Lot
	my $element = int(rand($nr));  # Random Number of Lot
    push(@Items, splice(@Lot, $element, 1)); # Push Item to Items and delete from Lot
  }
  return @Items; # Return list of drawn items.
}

=head2 input()

The function C<input()> reads a word from STDIN. When the word is within the
items the achieved Points are printed. The program loop can be exited when
B<exit> is typed.

 sub input {
  # --------------- Prompt -------------
  my $read = "";
  my $letters = join("",@Items);
  while($read ne "exit") {
    print "type your word from '$letters' (or exit)> ";           # print prompt
    $read = <STDIN>; chomp($read);
    next if !$read or $read eq "exit";
    if(verify_input($read,@Items)) {
      my $pts = count_points($read);
      print "Word: '$read', Points $pts\n";
    }
    else {
      print "Word: '$read' NOT in '$letters'!\n";
    }
  }
 }

=cut

sub input {
  # --------------- Prompt -------------
  my $read = "";
  my $letters = join("",@Items);
  while($read ne "exit") {
    print "type your word from '$letters' (or exit)> ";           # print prompt
    $read = <STDIN>; chomp($read);
    next if !$read or $read eq "exit";
    if(verify_input($read,@Items)) {
      my $pts = count_points($read);
      print "Word: '$read', Points $pts\n";
    }
    else {
      print "Word: '$read' NOT in '$letters'!\n";
    }
  }
}

=head2 $ok = verify_input($word, @Items)

The function C<verify_input()> verifies if the choosen word C<$word> is in
the 7 letters of C<@Items>. Returns "1" if it is included.

 sub verify_input {
  my ($word,@items) = @_;
  my @le = split("",$word);
  my $ok = 0;
  foreach my $l (@le) {
    for( my $i=0; $i<=$#items; $i++ ) {
      if($items[$i] eq $l) { splice(@items, $i, 1); $ok = 1; }
    }
  }
  return $ok;
 }

=cut

sub verify_input {
  my ($word,@items) = @_;
  my @le = split("",$word);
  my $ok = 0;
  foreach my $l (@le) {
    for( my $i=0; $i<=$#items; $i++ ) {
      if($items[$i] eq $l) { splice(@items, $i, 1); $ok = 1; }
    }
  }
  return $ok;
}

=head2 $sum = count_points($word)

The function C<count_points()> returns the achieved Points of the word C<$word>.
The points are returned.

 sub count_points {
  my ($word) = @_;
  my $sum = 0;
  my @le = split("",$word);
  foreach my $l (@le) {
    $sum += $T{$l}[1];
  }
  return $sum;
 }

=cut

sub count_points {
  my ($word) = @_;
  my $sum = 0;
  my @le = split("",$word);
  foreach my $l (@le) {
    $sum += $T{$l}[1];
  }
  return $sum;
}


# ================================ Usage ============================
sub usage {
	print "./ch-2.pl <command|string>\n";
	print "\n";
	print "   command, html|help\n";
	print "      help,  Prints out some usage information.\n";
	print "      html,  Writes HTML and CSS from POD.\n";
	print "\n";
	print "   Examples:\n";
	print "      # perldoc ch-2.pl\n";
	print "      # ./ch-2.pl help\n";
	print "      # ./ch-2.pl html\n";
}

sub html {
	# ------------- Create HTML --------------
	qx[ pod2html --header --title \"Perl Weekly Challenge #38 Task #2, Word Game\" --css \"pwc.css\" ch-2.pl > ch-2.html ];

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


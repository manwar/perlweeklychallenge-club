#!/usr/bin/perl

use strict;
use warnings;
use Box::Calc;
use Data::Dumper qw(Dumper);
use Tie::IxHash;
use Algorithm::Knapsack;

=head1 Perl Weekly Challenge #36 Task #2: Solve Knapsack Problem

For the Knapsack Problem exists Modules on cpan.org. So I will try to
solve it with the help of these Modules.

=over 3

=item * Module Box::Calc - does not solve our problem

=item * Algorithm::Knapsack - does not solve our problem

=item * PI, Profitabilitaetsindex, with Tie::IxHash - OK

=back


=begin html

<h2> Download and References </h2>
<b>Download File:</b><a href="ch-1.pl" download>Solution PWC #36 Task #1 ch-1.pl</a><br>
<b>Download File:</b><a href="ch-2.pl" download>Solution PWC #36 Task #2 ch-2.pl</a><br>
<br>
<a target=_blank href="https://de.wikipedia.org/wiki/Rucksackproblem">https://de.wikipedia.org/wiki/Rucksackproblem</a>

=end html

=head1 SYNOPSIS

 # perldoc ch-2.pl		- POD
 ./ch-2.pl <command>
 # ./ch-2.pl html		- HTML/CSS in ch-2.html/pwc.css
 # ./ch-2.pl help		- Usage information
 # ./ch-2.pl box        - Box::Calc Solution, does not work.
 # ./ch-2.pl knapsack   - Algorithm::Knapstack Solution, does not work.
 # ./ch-2.pl pi         - Pi Solution, does work.


=head1 Main program


=head2 Solution with module Text::Morse

=cut

my $cmd = shift @ARGV;		# Read command or text string
my %items;
if(!$cmd) { 
	print "ch-2.pl (Version 1.0) PWC #35 Task #2: Encode Text to Binary Morse Code\n";
	usage(); 
	exit 0; 
}
elsif($cmd eq "html") { html(); exit 0; }
elsif($cmd eq "help") { usage(); exit 0; }
elsif($cmd eq "box")  { boxing(); }
elsif($cmd eq "knapsack")  { knapsack(); }
elsif($cmd eq "pi")   { init(); pi(); }

# ====================== TASK 2 ==============================

=head1 Definition Task #2: Write a program to solve Knapsack Problem.

There are 5 color coded boxes with varying weights and amounts in GBP. 
Which boxes should be choosen to maximize the amount of money while still 
keeping the overall weight under or equal to 15 kgs?

R: (weight = 1 kg, amount = £1)
B: (weight = 1 kg, amount = £2)
G: (weight = 2 kg, amount = £2)
Y: (weight = 12 kg, amount = £4)
P: (weight = 4 kg, amount = £10)

Bonus task, what if you were allowed to pick only 2 boxes or 3 boxes or 4 boxes? 
Find out which combination of boxes is the most optimal?

=cut

# ====================== TASK 2 ==============================

=head1 Functions

=head2 init()

=cut

sub init {
  %items = (
	R => { weight => 1 , amount => 1 },
	B => { weight => 1 , amount => 2 },
	G => { weight => 2 , amount => 2 },
	Y => { weight => 12, amount => 4 },
	P => { weight => 4 , amount => 10 },
  );
}

sub boxing {
  $Data::Dumper::Indent=0;
  my $box_calc = Box::Calc->new;

  # Box shall take maximal 15kg 
  my $box = $box_calc->add_box_type( x => 100, y => 100, z => 100, weight => 0, name => 'box' );
  # my $h1 = $box->describe;
  # print Dumper($h1);
  # my $box = $box_calc->add_box_type( x => 15, y => 1, z => 1, weight => 0, name => 'box' );

  # iterate through items
  my $i = 0;
  my @I;
  foreach my $k (keys %items) {
    $I[$i] = $box_calc->add_item( 1,  { x => $items{$k}{weight}, y => 1, z => 1, 
      weight => $items{$k}{weight}, name => $k });
    my $t1 = $I[$i]->describe;
    print "($i) ", Dumper($t1), "\n";
    $i++;
  }

  # $box_calc->make_box("box");
  # figure out what you need to pack this stuff
  $box_calc->pack_items;
 
  # how many boxes do you need
  my $box_count = $box_calc->count_boxes; # 2
  print "Number Boxes $box_count\n";
 
  # interrogate the boxes
  my $b = $box_calc->get_box(-1); # the last box
  my $weight = $b->calculate_weight;
  print "Weight: $weight\n";
 
  # get a packing list
  my $packing_list = $box_calc->packing_list;

  $Data::Dumper::Indent=1;
  print Dumper($packing_list);
  print "\n";
}

sub knapsack {


 my @weights = (1,1,2,12,4); 
 my $capacity = 15;
 my $knapsack = Algorithm::Knapsack->new(
    capacity => $capacity,
    weights  => \@weights,
 );
 
 $knapsack->compute();

 foreach my $solution ($knapsack->solutions()) {
    print join(',', map { $weights[$_] } @{$solution}), "\n";
 }
 
 foreach my $s($knapsack->solutions()) {
	print "Solution: ", join(" - ",@$s), "\n";
#    foreach my $index (@{$s}) {
        # do something with $weights[$index]
#    }
  }

}

=head1 Profitabilitaetsindex and Tie::IxHash

The Index (PI) is Amount devided by Weight. The Index (PI) of each element is calculated.
Afterwards the PI is sorted in descending order. When the weight is above 15kg then
the box is full.

 sub pi {

  my (%items,%pis);
  my $t = tie(%items, 'Tie::IxHash',         # Initialize Tie::IxHash
	R => { weight => 1 , amount => 1 },
	B => { weight => 1 , amount => 2 },
	G => { weight => 2 , amount => 2 },
	Y => { weight => 12, amount => 4 },
	P => { weight => 4 , amount => 10 },
  );
  my $t2 = tie(%pis, 'Tie::IxHash');         # Hash with PI's

  foreach my $e ($t->Keys) {                 # Calculate PI for every element
    my $pi = $items{$e}{amount} / $items{$e}{weight};
	$t2->Push($e => $pi);                    # Store PI in new Tie::IxHash

    print "$e: $pi ($items{$e}{amount} / $items{$e}{weight}) \n";
  }
  $t2->SortByValue;                          # Sort PI Hash by Value
  $t2->Reorder(reverse $t2->Keys);           # Reverse sorting
  print Dumper(\%pis);
  print "----------------------------\n";

  my ($sumw, $suma);
  my $i = 0;
  foreach my $e (keys %pis) {
	my $old_weight = $sumw;
	my $old_amount = $suma;
	$sumw += $items{$e}{weight};             # Calculate Weight Sum
	$suma += $items{$e}{amount};             # Calculate Amount Sum
	if($sumw > 15) {                         # Weight Sum > 15 kg
		print "Knapstack full with $old_weight kg and $old_amount GBP!\n";
		last; 
	}
    print "$e: Weight $items{$e}{weight} $sumw, Amount $items{$e}{amount} $suma\n";
	$i++;
  }
 }

=cut

sub pi {

  my (%items,%pis);
  my $t = tie(%items, 'Tie::IxHash',
	R => { weight => 1 , amount => 1 },
	B => { weight => 1 , amount => 2 },
	G => { weight => 2 , amount => 2 },
	Y => { weight => 12, amount => 4 },
	P => { weight => 4 , amount => 10 },
  );
  my $t2 = tie(%pis, 'Tie::IxHash');

  foreach my $e ($t->Keys) {
    my $pi = $items{$e}{amount} / $items{$e}{weight};
	# $t2->Push($pi => { name => $e, %{ $items{$e}} });
	$t2->Push($e => $pi);

    print "$e: $pi ($items{$e}{amount} / $items{$e}{weight}) \n";
  }
  $t2->SortByValue;
  $t2->Reorder(reverse $t2->Keys);
  print Dumper(\%pis);
  print "----------------------------\n";

  my ($sumw, $suma);
  my $i = 0;
  foreach my $e (keys %pis) {
	my $old_weight = $sumw;
	my $old_amount = $suma;
	$sumw += $items{$e}{weight};
	$suma += $items{$e}{amount};
	if($sumw > 15) { 
		print "Knapstack full with $old_weight kg and $old_amount GBP!\n";
		last; 
	}
    print "$e: Weight $items{$e}{weight} $sumw, Amount $items{$e}{amount} $suma\n";
	$i++;
  }
}

# ================================ Usage ============================
sub usage {
	print "./ch-2.pl <command>\n";
	print "\n";
	print "   command, html|help\n";
	print "      help,  Prints out some usage information.\n";
	print "      html,  Writes HTML and CSS from POD.\n";
	print "\n";
	print "   Examples:\n";
	print "      # perldoc ch-2.pl\n";
	print "      # ./ch-2.pl help\n";
	print "      # ./ch-2.pl html\n";
	print "      # ./ch-2.pl box\n";
	print "      # ./ch-2.pl knapsack\n";
	print "      # ./ch-2.pl pi\n";
}

sub html {
	# ------------- Create HTML --------------
	qx[ pod2html --header --title \"Perl Weekly Challenge #36 Task #2, Solve Knapsack Problem\" --css \"pwc.css\" ch-2.pl > ch-2.html ];

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


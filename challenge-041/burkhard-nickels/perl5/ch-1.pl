#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper qw(Dumper);
use Hash::Flatten qw(flatten);
use Math::Prime::Util;          
# libgmp-dev must be installed, (gnu multiprecission arithmetic library)
$Data::Dumper::Indent=0;

=head1 Perl Weekly Challenge #41 Task #1: Attractive Number

<Explanation of the created solution>

=over 3

=item * <Used modules and for what used>

=item * <Used modules and for what used>

=back


=begin html

<h2> Download and References </h2>
<b>Download File:</b><a href="ch-1.pl" download>Solution PWC #41 Task #1 ch-1.pl</a><br>
<b>Download File:</b><a href="ch-2.pl" download>Solution PWC #41 Task #2 ch-2.pl</a><br>
<br>

=end html

=head1 SYNOPSIS

 # ./ch-1.pl


 # perldoc ch-1.pl		- POD
 ./ch-1.pl [html|help]
 # ./ch-1.pl html		- HTML/CSS in ch-1.html/pwc.css
 # ./ch-1.pl help		- Usage information

=cut

print "ch-1.pl (Version 1.0) PWC #41 Task #1: Attractive Number\n";

my $cmd = shift @ARGV;		# Read command or text string
if(!$cmd) { $cmd = ""; }

if($cmd eq "html") { html(); exit 0; }
elsif($cmd eq "help") { usage(); exit 0; }

# ====================== TASK 1 ==============================

=head1 Definition Task #1: Attractive Number

Write a script to display attractive number between 1 and 50.

A number is an attractive number if the number of its prime factors is also prime number.

The number 20 is an attractive number, whose prime factors are 2, 2 and 5. 
The total prime factors is 3 which is also a prime number.

=cut

# ====================== TASK 1 ==============================

=head1 Functions

=cut

my $res = calculate_primes(50);
print "Prime Numbers: ", Dumper($res), "\n";

my @numbers = (1 .. 50);
my @primes = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53);
print "Prime Numbers: ", Dumper(\@primes), "\n";


print "Attractive Numbers:\n";

foreach my $nbr (1 .. 50) {
	my @res;
	my %tree;
	my ($x,$y) = (-1,0);
	print "TEST $nbr ---> \n";
	nr_recursive($nbr,\@res,$x,\$y,\%tree);
	# print "Ergebnis: ", Dumper(\@res), "\n";
	$Data::Dumper::Indent=1;
	# print "Ergebnis: ", Dumper(\%tree), "\n";
	my $flat = flatten(\%tree);
	# print "Flat: ", Dumper($flat), "\n";
	is_attractive_number($flat);
	print "\n";
}


sub is_attractive_number {
	my ($flat) = @_;
	foreach my $k (keys %$flat) {
		my $attr_nbr = 1;
		my @tmp = split(/\./,$k);
		foreach my $i (@tmp) {
			if( ! is_prime($i) ) { $attr_nbr = 0; }
		}
		if($attr_nbr) {
			print "   $k => $flat->{$k} Attractive Number";
			if( is_prime($flat->{$k}) ) {
				print "(Number Factors $flat->{$k} is Prime)\n";
			} else { print "\n"; }
		}
		else { 
			# print "$k => $flat->{$k}\n"; 
		}
	}
}

sub nr_recursive {
	my ($number,$res,$x,$y,$tree) = @_;
	$x++; 
	# my $space = " " x ($x * 2);
	# print "$space X+($x/$$y)\n";
	# print "$space IN: $number ($x/$y)\n";
	my $loop;
	if($x == 0) { $loop = $number-1; }
	else { $loop = $number; }
	my $found_count=0;
	foreach my $j ((2 .. $loop)) {
		# print "$space LO: $number ($x/$y)\n";
		my $div = $number/$j;         # Division with every whole number.
		my $nr  = int($div);
		my $rst = $number%$j;
		# print "$space - $j ($div,$nr,$rst)\n";
		if( ! $rst ) {           # Result is whole number
			$found_count++;
			# print "$space => $j ($x/$$y - Next $nr)\n";
			$res->[$$y][$x] = $j;

			if($nr == 1) { $tree->{$j} = $x+1; }
			else { $tree->{$j} = {}; }

			if($$y > 0) {
				foreach my $k (0 .. $x-1) { 
					$res->[$$y][$k] = $res->[$$y-1][$k]; 
					# print "$space => $res->[$$y-1][$k] ($k/$$y)\n";
				}
				# $$y++; print "$space Y+($x/$$y)\n";
			}

			nr_recursive($nr,$res,$x,$y,$tree->{$j});
			# if($found_count > 1) {
			# 	$$y++; print "$space Y+($x/$$y)\n";
			# }
			$$y = $#$res + 1; # print "$space Y+($x/$$y)\n";
		}
	}
	$x--; # print "$space X-($x/$$y)\n";
}

=head2 is_prime($nr)

=cut

sub is_prime {
	my ($nr) = @_;
	my $prime=1;
	foreach my $j ((2 .. $nr-1)) { # Not dividing by 1 or the same number
		my $div = $nr/$j;           # Division with every whole number.
		my $nr  = int($div);
		my $rst = $nr%$j;
		if( ! $rst ) {             # If no Rest 
			$prime=0;              # it is NO prime number
			last;
		}
	}
	return $prime;
}

sub calculate_primes {
	my ($max) = @_;

	my @result;
	my $prime=1;
	foreach my $i ((2 .. $max)) {
		foreach my $j ((2 .. $i)) {
			my $div = $i/$j;         # Division with every whole number.
			my $nr  = int($div);
			my $rst = $i%$j;
			if( ! $rst and $i!=$j) { # If no Rest and not devided by same.
				$prime=0;            # it is NO prime number
				last;
			}
		}
		if($prime) { push(@result,$i); } # Prime Number
		else { $prime=1; }
	}
	return \@result;
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
	qx[ pod2html --header --title \"Perl Weekly Challenge #41 Task #1, Attractive Numbers\" --css \"pwc.css\" ch-1.pl > ch-1.html ];

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


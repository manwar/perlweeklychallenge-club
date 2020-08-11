#!/usr/bin/perl

use strict;
use warnings;
use DateTime;
use Data::Dumper qw(Dumper);
$Data::Dumper::Indent=0;

=head1 Perl Weekly Challenge #39 Task #1: Guest House

This solution expects the arrive time of each next guest higher than the former.
When the leave time is bigger than the former the end time is set. When the leave
time is smaller then the end time is kept. Time calculation is done with the
C<DateTime> Module.

=over 3

=item * DateTime

=item * DateTime::Duration

=back


=begin html

<h2> Download and References </h2>
<b>Download File:</b><a href="ch-1.pl" download>Solution PWC #39 Task #1 ch-1.pl</a><br>
<b>Download File:</b><a href="ch-2.pl" download>Solution PWC #39 Task #2 ch-2.pl</a><br>
<br>

=end html

=head1 SYNOPSIS

 # perldoc ch-1.pl		- POD
 ./ch-1.pl [html|help]

 # ./ch-1.pl            - Executes the program

 # ./ch-1.pl html		- HTML/CSS in ch-1.html/pwc.css
 # ./ch-1.pl help		- Usage information

 ./ch-1.pl
 ch-1.pl (Version 1.0) PWC #39 Task #1: Guest House
      Alex: 09:10 - 09:45
    Arnold: 09:15 - 09:33
       Bob: 09:22 - 09:55
   Charlie: 09:25 - 10:05
     Steve: 09:33 - 10:01
     Roger: 09:44 - 10:12
     David: 09:57 - 10:23
      Neil: 10:01 - 10:19
     Chris: 10:10 - 11:00
 Duration 1:50 (09:10:00 - 11:00:00)


=cut

my (@guest_book);

print "ch-1.pl (Version 1.0) PWC #39 Task #1: Guest House\n";

my $cmd = shift @ARGV;		# Read command or text string
if(!$cmd) { $cmd = ""; }
if($cmd eq "html") { html(); exit 0; }
elsif($cmd eq "help") { usage(); exit 0; }
else {
	init();
	calculate_light_on();
}

# ====================== TASK 1 ==============================

=head1 Definition Task #1: Guest House

A guest house had a policy that the light remain ON as long as the at least one guest 
is in the house. There is guest book which tracks all guest in/out time. 
Write a script to find out how long in minutes the light were ON.

Guest Book

 1) Alex    IN: 09:10 OUT: 09:45
 2) Arnold  IN: 09:15 OUT: 09:33
 3) Bob     IN: 09:22 OUT: 09:55
 4) Charlie IN: 09:25 OUT: 10:05
 5) Steve   IN: 09:33 OUT: 10:01
 6) Roger   IN: 09:44 OUT: 10:12
 7) David   IN: 09:57 OUT: 10:23
 8) Neil    IN: 10:01 OUT: 10:19
 9) Chris   IN: 10:10 OUT: 11:00


=cut

# ====================== TASK 1 ==============================

=head1 Functions

The C< init() > function first initializes an array with the given guest book data.
Then it creates for the time values an array of DateTime Objects.

The C< calculate_light_on() > function than calculates the start and end time for
B< light on > and than also the difference of these two timestamps. Means the light
on time.

=head2 init()

The array C< @guest_book_tmp > is changed in a C< DateTime > objects array by
iterating over each element of the array.

 sub init {

  my @guest_book_tmp = (
	[ "Alex"   ,"09:10","09:45" ],
	[ "Arnold" ,"09:15","09:33" ],
	[ "Bob"    ,"09:22","09:55" ],
	[ "Charlie","09:25","10:05" ],
	[ "Steve"  ,"09:33","10:01" ],
	[ "Roger"  ,"09:44","10:12" ],
	[ "David"  ,"09:57","10:23" ],
	[ "Neil"   ,"10:01","10:19" ],
	[ "Chris"  ,"10:10","11:00" ]
  );
  my %date = ( year=>2019,month=>12,day=>16 );
  foreach my $g (@guest_book_tmp) {
    printf("  %8s: %5s - %5s\n", @$g);
    my @tmp;
    my ($inh,$inm) = split(":",$g->[1]);
    my ($ouh,$oum) = split(":",$g->[2]);
    push(@tmp, DateTime->new( %date, hour=> $inh, minute=> $inm ));
    push(@tmp, DateTime->new( %date, hour=> $ouh, minute=> $oum ));
    push(@tmp, $tmp[1] - $tmp[0]);
    push(@guest_book,[@tmp]);
  }
 }

=cut

sub init {

  my @guest_book_tmp = (
	[ "Alex"   ,"09:10","09:45" ],
	[ "Arnold" ,"09:15","09:33" ],
	[ "Bob"    ,"09:22","09:55" ],
	[ "Charlie","09:25","10:05" ],
	[ "Steve"  ,"09:33","10:01" ],
	[ "Roger"  ,"09:44","10:12" ],
	[ "David"  ,"09:57","10:23" ],
	[ "Neil"   ,"10:01","10:19" ],
	[ "Chris"  ,"10:10","11:00" ]
  );
  my %date = ( year=>2019,month=>12,day=>16 );
  foreach my $g (@guest_book_tmp) {
    printf("  %8s: %5s - %5s\n", @$g);
    my @tmp;
    my ($inh,$inm) = split(":",$g->[1]);
    my ($ouh,$oum) = split(":",$g->[2]);
    push(@tmp, DateTime->new( %date, hour=> $inh, minute=> $inm ));
    push(@tmp, DateTime->new( %date, hour=> $ouh, minute=> $oum ));
    push(@tmp, $tmp[1] - $tmp[0]);
    push(@guest_book,[@tmp]);
  }
}

=head2 calculate_light_on()

The ligth_on calculation is done via iteration over the array and only verifying it
next end time is later than stored end time. When the cases are more complicated, in
some gaps inbetween the time ranges, than this example wouldn't work anymore. Than
some more if-statements would be necessary. So this may-be works only for the given
simple example.

C<hours()> and C<minutes()> are methods from DateTime::Duration to return
the Hours and Minutes of the Duration object. C<hms()> is a methode from DateTime
to return the time in the readable format "hh:mm", i.e. "11:00".

 sub calculate_light_on {

  my $old   = $guest_book[0];
  my $start = $old->[0];
  my $end   = $old->[1];
  for( my $i=1; $i<=$#guest_book; $i++ ) {
    my $t = $guest_book[$i][1]; 
    if( $t > $end ) { $end = $t; }
  }
  my $dur = $end - $start;
  print "Duration ", $dur->hours, ":", $dur->minutes, " (", 
    $start->hms, " - ", $end->hms, ")\n";
 }

=cut

sub calculate_light_on {

  my $old   = $guest_book[0];
  my $start = $old->[0];
  my $end   = $old->[1];
  for( my $i=1; $i<=$#guest_book; $i++ ) {
    my $t = $guest_book[$i][1]; 
    if( $t > $end ) { $end = $t; }
  }
  my $dur = $end - $start;
  print "Duration ", $dur->hours, ":", $dur->minutes, " (", $start->hms, " - ", $end->hms, ")\n";
}



# ================================ Usage ============================
sub usage {
	print "./ch-1.pl [help|html]\n";
	print "\n";
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
	qx[ pod2html --header --title \"Perl Weekly Challenge #39 Task #1, Guest Book\" --css \"pwc.css\" ch-1.pl > ch-1.html ];

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


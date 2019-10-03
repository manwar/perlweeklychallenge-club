# Write a script to display Digital Clock. Feel free to be as creative as you can 
# when displaying digits. We expect bare minimum something like “14:10:11”.
use strict;
use warnings;
use v5.10;

#Used to clear screen and to handle terminal screen commands
require Term::Screen::Uni;
my $scr = new Term::Screen::Uni;
#Screen is cleared 1 time only
$scr->clrscr();

my @ascii_num= (
    ["  0000  "," 00  00 "," 00  00 "," 00  00 ","  0000  "],
    ["   11   ","   11   ","   11   ","   11   ","   11   "],
    [" 222222 ","     22 "," 222222 "," 22     "," 222222 "],
    [" 333333 ","     33 "," 333333 ","     33 "," 333333 "],
    [" 44  44 "," 44  44 "," 444444 ","     44 ","     44 "],
    [" 555555 "," 55     "," 555555 ","     55 "," 555555 "],
    [" 666666 "," 66     "," 666666 "," 66  66 "," 666666 "],
    [" 777777 ","     77 ","     77 ","     77 ","     77 "],
    [" 888888 "," 88  88 "," 888888 "," 88  88 "," 888888 "],
    [" 999999 "," 99  99 "," 999999 ","     99 "," 999999 "],
    ["    "," :: ","    "," :: ","    "],
    ["    ","    ","    ","    ","    "]
);
my $toggler = 1;
while (1) {
    #Get local time and store it in each variable
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();

    #Convert to HH:MM:SS using sprintf
    my $dig_time = (sprintf ("%02d:%02d:%02d", $hour,$min,$sec));

    #Init lines to be printed
    my @printline;
    
    #For the blinking semicolon
    $toggler = !$toggler;
    for ($dig_time=~/./g) {
        for my $i (0..4) {
            #Build up the text to be printed per line
            $printline[$i] .= $ascii_num[/:/?($toggler)?10:11:$_][$i];
        }
    }
    for my $i (0..4) {
        #Select cursur at Row $i, Col 0
        $scr->at($i,0);
        #Print at selected Row/Col
        print $printline[$i];
    }
    $scr->at(6,0);
    print "Today is ".qw(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)[$wday-1].": ".qw(January February March April May June July August September October November December)[$mon]." $mday, ".(1900+$year);

    #Used as Delay, sleep only has 1 sec minimum delay
    #But I need 500 ms for the blinking semicolon
    select(undef, undef, undef, 0.5);
}

=begin
perl .\ch-2.pl
  0000   999999      333333  44  44      222222  333333
 00  00  99  99  ::      33  44  44  ::      22      33
 00  00  999999      333333  444444      222222  333333
 00  00      99  ::      33      44  ::  22          33
  0000   999999      333333      44      222222  333333

Today is Tuesday: October 1, 2019
=cut
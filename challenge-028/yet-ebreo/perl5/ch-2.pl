# Write a script to display Digital Clock. Feel free to be as creative as you can 
# when displaying digits. We expect bare minimum something like “14:10:11”.
use strict;
use warnings;
use v5.10;

require Term::Screen::Uni;
my $scr = new Term::Screen::Uni;
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
    [" :: "," :: ","    "," :: "," :: "],
    ["    ","    ","    ","    ","    "]
);
my $toggler = 1;
while (1) {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
    my $dig_time = (sprintf ("%02d:%02d:%02d", $hour,$min,$sec));
    my @printline;
    
    $toggler = !$toggler;
    for ($dig_time=~/./g) {
        if (/:/) {
            for my $i (0..4) {
                $printline[$i] .= $ascii_num[($toggler)?10:11][$i];
            }
        } else {
            for my $i (0..4) {
                $printline[$i] .= $ascii_num[$_][$i];
            }
        }
    }
    for my $i (0..4) {
        $scr->at($i,0);
        print $printline[$i];
    }
    $scr->at(6,0);
    print "Today is ".qw(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)[$wday-1].": ".qw(January February March April May June July August September October November December)[$mon]." $mday, ".(1900+$year);
    select(undef, undef, undef, 0.5);
}

=begin
  0000    0000   ::  555555  333333  ::  333333  333333
 00  00  00  00  ::  55          33  ::      33      33
 00  00  00  00      555555  333333      333333  333333
 00  00  00  00  ::      55      33  ::      33      33
  0000    0000   ::  555555  333333  ::  333333  333333

Today is Tuesday: October 1, 2019
=cut
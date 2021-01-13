#!/usr/bin/perl

use strict;

my $numppl = 50;

my $ppl = "K" . "P" x ( $numppl - 1 );
my @ppl = split //, $ppl;

my $x      = 1;
my $killer = 0;

print "P = Living person\n";
print "K = Killer\n";
print "V = Victim\n";

while () {

    #Find next victim
    until ( $ppl[$x] eq "P" ) {
        $x++;
        if ( $x > $numppl ) { $x = 0 }
    }
    $ppl[$x] = "V";

    print @ppl;
    print "\n";

    $ppl[$x] = "_";

    #Find next killer
    until ( $ppl[$x] eq "P" ) {
        $x++;
        if ( $x == $killer ) {    # only the killer remains
            print "1234567890" x int( $numppl / 10 ) . "\nPerson ";
            print $x + 1 . " survives\n";
            exit;
        }
        if ( $x > $numppl ) { $x = 0 }
    }
    $ppl[$x]      = "K";
    $ppl[$killer] = "P";
    $killer       = $x;
}

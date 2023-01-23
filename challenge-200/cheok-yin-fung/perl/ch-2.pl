# The Weekly Challenge 200
# Task 1 Seven Segment 200
use v5.30.0;
use warnings;

my @truth = qw<abcdef bc     abdeg abcdg   bcfg 
               acdfg  acdefg abc   abcdefg abcfg>;

draw($ARGV[0] || 200);

sub draw {
    my @arr = split "", $_[0];
    for my $d (0..$#arr) {
        drawA(index($truth[$arr[$d]], "a"));
        print(($d==$#arr)?"\n":"  ");
    }
    for (1..2) {
        for my $d (0..$#arr) {
            drawFB(index($truth[$arr[$d]], "f"), index($truth[$arr[$d]], "b"));
            print(($d==$#arr)?"\n":"  ");
        }
    }
    for my $d (0..$#arr) {
        drawA(index($truth[$arr[$d]], "g"));
        print(($d==$#arr)?"\n":"  ");
    }
    for (1..2) {
        for my $d (0..$#arr) {
            drawFB(index($truth[$arr[$d]], "e"), index($truth[$arr[$d]], "c"));
            print(($d==$#arr)?"\n":"  ");
        }
    }
    for my $d (0..$#arr) {
        drawA(index($truth[$arr[$d]], "d"));
        print(($d==$#arr)?"\n":"  ");
    }
}


sub drawA {
    print "       " if $_[0] == -1;
    print "-------" if $_[0] != -1;
}

sub drawFB {
    print "       " if $_[0] == -1 && $_[1] == -1;
    print "|      " if $_[0] != -1 && $_[1] == -1;
    print "      |" if $_[0] == -1 && $_[1] != -1;
    print "|     |" if $_[0] != -1 && $_[1] != -1;
}

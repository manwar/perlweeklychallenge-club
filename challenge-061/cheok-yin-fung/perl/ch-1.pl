#/usr/bin/perl
use strict;
my @original = @ARGV;
#my @original = (9, 3,0, -1, 3, 9, -1);

my $max = $original[0];
my @anskey = ();
for $_ (0..$#original) {
    if ($original[$_] == $max) {
        push @anskey, $_, "*";
    } 
    if ($original[$_] > $max) {
        $max = $original[$_]; 
        @anskey = (); 
        push @anskey, $_, "*";
    }
}

for my $i (0..$#original-1) {
    for my $j ($i+1..$#original) {
        my $prod = $original[$i];
        for (my $h = $i+1; $h <= $j; $h++) {
            $prod *= $original[$h] ;
        }
        if ($prod == $max) {
            push @anskey, $i..$j, "*" ;
        } 
        elsif ($prod > $max) {
            @anskey = ();
            $max = $prod;
            push @anskey, $i..$j, "*";
        }
    }

}

#print "max:", $max, "\n";

sub printans {
    if ( @anskey != () ) {
        print "[";
        for my $i (0..$#anskey-1) {
            if ( ($anskey[$i] eq "*") and ($i != $#anskey) ) {
                print "], [";
            } 
            elsif ($anskey[$i+1] ne "*" ) {
                print "$original[$anskey[$i]], "
            }
            else {
                print "$original[$anskey[$i]] "; 
            }
        }
        print "]";
    }
}

printans;
print "\n";

#!/usr/bin/perl
# Test: ./ch-1.pl 50 100
use Modern::Perl;

my $a = shift;
my $b = shift;
my @answers;

die "Invalid inputs"
    if ( !$a || !$b || $a > $b ||
         $a < 0 || $b > 10e15 );

# Process each number
for my $i ($a .. $b) {
    my $orig = $i;

    # Check and remove 6/9, 9/6 0/0, 1/1, 8/8 pairs
    my $search_length = length($i) / 2;
    for (my $j = 0; $j < $search_length; $j++) {
    	my $p1 = substr $i, $j, 1;
    	my $p2 = substr $i, length($i) - $j - 1, 1;

    	if ( ($p1 == 6 && $p2 == 9) ||
    	     ($p1 == 9 && $p2 == 6) ||
    	     ($p1 == 0 && $p2 == 0) ||
    	     ($p1 == 8 && $p2 == 8) ||
    	     ($p1 == 1 && $p2 == 1)) {
    		$i = substr $i, 1, length($i) - 2;
    		$j--;
    		$search_length--;
    	} else {
    		last;
    	}
    }

    push @answers, $orig
    	unless ($i);
}

say join ', ', @answers;

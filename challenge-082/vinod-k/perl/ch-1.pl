use strict;
use warnings;

my ($a, $b) = @ARGV;

die "Please enter two positive numbers: $!" unless (@ARGV && $#ARGV >= 1);

my %seen;
my (@a, @b, @final);

foreach my $i (1..$a+1){
    if( $a % $i == 0){
        push (@a, $i);
    }
}

foreach my $j (1..$b+1){
    if( $b % $j == 0){
        push (@b, $j);
    }
}

@seen{@a} = ();

foreach my $new ( @b ) {
    push (@final, $new ) if exists $seen{$new};
}

print "Common factors in $a and $b are:\n";
foreach (@final){
    print "$_\n"
}

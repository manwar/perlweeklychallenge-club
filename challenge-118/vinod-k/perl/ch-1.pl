use strict; use warnings;

my $N = $ARGV[0] || die "Please enter an integer";

my $N_Bin = sprintf ("%b", $N);

if( $N_Bin eq reverse($N_Bin)){
    print "1 as binary representation of $N is $N_Bin which is Palindrome\n";
} else {
    print "0 as binary representation of $N is $N_Bin which is NOT Palindrome\n";
}

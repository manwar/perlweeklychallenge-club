use Modern::Perl;
use experimental qw<signatures>;

# Where A,B,C,D are all pentagonal numbers:
# B + C == A      ,  B - C == D     Original problem statement in task 
#     C == A - B  ,  B - C == D     Rearranged as two differences
#     C == A - B  ,  B-(A-B)==D     Rearranged as two differences(C,D), expressed only in A,B
# So, if we find any two pentagonal numbers A,B where A-B is pentagonal and B-(A-B) is pentagonal,
# then we have a solution. The desired numbers will be the inner two: (B,C)
sub find_first_plus_and_minus_pentagon_numbers ( ) {
    my @pents;
    my %p;
    for ( my $i = 1 ; ; $i++ ) {
        my $A = $i * (3*$i - 1) / 2; # Pentagon number

        for my $B (@pents) {
            my $D = $A - $B;
            my $C = $B - $D;
            return $B, $C if $p{$C} and $p{$D};
        }

        $p{$A} = 1; 
        push @pents, $A;
    }
}

say join ' ', find_first_plus_and_minus_pentagon_numbers();

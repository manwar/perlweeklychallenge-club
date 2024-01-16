use strict;
use warnings;
use Test::More tests => 3;

sub di_string_match {
    my ($str) = @_;
    my $n = length($str);
    my ( $low, $high ) = ( 0, $n );
    my @perm = ();

    foreach my $char ( split //, $str ) {
        if ( $char eq 'I' ) {
            push @perm, $low++;
        }
        else {
            push @perm, $high--;
        }
    }

    push @perm, $low;    # $low == $high at this point
    return @perm;
}

# Tests
is_deeply( [ di_string_match("IDID") ], [ 0, 4, 1, 3, 2 ], 'Test IDID' );
is_deeply( [ di_string_match("III") ],  [ 0, 1, 2, 3 ], 'Test III' );
is_deeply( [ di_string_match("DDI") ],  [ 3, 2, 0, 1 ], 'Test DDI' );

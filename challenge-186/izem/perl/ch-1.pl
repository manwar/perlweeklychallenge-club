use strict;
use warnings;
use feature 'say';

my @a = qw/1 2 3/;
my @b = qw/a b c/;
say 'zipped: ' . join( ', ', zip( @a, @b ) );

sub zip {
    my @zipped = ();
    my $midPos = int( scalar(@_) / 2 );
    for ( my $i = 0 ; $i < $midPos ; $i++ ) {
        push( @zipped, $_[$i], $_[ $i + $midPos ] );
    }
    return @zipped;
}

use Modern::Perl;
use feature qw(signatures);
no warnings qw(experimental::signatures);

my @A = (10, 20, 30, 40, 50);
my @B = (3, 13, -2, 0);

for my $by ( @B )
{
    say join ", ", rotate_array( $by, @A )
}

sub rotate_array( $i, @a )
{
    my $n = (@a + $i) % @a;
    @a[ $n..(@a-1) ], @a[ 0..($n-1) ];
}
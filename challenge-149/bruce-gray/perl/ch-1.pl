use Modern::Perl;
use List::Util      qw<sum>;
use Math::Fibonacci qw<isfibonacci>;

my $count = abs( shift // 20 );

my @out;
for ( my $i = 0 ; $count ; ++$i ) {
    next unless isfibonacci( sum split '', $i );
    $count--;
    push @out, $i;
}

say join ', ', @out;

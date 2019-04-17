use strict;
use warnings;
use Const::Fast;
use HOP::Stream qw( head merge node tail transform );

const my $N => $ARGV[0] // 29;

$| = 1;

my $hs = hamming();
print "\n", head($hs) if $N >= 1;

for (2 .. $N)
{
        $hs = tail($hs);
            print ' ' . head($hs);
}

print "\n";

sub hamming
{
    my $hamming;

    return $hamming =
        node
        (
          1,
          sub
          {
             merge
             (
                    (transform { $_[0] * 2 } $hamming),
                merge
                (
                    (transform { $_[0] * 3 } $hamming),
                    (transform { $_[0] * 5 } $hamming),
                )
             )
          }
        );
}

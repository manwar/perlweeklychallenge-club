use strict;
use warnings;

__PACKAGE__->run() unless caller;

use lib './lib';
use Invert;

sub run {
    my $m = $ARGV[0] || shift;
    my $n = $ARGV[1] || shift;

    my $invert   = Invert->new;
    my $inverted = $invert->bit( m => $m, n => $n );
    print "Input: \$m = $m, \$n = $n\nOutput: $inverted\n";
}

1;


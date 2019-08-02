use strict;
use warnings;
use Const::Fast;

const my $PREFIX => '  ';
const my $SPACE  => ' ';

MAIN:
{
    my @input  = ('This', 'is', 'a test of the', 'center function');
    my @output = center(@input);

    print "\n";
    print $PREFIX . $_ . "\n" for @output;
}

sub center
{
    my @lines = @_;
    my $max   = 0;
    my @lengths;

    for my $line (@lines)
    {
        my $len = length $line;
        push @lengths, $len;
        $max = $len if $len > $max;
    }

    my @centered;

    for my $i (0 .. $#lines)
    {
        my $spaces = int(($max - $lengths[$i]) / 2);
        push @centered, ($SPACE x $spaces) . $lines[$i];
    }

    return @centered;
}

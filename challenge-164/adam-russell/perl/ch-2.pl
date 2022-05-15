use strict;
use warnings;
##
# W
##
use boolean;
use constant N => 8;

sub happy{
    my $n = shift;
    my @seen;
    my $pdi = sub{
        my $x = shift;
        my $total = 0;
        {
            $total += ($x % 10)**2;
            $x = int($x / 10);
            redo if $x > 0;
        }
        return $total;
    };
    {
        push @seen, $n;
        $n = $pdi->($n);
        redo if $n > 1 && (grep {$_ == $n} @seen) == 0; 
    }
    return boolean($n == 1);
}

MAIN:{
    my $i = 0;
    my @happy;
    {
        $i++;
        push @happy, $i if happy($i);
        redo if @happy < 8;
    }
    print join(", ", @happy) . "\n";
}

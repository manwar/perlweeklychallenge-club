use strict;
use warnings;
##
# Write a script to find the first 8 Happy Numbers in base 10. 
##
use boolean;
use constant N => 8;

sub happy{
    my $n = shift;
    my @seen;
    my $pdi = sub{
        my $n = shift;
        my $total = 0;
        {
            $total += ($n % 10)**2;
            $n = int($n / 10);
            redo if $n > 0;
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
        redo if @happy < N;
    }
    print join(", ", @happy) . "\n";
}

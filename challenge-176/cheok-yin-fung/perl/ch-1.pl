use v5.30.0;
use warnings;

my $t = 0;
my $k = 1;
while ($t < 1) {
    $k++;
    if ($k =~ /[6789]/) {
        if (check_good("1".$k, [2,3,4,5,6])) {
            $t++;
            say "1".$k;
        }
    }
}

sub check_good {
    my $i = $_[0];
    my @arr = $_[1]->@*;
    my $count = 0;
    my $dc = arrange($i);
    for (@arr) {
        if ( arrange($_*$i) eq $dc ) {
            $count++;
        }
        else {
            last;
        }
    }
    return $count == scalar @arr;
}

sub arrange {
    return join "", sort {$a<=>$b} split "", $_[0];
}

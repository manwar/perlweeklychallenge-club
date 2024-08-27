# The Weekly Challenge 284
# Task 1 Lucky Integer

sub li {
    my @ints = @_;
    my %freq;
    for (@ints) {
        $freq{$_}++;
    }
    for (sort {$b<=>$a} keys %freq) {
        return $_ if defined($freq{$_}) && $freq{$_} == $_;
    }
    return -1;
}


use Test::More tests=>3;
ok li(2,2,3,4) == 2;
ok li(1,2,2,3,3,3) == 3;
ok li(1,1,1,3) == -1;


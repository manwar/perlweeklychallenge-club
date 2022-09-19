# The Weekly Challenege 178
# Task 1 Quater-imaginary base
use v5.30.0;
no warnings;  # Deep recursion often happens
use List::Util qw/max reduce/;

my $N = $ARGV[0] || "";

say qib_tr($N) if $N =~ /^(-)?\d+$/;
say "Integers only." if $N =~ /\./;



sub qib_tr {
    my $num = $_[0];
    return 0 if $num == 0;
    if ($num < 0) {
        return 
            fmt_qibstr(qibneg(qib_tr(-$num))->@*);
    }

    my %hash;
    $hash{sprintf("%0x", $_)} = stepwise_tr($_) for (0..15);
    my @hexstr = split "", sprintf("%0x", $num);
    my @com = map { 
                $hash{$hexstr[$_]}.("0000" x scalar @hexstr - 1 - $_)  
              } 0..scalar @hexstr-1;
    return reduce {qibadd($a, $b)} @com; 
}


sub stepwise_tr {
    my $num = $_[0];
    return 0 if $num == 0;
    my $ans;
    if ($num > 0) {
        $ans = stepwise_tr($num-1)+1;
        my @arr = split "", $ans;
        unshift @arr, 0, 0, 0, 0;
        return fmt_qibstr(@arr);
    }
    else {
        return fmt_qibstr(qibneg(stepwise_tr(-$num))->@*);
    }
}



sub qibadd {
    my @ans;
    my $m = $_[0];
    my $n = $_[1];
    ($m, $n) = ($n, $m) if (length $n > length $m);
    my @marr = split "", $m;
    my @narr = split "", $n;
    unshift @narr, (0) x (4 + scalar @marr - scalar @narr);
    unshift @marr, (0) x (4);
    for (0..scalar @marr - 1) {
        push @ans, $marr[$_]+$narr[$_];
    }
    return fmt_qibstr(@ans);
}



sub qibneg {
    my @ans;
    my $s = $_[0];
    my @sarr = split "", $s;
    unshift @sarr, (0) x (4);
    my @narr = (0) x (scalar @sarr);
    for (0..scalar @sarr - 1) {
        push @ans, $narr[$_]-$sarr[$_];
    }
    return [@ans];
}



sub fmt_qibstr {
    my @arr = @_;
    for (reverse (0..scalar @arr - 1)) {
        while ($arr[$_] > 3) {
            $arr[$_] -= 4;
            $arr[$_-2] -= 1;
        }
        if ($arr[$_] < 0) {
            $arr[$_] += 4;
            $arr[$_-2] += 1;
        }
    }
    # truncate zeros
    while ($arr[0] == 0) {
        shift @arr unless scalar @arr == 1;
    }
    return join "", @arr;
}



use Test::More tests=>5;
ok (stepwise_tr($_) == qib_tr($_)) for map {3**$_} (1..5);

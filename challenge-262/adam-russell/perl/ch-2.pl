use v5.38;

sub count_equal_divisible{
    my($integers, $k, $i, $j, $equal_divisible) = @_;
    $i = 0 if !defined $i;
    $j = 1 if !defined $j;
    $equal_divisible = [] if !defined $equal_divisible;  
    push @{$equal_divisible}, [$i, $j] if $integers->[$i] == $integers->[$j] && 0 == (($i * $j) % $k);
    count_equal_divisible($integers, $k, $i, $j + 1, $equal_divisible) if $j <= @{$integers} - 2;  
    count_equal_divisible($integers, $k, $i + 1, $i + 2, $equal_divisible) if $j == @{$integers} - 1 && $i < @{$integers} - 2;  
    return $equal_divisible;
}

my $r;
$r = count_equal_divisible [3, 1, 2, 2, 2, 1, 3], 2;
print @{$r} . q/: /; 
do{
    print q/ [/ . $_->[0] . q/, / . $_->[1] . q/]/;
} for @{$r};
print qq/\n/;

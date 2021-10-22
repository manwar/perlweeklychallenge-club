unit sub MAIN(Int $n is copy);
$n = abs $n;
die "too short" if $n.chars < 3;
die "even number of digits" if $n.chars %% 2;
put $n.substr($n.chars div 2 - 1, 3);

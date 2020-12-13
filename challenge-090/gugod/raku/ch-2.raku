
sub MAIN (Int $num1, Int $num2) {
    my $n1 = $num1;
    my $n2 = $num2;
    my @logs;
    push @logs, [ $n1, $n2 ];
    while $n1 != 1 {
        $n1 = $n1 div 2;
        $n2 = $n2 * 2;
        push @logs, [ $n1, $n2 ];
    }

    say "\#\t$num1 × $num2\n";
    for @logs -> $log {
        my $star = $log[0] %% 2 ?? " " !! "+";
        say "\t$log[0]\t$star $log[1]";
    }
    say "-------------------------";
    say "\t\t  " ~ @logs.grep({ .[0] % 2 == 1 }).map({ .[1] }).sum ~ "\n";
}

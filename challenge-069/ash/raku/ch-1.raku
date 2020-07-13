my $a = 0;
my $b = 2000;

put grep {
        $_ ~~ / ^ <[01689]>+ $ / &&
        $_ eq $_.trans('69' => '96').flip
    },
    $a..$b;

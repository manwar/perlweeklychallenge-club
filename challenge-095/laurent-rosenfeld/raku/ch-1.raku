use v6;

my $num = @*ARGS[0] // 1221;
say "$num: ", +($num eq $num.flip);

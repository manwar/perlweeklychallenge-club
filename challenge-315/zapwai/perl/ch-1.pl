use v5.38;

sub proc($char, @list) {
    say "Input: \@list = @list, \$char = $char";
    my @o = grep { $list[$_] =~ /$char/ } (0 .. $#list);
    say "Output: @o";
}

my @list = ("the", "weekly", "challenge");
my $char = 'e';
proc($char, @list);

@list = ("perl", "raku", "python");
$char = 'p';
proc($char, @list);

@list = ("abc", "def", "bbb", "bcd");
$char = "b";
proc($char, @list);

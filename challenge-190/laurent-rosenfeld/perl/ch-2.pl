use strict;
use warnings;
use feature qw/say/;

my @result;
my $i = 1;
my %map = map { $i++ => $_ } 'A'..'Z';

sub decode {
    my @list = @{$_[0]};
    my $out = $_[1];
    push @result, $out and return if scalar @list == 0;
    if ($list[0] != 0) {
        decode ([@list[1..$#list]], $out . $map{$list[0]});
        return if scalar @list == 1;
        if ($list[0] == 1 or ($list[0] == 2 and $list[1] <= 6)) {
            decode ([@list[2..$#list]], $out . $map{$list[0] . $list[1]});
        }
    }
}

for my $num (11, 1115, 5115, 127, 1207) {
    my @digits = split //, $num;
    @result = ();
    decode [@digits], "";
    say "$num \t -> ", join ", ", @result;
}

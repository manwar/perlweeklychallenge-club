use v6;

constant target = 11;
my $nums = Set.new(1, 2, 3, 4, 6);
my %rings =
    blue   => 8,
    yellow => 7,
    green  => 5,
    red    => 9,
    black  => 0
;

my @ring-sequences = ["red", "green"], ["blue", "yellow"];
my @black-vals;

for @ring-sequences -> @seq {
    my $diff = 0;
    for @seq -> $ring {
        %rings{$ring} += $diff;
        say "Added $diff to $ring ring" if $diff;
        $diff = target - %rings{$ring};
    die "No way" unless $nums{$diff};
        say "Added $diff to $ring ring";
        %rings{$ring} += $diff;
    }
    %rings{'black'} += $diff;
    push @black-vals, $diff;
}
my $black_diff = target - %rings{'black'};
die "No way" unless $nums{$black_diff}:exists;
push @black-vals, $black_diff;
%rings{'black'} += $black_diff;
say "Added @black-vals[] to black ring";
say "\nFinal ring values:";
say "$_\t%rings{$_}" for keys %rings;

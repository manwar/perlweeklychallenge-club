use v5.38;

sub proc($melody) {
    say "Input: \$melody = $$melody[0], @{$$melody[1]}, @{$$melody[2]}";
    my $composer = $$melody[0];
    my @orig = @{$$melody[1]};
    my @order = map {$_ - 1} @{$$melody[2]};
    my @list;
    for my $i (0 .. $#orig) {
	$list[$order[$i]] = $orig[$i];
    }
    
    say "Output: $composer => @list";
}

my $melody = ['Mozart', [qw(C D E F G A B)], [7, 1, 6, 2, 5, 3, 4]];
proc($melody);
$melody = ['Chopin', [qw(C C# D D# E F)], [6, 5, 4, 3, 2, 1]];
proc($melody);
$melody = ['Vivaldi', [qw(A B C D E)], [1, 2, 3, 4, 5]];
proc($melody);
$melody = ['Debussy', [qw(C D F G A)], [1, 3, 5, 2, 4]];
proc($melody);
$melody = ['Stravinsky', [qw(C#)], [1]];
proc($melody);

use v6;

sub proc(@melody) {
    my $composer = @melody[0];
    my @orig = |@melody[1];
    my @order = map {$_ - 1}, |@melody[2];
    say "Input: $composer, ", @orig, " ", @melody[2];
    my @list;
    for 0 .. @orig.end -> $i {
	@list[@order[$i]] = @orig[$i];
    }
    say "Output: $composer => ", @list;
}

my @melody = ['Mozart', <C D E F G A B>, [7, 1, 6, 2, 5, 3, 4]];
proc(@melody);
@melody = ['Chopin', <C C# D D# E F>, [6, 5, 4, 3, 2, 1]];
proc(@melody);
@melody = ['Vivaldi', <A B C D E>, [1, 2, 3, 4, 5]];
proc(@melody);
@melody = ['Debussy', <C D F G A>, [1, 3, 5, 2, 4]];
proc(@melody);
@melody = ['Stravinsky', <C#>, [1]];
proc(@melody);

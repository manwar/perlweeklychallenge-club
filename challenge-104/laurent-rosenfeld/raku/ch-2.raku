use v6;

my $heap-count = 12;
my $max-picks = 3;

my $who-starts = prompt "Please say who starts (Y/I) ";
if $who-starts eq "Y" {
    $heap-count -= prompt "There are $heap-count tokens. How many tokens do you pick? "
}
loop {
    if $heap-count <= $max-picks {
        say "I win by picking $heap-count tokens!";
        last;
    } else {
        my $pick = (1..$max-picks).pick;
        say "I picked $pick tokens.";
        $heap-count -= $pick;
        $heap-count -= prompt "$heap-count tokens left. How many tokens do you pick? ";
        if $heap-count == 0 {
            say "You won!";
            last;
        }
    }
}

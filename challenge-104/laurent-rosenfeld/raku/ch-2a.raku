use v6;

my $heap-count = 12;
my $max-picks = 3;

my $who-starts = prompt "Please say who starts (Y/I) ";
if $who-starts eq "Y" {
    $heap-count -= prompt "There are $heap-count tokens. How many tokens do you pick? "
}
loop {
    my $pick = $heap-count % ($max-picks + 1);
    $pick = (1..$max-picks).pick if $pick == 0;
    say "I pick $pick items";
    $heap-count -= $pick;
    if $heap-count == 0 {
        say "I won!";
        last;
    }
    $heap-count -= prompt "$heap-count tokens left. How many tokens do you pick? ";
    if $heap-count == 0 {
        say "You won!";
        last;
    }
}

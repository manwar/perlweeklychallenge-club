use strict;
use warnings;
use feature "say";

my $heap_count = 12;
my $max_picks = 3;
say "Please say who starts (Y/I) ";
my $who_starts = <STDIN>;
chomp $who_starts;
if ($who_starts eq "Y") {
    my $pick = pick_one_val ($heap_count);
    $heap_count -= $pick;
}
while (1) {
    my $pick = $heap_count % ($max_picks + 1);
    $pick = int(rand(3)) + 1 if ($pick == 0);
    say "I picked $pick tokens.";
    $heap_count -= $pick;
    if ($heap_count == 0) {
        say "I won!";
        last;
    }
    $pick = pick_one_val ($heap_count);
    $heap_count -= $pick;
    if ($heap_count == 0) {
        say "You won!";
        last;
    }
}
sub pick_one_val {
    my $count = shift;
    say "There are $count tokens left. How many tokens do you pick? ";
    my $pick = <STDIN>;
    chomp $pick;
    return $pick;
}

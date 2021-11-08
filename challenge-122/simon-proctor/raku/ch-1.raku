#!/usr/bin/env raku

sub avg($avg,$val) {
    state $count = 1;
    my $sum = $avg*$count;
    $sum += $val;
    $count++;
    $sum / $count;
}

#| Given a list of numbers print the average of the list with each point in the list
multi sub MAIN( *@N ) {
    ( [\[&avg]] @N ).join(", ").say;
}

#| Read from STDIN and output the running average after each number
multi sub MAIN() {
    .say for [\[&avg]] $*IN.lines;
}

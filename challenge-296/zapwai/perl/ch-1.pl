use v5.38;
sub proc(@chars) {
    say "Input: \@chars = @chars";
    my %h;
    $h{$_}++ for (@chars);
    print "Output: ";
    print $_, $h{$_} for (sort keys %h);
    say "";
}

my @chars = ("a", "b", "b", "c");
proc(@chars);
@chars = ("a", "a", "a", "b", "c", "c", "c");
proc(@chars);
@chars = ("a", "b", "c", "c");
proc(@chars);

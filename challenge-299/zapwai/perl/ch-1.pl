use v5.38;
sub proc($sent, @words) {
    say "Input: \@words = (" . join(", ", @words) . ")";
    say "\t\$sentence = $sent";
    my $output_sent;
    for my $s (split(" ", $sent)) {
        for my $w (@words){
            if ($s =~ /^$w/) {
                $s = $w;
                last;
            }
        }
        $output_sent .= "$s ";
    }
    say "Output: $output_sent";
}
my @words = ("cat", "bat", "rat");
my $sent = "the cattle was rattle by the battery";
proc($sent, @words);
@words = qw( a b c );
$sent = "aab aac and cac bab";
proc($sent, @words);
@words = qw( man bike );
$sent = "the manager was hit by a biker";
proc($sent, @words);

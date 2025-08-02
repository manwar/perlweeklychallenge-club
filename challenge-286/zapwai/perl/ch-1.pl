open my $fh, "<$0";
my @words;
while (<$fh>) {
    push @words, split " ", $_;
}
close $fh;
print $words[int rand(@words)]."\n";

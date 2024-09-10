open my $fh, '<', $0 or die;
my @words = map /\S+/g, <$fh>;
print $words[rand(0+@words)], "\n";

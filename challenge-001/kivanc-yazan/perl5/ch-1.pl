my $word = "Perl Weekly Challenge";
my $char = $ARGV[0] // 'x';
print "$word: e's will be replaced with $char\n";
my $replace_count = ($word =~ s/e/$char/g);
print "$word: $replace_count many e's are gone\n";

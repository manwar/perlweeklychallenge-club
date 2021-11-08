perl -E '$_ = [grep {$_ !~ /1/} (1..$ARGV[0])]; say scalar @{$_}, "\n", "@{$_}"' 126

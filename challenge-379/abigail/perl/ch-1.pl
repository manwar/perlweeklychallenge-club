#!/opt/perl/bin/perl

while (<>) {{s/(.)(\n.*)/$2$1/&&redo};print s/\n(.*)/$1\n/r}

__END__

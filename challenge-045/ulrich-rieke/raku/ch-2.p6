use v6 ;

my $fh = open $?FILE , :r ;
.say for $fh.lines ;
close $fh ;

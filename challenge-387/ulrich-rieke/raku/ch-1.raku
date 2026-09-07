use v6 ;

say "Enter a binary string!" ;
my $binary = $*IN.get ;
my $steps = 0 ;
while ( $binary ~~ /01/ ) {
   $binary ~~ s:g/01/10/ ;
   $steps++ ;
}
$steps.say ;


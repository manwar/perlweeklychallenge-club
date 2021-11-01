#!/Applications/Rakudo/bin/raku
#
#
#       dont-get-too-friendly.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

use Test;

is is_creepy( 8, 24 ),  1,  'ex-1';
is is_creepy( 26, 39 ), 0,  'ex-2';
is is_creepy( 4, 10 ),  1,  'ex-3';

is is_creepy( 60, 70 ),  0,  't-1';



sub is_creepy ( $m is copy, $n is copy ) {
## is $m too friendly towards $n? Does it need to BTFO? Boundaries, people!
    my $g = $m gcd $n;
    $g   /= 2  while $g %% 2;                          
    $g > 1  ?? 0 
            !! 1;
}






say "\n\n";


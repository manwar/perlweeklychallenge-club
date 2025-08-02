use strict; use warnings;

sub f {
    my( $str, $char ) = @_;
    $str =~ s{ .* $char }{ join '', sort $& =~ /./g }sxer
}


#----------testing
use Test::More tests=>3;
ok f(@{$$_{input}}), $$_{output} for
    { input=> ["challenge", "e"],   output=> "acehllnge" },
    { input=> ["programming", "a"], output=> "agoprrmming" },
    { input=> ["champion", "b"],    output=> "champion" };

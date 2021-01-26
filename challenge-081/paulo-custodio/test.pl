#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use 5.030;

is capture("perl/ch-1.pl abcdabcd abcdabcdabcdabcd"), <<END;
("abcd", "abcdabcd")
END
is capture("perl/ch-1.pl aaa aa"), <<END;
("a")
END


is capture("perl/ch-2.pl input"), <<END;
1 But City It Jet Juliet Latino New Romeo Side Story Their Then West York adaptation any anything at award-winning away become before begin best classic climactic coexist control dance do doesn't end ending escalates families feuding form former friend gains gangs goes happened hatred heartbreaking highway hoping in know love lovers meet meeting neither no one plan planning point romantic rumble run secret sends sister streets strikes terribly their two under understanding until violence warring what when where white whoever wins with wrong younger

2 Bernardo Jets Riff Sharks The by it led tragedy

3 Maria Tony a can of stop

4 to

9 and the

END


done_testing;

sub capture {
    my($cmd) = @_;
    my $out = `$cmd`;
    $out =~ s/\r//g;
    return $out;
}

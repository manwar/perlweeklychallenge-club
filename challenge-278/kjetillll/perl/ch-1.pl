use strict; use warnings;

sub f {
    my $str = shift;
    my $pos = shift//1;
    my @words = @_;
    $str =~ s/ ([^\s\d]+) $pos \b //x
        ? f($str, $pos+1, @words, $1)
        : "@words"
}


#----------testing
use Test::More tests=>3;
ok f($$_{input}) eq $$_{output}, f($$_{input}) for
    {  input => "and2 Raku3 cousins5 Perl1 are4",
       output => "Perl and Raku are cousins" },
    {  input => "guest6 Python1 most4 the3 popular5 is2 language7",
       output => "Python is the most popular guest language" },
    {  input => "Challenge3 The1 Weekly2",
       output => "The Weekly Challenge" };

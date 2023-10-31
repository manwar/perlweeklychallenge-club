use Test;

sub is-acronym(Str $chk, @words) returns Bool {
    my $acronym = @words.map({ .substr(0, 1).lc }).join('');
    return $acronym eq $chk.lc;
}

plan 3;

ok is-acronym("ppp", ["Perl", "Python", "Pascal"]), 'Test Case 1';
ok !is-acronym("rp", ["Perl", "Raku"]), 'Test Case 2';
ok is-acronym("oac", ["Oracle", "Awk", "C"]), 'Test Case 3';

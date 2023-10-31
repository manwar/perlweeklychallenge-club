use Test;
sub ch1{([~] @^a.map({.substr(0,1)})).lc===$^b}

plan 3;

ok ch1( ["Perl", "Python", "Pascal"], "ppp"), 'Test Case 1';
ok !ch1(["Perl", "Raku"], "rp"), 'Test Case 2';
ok ch1(["Oracle", "Awk", "C"], "oac"), 'Test Case 3';

# Raku code for "Same String" problem

use Test;

sub same-string(@arr1, @arr2) {
	return @arr1.join("") eq @arr2.join("");
}

ok(same-string(["ab", "c"], ["a", "bc"]), "Test case 1");
ok(!same-string(["ab", "c"], ["ac", "b"]), "Test case 2");
ok(same-string(["ab", "cd", "e"], ["abcde"]), "Test case 3");

done-testing();


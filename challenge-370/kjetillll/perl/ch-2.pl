use List::Util 'any';
use Memoize;
memoize 'eq_scrambled';  # speeds up for longer strings, ~ 150x for length 14

sub eq_scrambled {
    my($a, $b) = @_;
    length($a) == 1 ? $a eq $b :
    any {
        my($a1, $a2) = ( substr($a,0,$_), substr($a,$_) );
        my($b1, $b2) = ( substr($b,0,$_), substr($b,$_) );
        eq_scrambled($a1, $b1) and
        eq_scrambled($a2, $b2)
            or
        eq_scrambled($a2, substr($b, 0, length($a2)) ) and
        eq_scrambled($a1, substr($b, -length($a1)))
    }
    1 .. length($a) - 1
}

print pop(@$_) == eq_scrambled(@$_) ? "ok\n" : "ERROR\n" for
[ "abc",   "acb"   => 1 ],
[ "abcd",  "cdba"  => 1 ],
[ "hello", "hiiii" => 0 ],
[ "ateer", "eater" => 1 ],
[ "abcd",  "bdac"  => 0 ],
[ 'gcneadlimbkjhf', 'imkbljdeahnfcg' => 1 ],
[ 'defghjmancklib', 'hjnmelkafcidbg' => 0 ];

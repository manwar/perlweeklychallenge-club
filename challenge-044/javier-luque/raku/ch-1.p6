use v6.d;
use MONKEY-SEE-NO-EVAL;

sub MAIN() {
    my $numbers = '123456789';
    check-numbers('', $numbers, 100);
}

sub check-numbers(Str $n, $nums, Int $goal) {
    if ($nums) {
        my ($n2, $new_numbers) = $nums.split("", 2, :skip-empty);
        check-numbers($n ~ '+' ~ $n2, $new_numbers, $goal);
        check-numbers($n ~ '-' ~ $n2, $new_numbers, $goal);
        check-numbers($n ~ $n2, $new_numbers, $goal);
    } else {
        my $total = EVAL $n; #too lazy to do this better
        say $n if ($total == $goal);
    }
}

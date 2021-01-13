# You are given two positive numbers $N and $S.
#
# Write a script to list all positive numbers having exactly $N digits where
# sum of all digits equals to $S.
#
# Example
#
# Input:
#     $N = 2
#     $S = 4
#
# Output:
#     13, 22, 31, 40

sub digits-sum($N, $S) {
    ([X] ((1..9), |(^9 xx ^($N-1)))).grep({ ([+] $_) eq $S; }).map({ [~] $_ });
}

digits-sum(2, 4).say;

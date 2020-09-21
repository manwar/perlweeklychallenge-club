my @A = 9, 10, 7, 5, 6, 1;
say gather for @A {
    .take if $_ after all @A[++$ .. *];
}

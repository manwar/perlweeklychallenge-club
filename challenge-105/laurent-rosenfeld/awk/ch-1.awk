# run e.g. as: $ awk -v input=120 -f root.awk
BEGIN {
    for (i = 1; i <= 10; i++) {
        printf "%2i    ¨%10.3f\n", i, input ** (1/i);
    }
}

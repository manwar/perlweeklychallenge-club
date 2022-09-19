int reverse(int n) {
    char st[10];
    char r[10];
    int len = sprintf(st, "%d", n);   // convert input int to string
    for (int i = 0; i < len; i++) {
        r[len - i - 1] = st[i];
    }
    r[len] = '\0';
    return atoi(r);
}

int is_reversible(int n) {
    char sum[10];
    int length =  sprintf(sum, "%d", n + reverse(n));
    for (int k = 0; k < length; k++) {
        if (sum[k] % 2 == 0) {
            return 0;
        }
    }
    return 1;
}

int main () {
    for (int i = 1; i < 100; i++) {
        if (is_reversible(i)) {
            printf("%d ", i);
        }
    }
    printf("%s\n", "");
}

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_palindrome(int n) {
    char num[32];
    sprintf(num, "%d", n);
    int len = strlen(num);
    for (int i = 0; i < len/2; i++) {
        if (num[i] != num[len-1-i])
            return false;
    }
    return true;
}

int closest_palindrome(int n) {
    for (int i = 1; i < n; i++) {
        if (is_palindrome(n-i))
            return n-i;
        if (is_palindrome(n+i))
            return n+i;
    }
    return -1;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);
    int n = closest_palindrome(atoi(argv[1]));
    printf("%d\n", n);
}

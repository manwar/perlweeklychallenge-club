// Perl Weekly Challenge 179 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-179/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

/* ---------- word tables ---------- */

static const char *cardinal_0_19[] = {
    "zero","one","two","three","four","five","six","seven","eight","nine",
    "ten","eleven","twelve","thirteen","fourteen","fifteen","sixteen",
    "seventeen","eighteen","nineteen"
};

static const char *ordinal_0_19[] = {
    "zeroth","first","second","third","fourth","fifth","sixth","seventh",
    "eighth","ninth","tenth","eleventh","twelfth","thirteenth","fourteenth",
    "fifteenth","sixteenth","seventeenth","eighteenth","nineteenth"
};

static const char *tens_cardinal[] = {
    NULL, NULL,
    "twenty","thirty","forty","fifty",
    "sixty","seventy","eighty","ninety"
};

static const char *tens_ordinal[] = {
    NULL, NULL,
    "twentieth","thirtieth","fortieth","fiftieth",
    "sixtieth","seventieth","eightieth","ninetieth"
};

static const char *scale_cardinal[] = {
    NULL,
    "thousand",
    "million",
    "billion",
    "trillion"
};

static const char *scale_ordinal[] = {
    NULL,
    "thousandth",
    "millionth",
    "billionth",
    "trillionth"
};

/* ---------- helpers ---------- */

static void append(Str *dst, const char *src) {
    if (dst->size > 0) str_append(dst, "-");
    str_append(dst, src);
}

/* Converts numbers < 1000
   ordinal_tail == 1 ? make ordinal
*/
static void convert_sub_1000(int n, int ordinal_tail, Str *out) {
    if (n >= 100) {
        append(out, cardinal_0_19[n / 100]);
        append(out, "hundred");

        if (n % 100 == 0) {
            if (ordinal_tail) str_append(out, "th");
            return;
        }
        append(out, "and");
        n %= 100;
    }

    if (n < 20) {
        append(out, ordinal_tail ? ordinal_0_19[n]
                                 : cardinal_0_19[n]);
    } else {
        int t = n / 10;
        int u = n % 10;

        if (u == 0) {
            append(out, ordinal_tail ? tens_ordinal[t]
                                     : tens_cardinal[t]);
        } else {
            append(out, tens_cardinal[t]);
            append(out, ordinal_tail ? ordinal_0_19[u]
                                     : cardinal_0_19[u]);
        }
    }
}

/* ---------- public API ---------- */

void english_ordinal(long long n, Str *out) {
    if (n == 0) {
        str_append(out, "zeroth");
        return;
    }

    int parts[5] = {0};
    int count = 0;

    while (n > 0 && count < 5) {
        parts[count++] = n % 1000;
        n /= 1000;
    }

    int last_nonzero = -1;
    for (int i = 0; i < count; ++i) {
        if (parts[i] != 0) {
            last_nonzero = i;
        }
    }

    int ordinal_done = 0;

    for (int i = count - 1; i >= 0; --i) {
        if (parts[i] == 0) continue;

        int is_last = !ordinal_done && (i == last_nonzero);

        Str* temp = str_new();
        convert_sub_1000(parts[i], is_last, temp);
        append(out, temp->body);
        str_free(temp);

        if (i > 0) {
            append(out, is_last ? scale_ordinal[i]
                                : scale_cardinal[i]);
        }

        if (is_last) ordinal_done = 1;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    long long n = atoll(argv[1]);
    Str* ordinal = str_new();
    english_ordinal(n, ordinal);
    printf("%s\n", ordinal->body);
    str_free(ordinal);
}

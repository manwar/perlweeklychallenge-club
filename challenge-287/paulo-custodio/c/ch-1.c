#include "alloc.h"

#define MIN_LENGTH      6
#define MAX_REPEATED    2

bool has_digit(const char* pass) {
    for (const char* p = pass; *p; p++) {
        if (isdigit(*p))
            return true;
    }
    return false;
}

bool has_upper(const char* pass) {
    for (const char* p = pass; *p; p++) {
        if (*p >= 'A' && *p <= 'Z')
            return true;
    }
    return false;
}

bool has_lower(const char* pass) {
    for (const char* p = pass; *p; p++) {
        if (*p >= 'a' && *p <= 'z')
            return true;
    }
    return false;
}

const char* repeated_chars(const char* pass) {
    const char* p = pass;
    while (*p) {
        const char* q = p;
        while (*q == *p)
            q++;
        if (q - p > MAX_REPEATED)
            return p;
        p = q;
    }
    return NULL;
}

bool is_strong(const char* pass) {
    return strlen(pass) >= MIN_LENGTH &&
           has_digit(pass) &&
           has_upper(pass) &&
           has_lower(pass) &&
           repeated_chars(pass) == NULL;
}

char next_char(const char* pass) {
    // return classes we don't have
    if (!has_digit(pass)) {
        for (char c = '0'; c <= '9'; c++) {
            if (strchr(pass, c) == NULL)
                return c;
        }
    }

    if (!has_upper(pass)) {
        for (char c = 'A'; c <= 'Z'; c++) {
            if (strchr(pass, c) == NULL)
                return c;
        }
    }

    if (!has_lower(pass)) {
        for (char c = 'a'; c <= 'z'; c++) {
            if (strchr(pass, c) == NULL)
                return c;
        }
    }

    // return first we don't have from any class
    for (char c = '0'; c <= '9'; c++) {
        if (strchr(pass, c) == NULL)
            return c;
    }
    for (char c = 'A'; c <= 'Z'; c++) {
        if (strchr(pass, c) == NULL)
            return c;
    }
    for (char c = 'a'; c <= 'z'; c++) {
        if (strchr(pass, c) == NULL)
            return c;
    }

    return '\0';    // not reached
}

int steps_to_strong(const char* pass_) {
    Str* pass = str_new();
    str_append(pass, pass_);

    int steps = 0;
    while (!is_strong(pass->body)) {
        char ch = next_char(pass->body);
        const char* p = repeated_chars(pass->body);
        if (p != NULL) {
            p += MAX_REPEATED;          // must insert char after the second repeated one
            int pos = p - pass->body;   // str_append may invalidate p
            int move_len = strlen(p)+1; // include '\0'
            str_append(pass, " ");      // make space
            memmove(pass->body+pos+1, pass->body+pos, move_len);
            pass->body[pos] = ch;
        }
        else {
            str_printf(pass, "%c", ch);
        }
        steps++;
    }

    str_free(pass);
    return steps;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s pass", argv[0]);

    int steps = steps_to_strong(argv[1]);
    printf("%d\n", steps);
}

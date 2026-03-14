#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool parse_sign(const char** p) {
    if (**p == '+' || **p == '-') {
        (*p)++;
        return true;
    }
    return false;
}

bool parse_int(const char** p) {
    if (isdigit(**p)) {
        while (isdigit(**p))
            (*p)++;
        return true;
    }
    return false;
}

bool parse_dot(const char** p) {
    if (**p == '.') {
        (*p)++;
        return true;
    }
    return false;
}

bool parse_e(const char** p) {
    if (**p == 'e' || **p == 'E') {
        (*p)++;
        return true;
    }
    return false;
}

bool at_end(const char** p) {
    if (**p == '\0')
        return true;
    return false;
}

bool parse_mantissa(const char** p) {
    parse_sign(p);

    const char* q = *p;
    if (parse_int(&q) && parse_dot(&q)) {
        parse_int(&q);
        *p = q;
        return true;
    }

    q = *p;
    parse_int(&q);
    if (parse_dot(&q) && parse_int(&q)) {
        *p = q;
        return true;
    }

    q = *p;
    if (parse_int(&q)) {
        *p = q;
        return true;
    }

    return false;
}

bool parse_exponent(const char** p) {
    if (!parse_e(p))
        return true;
    parse_sign(p);
    return parse_int(p);
}

bool is_valid_number(const char* number) {
    const char* p = number;
    return parse_mantissa(&p) && parse_exponent(&p) && at_end(&p);
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s number", argv[0]);

    bool ok = is_valid_number(argv[1]);
    printf("%s\n", bool_to_string(ok));
}

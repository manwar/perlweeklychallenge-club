#include "alloc.h"

Str* rle_encode(const char* str) {
    Str* encoded = str_new();
    for (const char* p = str; *p; p++) {
        if (p[0] == p[1]) {
            const char* q = p;
            while (*q == *p)
                q++;
            int len = q - p;
            if (len > 9)
                len = 9;
            str_printf(encoded, "%d%c", len, *p);
            p += len-1;
        }
        else {
            str_printf(encoded, "%c", *p);
        }
    }
    return encoded;
}

Str* rle_decode(const char* str) {
    Str* decoded = str_new();
    for (const char* p = str; *p; p++) {
        if (isdigit(p[0]) && p[1] != '\0') {
            for (int j = 0; j < p[0]-'0'; j++)
                str_printf(decoded, "%c", p[1]);
            p++;
        }
        else {
            str_printf(decoded, "%c", *p);
        }
    }
    return decoded;
}

int main(int argc, char* argv[]) {
    bool decode = false;
    const char* input = "";
    if (argc == 3 && strcmp(argv[1], "-d") == 0) {
        decode = true;
        input = argv[2];
    }
    else if (argc == 2) {
        input = argv[1];
    }
    else {
        die("usage: %s [-d] string", argv[0]);
    }

    Str* output = NULL;
    if (decode)
        output = rle_decode(input);
    else
        output = rle_encode(input);

    printf("%s\n", output->body);

    str_free(output);
}

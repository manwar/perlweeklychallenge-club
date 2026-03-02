#include "alloc.h"

int max_contiguous_01(const char* text) {
    int max_len = 0;
    for (int start = 0; start < strlen(text); start++) {
        for (int len = 1; start+len <= strlen(text); len++) {
            int count[2] = {0};
            for (int i = start; i < strlen(text) && i < start+len; i++) {
                if (text[i] == '0') count[0]++;
                else if (text[i] == '1') count[1]++;
            }
            if (count[0] == count[1]) {
                max_len = MAX(max_len, len);
            }
        }
    }
    return max_len;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s binary...\n", argv[0]);

    Str* binstr = str_new();
    for (int i = 1; i < argc; i++)
        str_append(binstr, argv[i]);

    int max_len = max_contiguous_01(binstr->body);
    printf("%d\n", max_len);

    str_free(binstr);
}

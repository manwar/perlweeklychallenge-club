#include "alloc.h"

Str* format_string(const char* input, int group_size) {
    // remove all dashes
    Str* compressed = str_new();
    str_append(compressed, input);
    int w = 0;
    for (int r = 0; compressed->body[r] != '\0'; r++) {
        if (compressed->body[r] != '-')
            compressed->body[w++] = compressed->body[r];
    }
    compressed->body[w] = '\0';
    str_sync_size(compressed);

    // create output string
    Str* output = str_new();
    int group = compressed->size % group_size;
    for (int r = 0; compressed->body[r] != '\0'; r++) {
        if (group == 0) {
            if (r != 0)
                str_append(output, "-");
            group = group_size;
        }
        str_printf(output, "%c", compressed->body[r]);
        group--;
    }

    str_free(compressed);
    return output;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s string n", argv[0]);

    Str* formatted = format_string(argv[1], atoi(argv[2]));
    printf("%s\n", formatted->body);
    str_free(formatted);
}

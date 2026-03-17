#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define SEEN ' '

int size_block(StrArray* m, int r, int c, char ch) {
    m->data[r][c] = SEEN;
    int count = 1;
    if (r-1 >= 0 && m->data[r-1][c] == ch)
        count += size_block(m, r-1, c, ch);

    if (r+1 < m->size && m->data[r+1][c] == ch)
        count += size_block(m, r+1, c, ch);

    if (c-1 >= 0 && m->data[r][c-1] == ch)
        count += size_block(m, r, c-1, ch);

    if (c+1 < strlen(m->data[r]) && m->data[r][c+1] == ch)
        count += size_block(m, r, c+1, ch);

    return count;
}

int size_max_block(StrArray* m) {
    int max_size = 0;
    for (int r = 0; r < m->size; r++) {
        for (int c = 0; c < strlen(m->data[r]); c++) {
            if (m->data[r][c] != SEEN) {
                int size = size_block(m, r, c, m->data[r][c]);
                max_size = MAX(max_size, size);
            }
        }
    }
    return max_size;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s row row...", argv[0]);

    StrArray* m = strarray_new();
    for (int i = 1; i < argc; i++)
        strarray_push_back(m, argv[i]);

    int size = size_max_block(m);
    printf("%d\n", size);

    strarray_free(m);
}

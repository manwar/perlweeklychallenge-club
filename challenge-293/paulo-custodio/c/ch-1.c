#include "alloc.h"

typedef struct {
    int a;
    int b;
} Piece;

Piece piece_parse(const char* str) {
    Piece p;
    sscanf(str, "%d %d", &p.a, &p.b);
    return p;
}

bool piece_equal(Piece p1, Piece p2) {
    return (p1.a==p2.a && p1.b==p2.b) ||
           (p1.a==p2.b && p1.b==p2.a);
}

int count_equal(int count, Piece* dominos) {
    int equal = 0;
    for (int i = 0; i < count; i++) {
        bool has_equal = false;
        for (int j = 0; j < count; j++) {
            if (i != j && piece_equal(dominos[i], dominos[j])) {
                has_equal = true;
                break;
            }
        }
        if (has_equal)
            equal++;
    }
    return equal;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s 'n n' 'n n'...", argv[0]);

    argc--; argv++;
    Piece* dominos = xcalloc(argc, sizeof(Piece));
    for (int i = 0; i < argc; i++)
        dominos[i] = piece_parse(argv[i]);

    int equal = count_equal(argc, dominos);
    printf("%d\n", equal);

    xfree(dominos);
}

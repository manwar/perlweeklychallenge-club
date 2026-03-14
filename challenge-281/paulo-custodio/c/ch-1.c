#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_white(const char* coord) {
    if (strlen(coord) != 2 || coord[0] < 'a' || coord[0] > 'h' || coord[1] < '1' || coord[1] > '8')
        die("invalid coordinate: %s", coord);

    int col = coord[0] - 'a';
    int row = coord[1] - '1';

    bool white = (col & 1) ^ (row & 1);
    return white;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s coord", argv[0]);

    bool white = is_white(argv[1]);
    printf("%s\n", bool_to_string(white));
}

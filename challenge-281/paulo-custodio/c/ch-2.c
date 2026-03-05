#include "alloc.h"

#define LAST_POS(path) ((path) + strlen(path) - 2)

typedef struct {
    int row;
    int col;
} Coord;

Coord str_to_coord(const char* coord) {
    if (strlen(coord) != 2 || coord[0] < 'a' || coord[0] > 'h' || coord[1] < '1' || coord[1] > '8')
        die("invalid coordinate: %s", coord);

    Coord rc;
    rc.row = coord[1] - '1';
    rc.col = coord[0] - 'a';
    return rc;
}

// NOTE: not reentrant
const char* coord_to_str(Coord rc) {
    static char coord[3] = {0};
    if (rc.col < 0 || rc.col > 7 || rc.row < 0 || rc.row > 7) {
        coord[0] = '\0';    // return empty string
        return coord;
    }
    else {
        coord[0] = 'a' + rc.col;
        coord[1] = '1' + rc.row;
        coord[2] = '\0';
        return coord;
    }
}

void push_move(int delta_row, int delta_col, const char* path, StrArray* paths) {
    const char* last_pos = LAST_POS(path);
    Coord last_coord = str_to_coord(last_pos);

    Coord next_coord;
    next_coord.row = last_coord.row + delta_row;
    next_coord.col = last_coord.col + delta_col;

    const char* next_pos = coord_to_str(next_coord);
    if (strlen(next_pos) == 0)              // invalid coordinate
        return;

    if (strstr(path, next_pos) != NULL)     // already been there
        return;

    Str* new_path = str_new();
    str_printf(new_path, "%s%s", path, next_pos);
    strarray_push_back(paths, new_path->body);
    str_free(new_path);
}

void push_knight_move(const char* path, StrArray* paths) {
    push_move(-2, -1, path, paths);
    push_move(-2, +1, path, paths);
    push_move(+2, -1, path, paths);
    push_move(+2, +1, path, paths);
    push_move(-1, -2, path, paths);
    push_move(+1, -2, path, paths);
    push_move(-1, +2, path, paths);
    push_move(+1, +2, path, paths);
}

int find_path_size(const char* start, const char* end) {
    // validate input
    Coord x;
    x = str_to_coord(start);
    x = str_to_coord(end);

    // check trivial solution
    if (strcmp(start, end) == 0)
        return 0;

    // minimum path up to now
    int min_path_len = INT_MAX;

    // create task list
    StrArray* paths = strarray_new();
    strarray_push_back(paths, start);
    while (paths->size > 0) {
        // get first from task list
        char* path = xstrdup(paths->data[0]);
        strarray_erase(paths, 0);

        // check if we have a solution
        int path_len = strlen(path) / 2;
        const char* last = LAST_POS(path);
        if (strcmp(last, end) == 0) {
            min_path_len = MIN(min_path_len, path_len);
            xfree(path);
            continue;
        }

        // prune the tree
        if (path_len > min_path_len) {
            xfree(path);
            continue;
        }

        // find next 8 positions and push them to paths
        push_knight_move(path, paths);
        xfree(path);
    }

    strarray_free(paths);
    return min_path_len - 1;        // don't count start position
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s start end", argv[0]);

    int len = find_path_size(argv[1], argv[2]);
    printf("%d\n", len);
}

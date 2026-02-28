#include "alloc.h"

void remove_spaces(char* text) {
    int write = 0;
    for (int read = 0; text[read] != '\0'; read++) {
        if (!isspace(text[read]))
            text[write++] = text[read];
    }
    text[write] = '\0';
}

StrArray* parse_grid() {
    StrArray* grid = strarray_new();
    char line[BUFSIZ];
    while (fgets(line, sizeof(line), stdin)) {
        remove_spaces(line);
        if (strlen(line) == 0)
            break;
        strarray_push_back(grid, line);
    }
    return grid;
}

Str* parse_word() {
    char line[BUFSIZ];
    if (!fgets(line, sizeof(line), stdin))
        die("insufficient data");
    StrArray* words = strarray_parse_list(line);
    if (words->size != 1)
        die("insufficient data");
    Str* word = str_new();
    str_append(word, words->data[0]);
    strarray_free(words);
    return word;
}

bool find_word_at(const char* word, int x, int y, StrArray* grid) {
    if (strlen(word) == 0)
        return true;

    if (y < 0 || y >= grid->size)
        return false;

    if (x < 0 || x >= strlen(grid->data[y]))
        return false;

    char ch = grid->data[y][x];
    if (word[0] != ch)
        return false;

    grid->data[y][x] = ' ';
    bool found = false;

    if (!found && find_word_at(word+1, x-1, y,  grid)) found = true;
    if (!found && find_word_at(word+1, x+1, y,  grid)) found = true;
    if (!found && find_word_at(word+1, x, y-1,  grid)) found = true;
    if (!found && find_word_at(word+1, x, y+1,  grid)) found = true;

    grid->data[y][x] = ch;
    return found;
}

bool find_word(const char* word, StrArray* grid) {
    for (int y = 0; y < grid->size; y++) {
        for (int x = 0; x < strlen(grid->data[y]); x++) {
            if (find_word_at(word, x, y, grid))
                return true;
        }
    }
    return false;
}

int main() {
    StrArray* grid = parse_grid();
    Str* word = parse_word();
    bool found = find_word(word->body, grid);
    printf("%s\n", bool_to_string(found));
    strarray_free(grid);
    str_free(word);
}

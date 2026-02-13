#include "alloc.h"
#include <ctype.h>

typedef struct {
    bool** results;
    int size;
} Table;

Table* alloc_table(int size) {
    Table* table = xmalloc(sizeof(Table));
    table->results = xmalloc(size * sizeof(bool*));

    for (int i = 0; i < size; i++) {
        table->results[i] = xcalloc(size, sizeof(bool));
    }

    table->size = size;
    return table;
}

void free_table(Table* table) {
    for (int i = 0; i < table->size; i++)
        xfree(table->results[i]);
    xfree(table->results);
    xfree(table);
}

int compress_bool(char* str) {
    char* from = str;
    char* to = str;
    while (*from) {
        if (isspace(*from)) {
            from++;
            continue;
        }
        if (*from == '0' || *from == '1') {
            *to++ = *from++;
            continue;
        }
        fprintf(stderr, "invalid character: '%c'\n", *from);
        exit(EXIT_FAILURE);
    }
    *to = '\0';
    return to-str;
}

Table* parse_table() {
    char line[BUFSIZ];

    // parse first line
    if (!fgets(line, sizeof(line), stdin)) {
        fprintf(stderr, "unexpected end of input\n");
        exit(EXIT_FAILURE);
    }

    int size = compress_bool(line);
    Table* table = alloc_table(size);
    for (int i = 0; i < size;  i++)
        table->results[0][i] = line[i]=='1';

    // parse the other size-1 lines
    for (int i = 1; i < size; i++) {
        if (!fgets(line, sizeof(line), stdin)) {
            fprintf(stderr, "unexpected end of input\n");
            exit(EXIT_FAILURE);
        }
        int new_size = compress_bool(line);
        if (new_size != size) {
            fprintf(stderr, "inconsistent row sizes\n");
            exit(EXIT_FAILURE);
        }
        for (int j = 0; j < size;  j++)
            table->results[i][j] = line[j]=='1';
    }

    return table;
}

typedef struct {
    int team;
    int wins;
} Wins;

int compare(const void* a_, const void* b_) {
    Wins a = *(Wins*)a_;
    Wins b = *(Wins*)b_;
    return b.wins - a.wins; // descending
}

int get_champion(Table* table) {
    Wins* wins = xmalloc(table->size * sizeof(Wins));
    for (int i = 0; i < table->size; i++) {
        wins[i].team = i;
        wins[i].wins = 0;
        for (int j = 0; j < table->size; j++) {
            if (i != j) {
                wins[i].wins += table->results[i][j];
            }
        }
    }
    qsort(wins, table->size, sizeof(Wins), compare);
    int champion = wins[0].team;

    // tie break
    if (table->size > 1 && wins[0].wins == wins[1].wins) {
        if (table->results[wins[1].team][wins[0].team]) {
            champion = wins[1].team;
        }
    }

    xfree(wins);
    return champion;
}

int main() {
    Table* table = parse_table();
    int champion = get_champion(table);
    printf("Team %d\n", champion);
    free_table(table);
}

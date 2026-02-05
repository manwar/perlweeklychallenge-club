#include <assert.h>
#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* list;
    int size;
} List;

void init_list(List* list) {
    list->list = NULL;
    list->size = 0;
}

void free_list(List* list) {
    free(list->list);
}

void push_list(List* list, int n) {
    list->size++;
    list->list = realloc(list->list, list->size * sizeof(int));
    assert(list->list);
    list->list[list->size-1] = n;
}

typedef struct {
    List* list;
    int size;
} LoL;

void init_lol(LoL* lol) {
    lol->list = NULL;
    lol->size = 0;
}

void free_lol(LoL* lol) {
    for (int i = 0; i < lol->size; i++)
        free_list(&(lol->list[i]));
    free(lol->list);
}

void push_lol(LoL* lol, List* list) {
    lol->size++;
    lol->list = realloc(lol->list, lol->size * sizeof(List));
    assert(lol->list);
    lol->list[lol->size-1] = *list;
}

void parse_lol(LoL* lol, const char* str) {
    lol->size = 0;
    List l;
    init_list(&l);

    const char* p = str;
    while (*p != '\0') {
        if (isspace(*p)) {
            p++;
            continue;
        }
        if (*p == ',') {
            if (l.size > 0) {
                push_lol(lol, &l);
                l.list = NULL;
                l.size = 0;
            }
            p++;
            continue;
        }
        if (isdigit(*p)) {
            int value = 0;
            while (isdigit(*p)) {
                value = value * 10 + (*p - '0');
                p++;
            }
            push_list(&l, value);
            continue;
        }
        fprintf(stderr, "invalid character: '%c'\n", *p);
        exit(EXIT_FAILURE);
    }

    if (l.size > 0) {
        push_lol(lol, &l);
        l.list = NULL;
        l.size = 0;
    }
}

void parse_list(List* list, const char* str) {
    list->size = 0;

    const char* p = str;
    while (*p != '\0') {
        if (isspace(*p)) {
            p++;
            continue;
        }
        if (isdigit(*p)) {
            int value = 0;
            while (isdigit(*p)) {
                value = value * 10 + (*p - '0');
                p++;
            }
            push_list(list, value);
            continue;
        }
        fprintf(stderr, "invalid character: '%c'\n", *p);
        exit(EXIT_FAILURE);
    }
}

bool can_make_list(LoL* lol, List* list) {
    if (list->size == 0)
        return true;

    for (int i = 0; i < lol->size; i++) {
        bool is_prefix = true;
        for (int j = 0; j < lol->list[i].size; j++) {
            if (lol->list[i].list[j] != list->list[j]) {
                is_prefix = false;
                break;
            }
        }
        if (is_prefix) { // recurse
            LoL* sub_lol = malloc(sizeof(LoL));
            assert(sub_lol);
            init_lol(sub_lol);

            List* sub_list = malloc(sizeof(List));
            assert(sub_list);
            init_list(sub_list);

            // copy lol except entry i
            for (int j = 0; j < lol->size; j++) {
                if (i == j)
                    continue;
                List new_list;
                init_list(&new_list);
                for (int k = 0; k < lol->list[j].size; k++) {
                    push_list(&new_list, lol->list[j].list[k]);
                }
                push_lol(sub_lol, &new_list);
            }

            // copy suffix of list
            for (int k = lol->list[i].size; k < list->size; k++)
                push_list(sub_list, list->list[k]);

            // recurse
            bool ok = can_make_list(sub_lol, sub_list);

            free_lol(sub_lol);
            free(sub_lol);
            free_list(sub_list);
            free(sub_list);

            if (ok)
                return ok;
        }
    }

    return false;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        fprintf(stderr, "usage: %s list_of_list list\n", stderr);
        return EXIT_FAILURE;
    }

    LoL lol;
    init_lol(&lol);
    parse_lol(&lol, argv[1]);

    List list;
    init_list(&list);
    parse_list(&list, argv[2]);

    bool result = can_make_list(&lol, &list);
    printf("%s\n", result ? "true" : "false");

    free_lol(&lol);
    free_list(&list);
}

// Perl Weekly Challenge 263 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-263/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    int id;
    int qty;
} Item;

typedef struct {
    Item* data;
    int size;
    int capacity;
} Items;

StrArray* split(const char* str_, const char* separators) {
    char* str = xstrdup(str_);
    StrArray* words = strarray_new();
    char* p = strtok(str, separators);
    while (p != NULL) {
        strarray_push_back(words, p);
        p = strtok(NULL, separators);
    }
    xfree(str);
    return words;
}

Items* items_new() {
    Items* items = xmalloc(sizeof(Items));
    int capacity = 8;
    items->data = xmalloc(capacity * sizeof(Item));
    items->size = 0;
    items->capacity = capacity;
    return items;
}

void items_add(Items* items, int id, int qty) {
    if (items->size >= items->capacity) {
        int new_capacity = items->capacity * 2;
        items->data = xrealloc(items->data, new_capacity * sizeof(Item));
        items->capacity = new_capacity;
    }
    items->data[items->size].id = id;
    items->data[items->size].qty = qty;
    items->size++;
}

void items_free(Items* items) {
    xfree(items->data);
    xfree(items);
}

Item* items_find(Items* items, int id) {
    for (int i = 0; i < items->size; i++) {
        if (items->data[i].id == id) {
            return &items->data[i];
        }
    }
    return NULL;
}

int compare_items(const void* a, const void* b) {
    const Item* item_a = (const Item*)a;
    const Item* item_b = (const Item*)b;
    return item_a->id - item_b->id;
}

void items_sort(Items* items) {
    qsort(items->data, items->size, sizeof(Item), compare_items);
}

Items* parse_items(const char* str) {
    Items* items = items_new();
    StrArray* nums = split(str, " ");
    for (int i = 0; i + 1 < nums->size; i += 2) {
        int id = atoi(nums->data[i]);
        int qty = atoi(nums->data[i + 1]);
        items_add(items, id, qty);
    }
    strarray_free(nums);
    return items;
}

void consolidate_items(Items* consolidated, const Items* items) {
    for (int i = 0; i < items->size; i++) {
        Item* item = items_find(consolidated, items->data[i].id);
        if (item) {
            item->qty += items->data[i].qty;
        } else {
            items_add(consolidated, items->data[i].id, items->data[i].qty);
        }
    }
    items_sort(consolidated);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s items, items", argv[0]);

    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);

    StrArray* lists = split(args->body, ",");
    Items* consolidated = items_new();
    for (int i = 0; i < lists->size; i++) {
        Items* items = parse_items(lists->data[i]);
        consolidate_items(consolidated, items);
        items_free(items);
    }

    printf("[");
    for (int i = 0; i < consolidated->size; i++) {
        if (i > 0) {
            printf(", ");
        }
        printf("[%d,%d]", consolidated->data[i].id, consolidated->data[i].qty);
    }
    printf("]\n");

    str_free(args);
    strarray_free(lists);
    items_free(consolidated);
}

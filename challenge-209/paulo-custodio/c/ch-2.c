/*
Challenge 209

Task 2: Merge Account
Submitted by: Mohammad S Anwar

You are given an array of accounts i.e. name with list of email addresses.

Write a script to merge the accounts where possible. The accounts can only
be merged if they have at least one email address in common.

Example 1:

Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
                     ["B", "b1@b.com"],
                     ["A", "a3@a.com", "a1@a.com"] ]
                   ]

Output: [ ["A", "a1@a.com", "a2@a.com", "a3@a.com"],
          ["B", "b1@b.com"] ]

Example 2:

Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
                     ["B", "b1@b.com"],
                     ["A", "a3@a.com"],
                     ["B", "b2@b.com", "b1@b.com"] ]

Output: [ ["A", "a1@a.com", "a2@a.com"],
          ["A", "a3@a.com"],
          ["B", "b1@b.com", "b2@b.com"] ]
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct ArrayStr {
    int count;
    char** items;
} ArrayStr;

typedef struct Account {
    char* name;
    ArrayStr* emails;
} Account;

typedef struct Accounts {
    int count;
    Account** items;
} Accounts;

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

ArrayStr* arrstr_new() {
    return check_mem(calloc(1, sizeof(ArrayStr)));
}

void arrstr_clear(ArrayStr* as) {
    for (int i = 0; i < as->count; i++)
        free(as->items[i]);
    as->count = 0;
}

void arrstr_free(ArrayStr* as) {
    arrstr_clear(as);
    free(as);
}

void arrstr_push(ArrayStr* as, const char* s) {
    as->items = check_mem(realloc(as->items, (as->count + 1) * sizeof(char**)));
    as->items[as->count++] = check_mem(strdup(s));
}

void arrstr_remove(ArrayStr* as, int idx) {
    if (idx < as->count) {
        free(as->items[idx]);
        memmove(&as->items[idx], &as->items[idx + 1], (as->count - idx - 1) * sizeof(char**));
        as->count--;
    }
}

int compare(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

void arrstr_sort(ArrayStr* as) {
    qsort(as->items, as->count, sizeof(char**), compare);
}

void arrstr_uniq(ArrayStr* as) {
    arrstr_sort(as);
    for (int i = 0; i < as->count - 1; i++) {
        if (strcmp(as->items[i], as->items[i + 1]) == 0) {
            arrstr_remove(as, i + 1);
            i--;
        }
    }
}

int arrstr_find(ArrayStr* as, const char* name) {
    for (int i = 0; i < as->count; i++)
        if (strcmp(as->items[i], name) == 0)
            return i;
    return -1;
}

Account* acc_new(const char* name) {
    Account* acc = check_mem(calloc(1, sizeof(Account)));
    acc->name = check_mem(strdup(name));
    acc->emails = arrstr_new();
    return acc;
}

void acc_free(Account* acc) {
    free(acc->name);
    arrstr_free(acc->emails);
    free(acc);
}

void acc_push_email(Account* acc, const char* email) {
    arrstr_push(acc->emails, email);
}

void acc_merge(Account* acc, Account* other) {
    for (int i = 0; i < other->emails->count; i++)
        acc_push_email(acc, other->emails->items[i]);
    arrstr_uniq(acc->emails);
}

Accounts* accs_new() {
    return check_mem(calloc(1, sizeof(Accounts)));
}

void accs_clear(Accounts* accs) {
    for (int i = 0; i < accs->count; i++)
        acc_free(accs->items[i]);
    accs->count = 0;
}

void accs_free(Accounts* accs) {
    accs_clear(accs);
    free(accs);
}

void accs_push(Accounts* accs, const char* name) {
    accs->items = check_mem(realloc(accs->items, (accs->count + 1) * sizeof(Account**)));
    accs->items[accs->count++] = acc_new(name);
}

void accs_remove(Accounts* accs, int idx) {
    if (idx < accs->count) {
        acc_free(accs->items[idx]);
        memmove(&accs->items[idx], &accs->items[idx + 1], (accs->count - idx - 1) * sizeof(Account**));
        accs->count--;
    }
}

bool accs_find_common(Accounts* accs, int* pa, int* pb) {
    for (*pa = 0; *pa < accs->count - 1; (*pa)++) {
        for (int i = 0; i < accs->items[*pa]->emails->count; i++) {
            const char* email = accs->items[*pa]->emails->items[i];
            for (*pb = *pa + 1; *pb < accs->count; (*pb)++) {
                if (arrstr_find(accs->items[*pb]->emails, email) >= 0) {
                    return true;
                }
            }
        }
    }
    return false;
}

void accs_merge(Accounts* accs) {
    int a, b;
    while (accs_find_common(accs, &a, &b)) {
        acc_merge(accs->items[a], accs->items[b]);
        accs_remove(accs, b);
    }
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc == 0) {
        fputs("usage: ch-2 name emails... name emails...\n", stderr);
        return EXIT_FAILURE;
    }

    Accounts* accs = accs_new();

    for (int i = 0; i < argc; i++) {
        const char* name = argv[i++];
        accs_push(accs, name);
        for (; i < argc && strcmp(argv[i], ",") != 0; i++) {
            const char* email = argv[i];
            acc_push_email(accs->items[accs->count - 1], email);
        }
    }

    accs_merge(accs);

    for (int i = 0; i < accs->count; i++) {
        printf("%s ", accs->items[i]->name);
        for (int j = 0; j < accs->items[i]->emails->count; j++)
            printf("%s ", accs->items[i]->emails->items[j]);
        printf("\n");
    }

    accs_free(accs);
}

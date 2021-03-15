/*
Challenge 094

TASK #1 › Group Anagrams
Submitted by: Mohammad S Anwar
You are given an array of strings @S.

Write a script to group Anagrams together in any random order.

An Anagram is a word or phrase formed by rearranging the letters of a
different word or phrase, typically using all the original letters exactly
once.

Example 1:
    Input: ("opt", "bat", "saw", "tab", "pot", "top", "was")
    Output: [ ("bat", "tab"),
              ("saw", "was"),
              ("top", "pot", "opt") ]
Example 2:
    Input: ("x")
    Output: [ ("x") ]
*/

#include <memory.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

// check memory allocation
void* check_mem(void* p) {
    if (!p) {
        fputs("out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}


// list of strings
typedef struct ListNode {
    char* str;
    struct ListNode* next;
} ListNode;

typedef struct StrList {
    ListNode* head, *tail;
} StrList;

StrList* strlist_alloc() {
    return check_mem(calloc(1, sizeof(StrList)));
}

void strlist_free(StrList* list) {
    if (list) {
        ListNode* node = list->head;
        while (node) {
            ListNode* next = node->next;
            free(node->str);
            free(node);
            node = next;
        }
        free(list);
    }
}

void strlist_push(StrList* list, const char* str) {
    ListNode* node = check_mem(calloc(1, sizeof(ListNode)));
    node->str = check_mem(strdup(str));
    if (!list->head) {
        list->head = list->tail = node;
    }
    else {
        list->tail->next = node;
        list->tail = node;
    }
}

void strlist_print(StrList* list) {
    printf("(");
    for (ListNode* node = list->head; node; node = node->next)
        printf("\"%s\"%s", node->str, node->next ? ", " : "");
    printf(")");
}


// map of strings to list of strings
typedef struct TreeNode {
    char* key;
    struct TreeNode* left, *right;
    StrList* strs;
} TreeNode;

TreeNode* tree_alloc() {
    return NULL;
}

TreeNode* tree_add_key(TreeNode** proot, const char* key) {
    if (*proot == NULL) {
        TreeNode* node = check_mem(calloc(1, sizeof(TreeNode)));
        node->key = check_mem(strdup(key));
        node->strs = strlist_alloc();
        *proot = node;
        return node;
    }
    else {
        TreeNode* node = *proot;
        int cmp = strcmp(key, node->key);
        if (cmp < 0)
            return tree_add_key(&node->left, key);
        else if (cmp > 0)
            return tree_add_key(&node->right, key);
        else
            return node;
    }
}

void tree_free(TreeNode* node) {
    if (node) {
        tree_free(node->left);
        tree_free(node->right);
        free(node->key);
        strlist_free(node->strs);
        free(node);
    }
}

void tree_node_print(TreeNode* node, bool* is_first) {
    if (node) {
        tree_node_print(node->left, is_first);
        if (!*is_first)
            printf(",\n  ");
        strlist_print(node->strs);
        *is_first = false;
        tree_node_print(node->right, is_first);
    }
}

void tree_print(TreeNode* tree) {
    bool is_first = true;
    printf("[ ");
    tree_node_print(tree, &is_first);
    printf(" ]\n");
}

int cmp_char(const void* a, const void* b) {
    return *(const char*)a - *(const char*)b;
}

char* make_key(const char* str) {
    char* key = check_mem(strdup(str));
    qsort(key, strlen(key), 1, cmp_char);
    return key;
}

int main(int argc, char* argv[]) {
    TreeNode* tree = tree_alloc();

    for (int i = 1; i < argc; i++) {
        char* key = make_key(argv[i]);
        TreeNode* node = tree_add_key(&tree, key);
        strlist_push(node->strs, argv[i]);
        free(key);
    }

    tree_print(tree);
    tree_free(tree);
}

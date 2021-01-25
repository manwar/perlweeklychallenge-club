/*
Challenge 094

TASK #2 › Binary Tree to Linked List
Submitted by: Mohammad S Anwar
You are given a binary tree.

Write a script to represent the given binary tree as an object and flatten
it to a linked list object. Finally print the linked list object.

Example:
    Input:

        1
       / \
      2   3
     / \
    4   5
       / \
      6   7

    Output:

        1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3
*/

#include <assert.h>
#include <ctype.h>
#include <memory.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXLINE 256

// check memory allocation
void* check_mem(void* p) {
    if (!p) {
        fputs("out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

// tree object
typedef struct Tree {
    int value;
    struct Tree* left, * right;
} Tree;

// input image
char** lines;
size_t num_lines;


// create and delete a tree
Tree* tree_new() {
    Tree* node = check_mem(calloc(1, sizeof(Tree)));
    return node;
}

void tree_delete(Tree* node) {
    if (node->left)  tree_delete(node->left);
    if (node->right) tree_delete(node->right);
    free(node);
}

// read lines from stdin
void lines_read() {
    char line[MAXLINE];
    while (fgets(line, sizeof(line), stdin)) {
        lines = check_mem(realloc(lines, (num_lines + 1) * sizeof(char*)));
        lines[num_lines] = check_mem(strdup(line));
        num_lines++;
    }
}

void lines_delete() {
    if (lines) {
        for (size_t i = 0; i < num_lines; i++)
            free(lines[i]);
        free(lines);
    }
}

// parse the tree
Tree* parse_subtree(int row, int col) {
    // parse root
    Tree* node = tree_new();
    assert(isdigit(lines[row][col]));
    node->value = lines[row][col] - '0';

    // parse children
    if (row + 2 < (int)num_lines) {
        // parse left subtree
        if (col - 2 >= 0 && lines[row + 1][col - 1] == '/')
            node->left = parse_subtree(row + 2, col - 2);
        // parse right subtree
        if (col + 2 < (int)strlen(lines[row + 2]) && lines[row + 1][col + 1] == '\\')
            node->right = parse_subtree(row + 2, col + 2);
    }
    return node;
}

Tree* parse_tree() {
    assert(num_lines > 0);
    char* p = strpbrk(lines[0], "0123456789");
    assert(p);
    int col = p - lines[0];
    return parse_subtree(0, col);
}

/*
// compute tree depth
void subtree_depth(Tree* node, int cur_depth, int* pmax_depth) {
    if (!node)
        return;
    if (node->left)
        subtree_depth(node->left, cur_depth + 1, pmax_depth);
    if (node->right)
        subtree_depth(node->right, cur_depth + 1, pmax_depth);
    if (cur_depth > *pmax_depth)
        *pmax_depth = cur_depth;
}

int tree_depth(Tree* root) {
    int max_depth = 0;
    subtree_depth(root, 1, &max_depth);
    return max_depth;
}

// print a tree
void print_subtree(Tree* node, char* lines[], int row, int col) {
    if (!node)
        return;
    lines[row][col] = '0' + node->value;
    if (node->left) {
        lines[row + 1][col - 1] = '/';
        print_subtree(node->left, lines, row + 2, col - 2);
    }
    if (node->right) {
        lines[row + 1][col + 1] = '\\';
        print_subtree(node->right, lines, row + 2, col + 2);
    }
}

void print_tree(Tree* root) {
    // create canvas
    int depth = tree_depth(root);
    int num_lines = depth * 2;
    int num_cols = depth * 5;
    char** lines = check_mem(calloc(num_lines, sizeof(char*)));
    for (int i = 0; i < num_lines; i++) {
        lines[i] = check_mem(calloc(num_cols + 1, 1));
        memset(lines[i], ' ', num_cols);
        lines[i][num_cols] = '\0';
    }

    // draw tree
    print_subtree(root, lines, 0, num_cols / 2);

    // print tree
    for (int i = 0; i < num_lines; i++)
        printf("%s\n", lines[i]);

    // delete canvas
    for (int i = 0; i < num_lines; i++)
        free(lines[i]);
    free(lines);
}
*/

// pre-order traversal, set left to NULL, move subtree to right
Tree* flatten(Tree* root) {
    if (!root) return root;
    Tree* left = flatten(root->left);
    Tree* right = flatten(root->right);

    root->left = NULL;
    root->right = left;

    Tree* node = root;
    while (node->right)             // find right-most node
        node = node->right;
    node->right = right;

    return root;
}

int main() {
    lines_read();
    Tree* tree = parse_tree();
    flatten(tree);

    for (Tree* node = tree; node; node = node->right)
        printf("%d%s", node->value, node->right ? " -> " : "\n");

    tree_delete(tree);
    lines_delete();
}

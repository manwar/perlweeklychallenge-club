/*
Challenge 093

TASK #2 › Sum Path
Submitted by: Mohammad S Anwar
You are given binary tree containing numbers 0-9 only.

Write a script to sum all possible paths from root to leaf.

Example 1:
Input:
     1
    /
   2
  / \
 3   4

Output: 13
as sum two paths (1->2->3) and (1->2->4)
Example 2:
Input:
     1
    / \
   2   3
  /   / \
 4   5   6

Output: 26
as sum three paths (1->2->4), (1->3->5) and (1->3->6)
*/

#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXLINE 256

// tree object
typedef struct Tree {
    int value;
    struct Tree *left, *right;
} Tree;

// input image
char** lines;
size_t num_lines;

// create and delete a tree
Tree* tree_new() {
    Tree* node = calloc(1, sizeof(Tree));
    assert(node);
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
        lines = realloc(lines, (num_lines + 1) * sizeof(char*));
        assert(lines);
        lines[num_lines] = strdup(line);
        assert(lines[num_lines]);
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
    if (row+2 < (int)num_lines) {
        // parse left subtree
        if (col-2 >= 0 && lines[row+1][col-1] == '/')
            node->left = parse_subtree(row + 2, col - 2);
        // parse right subtree
        if (col+2 < (int)strlen(lines[row+2]) && lines[row+1][col+1] == '\\')
            node->right = parse_subtree(row+2, col+2);
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

// compute paths length
void add_subtree_paths(Tree* node, int* psum, int partial_sum) {
    assert(node);
    partial_sum += node->value;
    if (node->left)     add_subtree_paths(node->left,  psum, partial_sum);
    if (node->right)    add_subtree_paths(node->right, psum, partial_sum);
    if (!node->left && !node->right)    // at a leaf
        *psum += partial_sum;
}

int add_tree_paths(Tree* tree) {
    int sum = 0;
    add_subtree_paths(tree, &sum, 0);
    return sum;
}

int main(int argc, char** argv[]) {
    lines_read();
    Tree* tree = parse_tree();

    int n = add_tree_paths(tree);
    printf("%d\n", n);

    tree_delete(tree);
    lines_delete();
}

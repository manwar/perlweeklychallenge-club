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

#include <exception>
#include <stdexcept>
#include <iostream>
#include <string>
#include <vector>
#include <cctype>

// input image object
class InputImage {
public:
    void append_line(const std::string& line);
    void clear();
    char ch(int row, int col) const;
    int root_col() const;

private:
    std::vector<std::string> m_lines;
};

void InputImage::append_line(const std::string& line) {
    m_lines.push_back(line);
}

void InputImage::clear() {
    m_lines.clear();
}

char InputImage::ch(int row, int col) const {
    // check if out of bounds
    if (row < 0 || row >= static_cast<int>(m_lines.size()) ||
        col < 0 || col >= static_cast<int>(m_lines[row].size()))
        return ' ';
    else
        return m_lines[row][col];
}

int InputImage::root_col() const {
    if (m_lines.empty())
        throw std::invalid_argument("malformed image");
    for (int col = 0; col < static_cast<int>(m_lines[0].size()); col++) {
        if (isdigit(m_lines[0][col]))
            return col;
    }
    throw std::invalid_argument("malformed image");
}

// tree object
class Tree {
public:
    Tree(int value = 0);
    ~Tree();

    int value;
    Tree* left, * right;

    static Tree* parse(const InputImage& image);
    static Tree* flatten(Tree* root);

private:
    static Tree* parse_subtree(const InputImage& image, int row, int col);
};

Tree::Tree(int value_)
    : value(value_), left(nullptr), right(nullptr)
{}

Tree::~Tree() {
    if (left) delete left;
    if (right) delete right;
}

Tree* Tree::parse(const InputImage& image) {
    int col = image.root_col();
    return parse_subtree(image, 0, col);
}

Tree* Tree::parse_subtree(const InputImage& image, int row, int col) {
    // parse root
    int value = image.ch(row, col) - '0';
    if (value < 0 || value>9)
        throw std::invalid_argument("malformed image");
    Tree* node = new Tree(value);

    // parse left subtree
    if (image.ch(row + 1, col - 1) == '/')
        node->left = parse_subtree(image, row + 2, col - 2);
    // parse right subtree
    if (image.ch(row + 1, col + 1) == '\\')
        node->right = parse_subtree(image, row + 2, col + 2);

    return node;
}

Tree* Tree::flatten(Tree* root) {
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

// read input from stdin
void read_lines(InputImage& image) {
    image.clear();
    std::string line;
    while (!std::getline(std::cin, line).eof())
        image.append_line(line);
}

int main(int argc, char* argv[]) {
    InputImage image;
    read_lines(image);
    Tree* tree = Tree::flatten(Tree::parse(image));

    for (Tree* node = tree; node; node = node->right) {
        if (node != tree)
            std::cout << " -> ";
        std::cout << node->value;
    }
    std::cout << std::endl;
    delete tree;
}

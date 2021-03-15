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

void InputImage::append_line(const std::string & line) {
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

    int value() const { return m_value; }
    int paths_length() const;

    static Tree* parse(const InputImage& image);

private:
    int m_value;
    Tree *m_left, *m_right;

    void subtree_paths_length(int& sum, int partial) const;

    static Tree* parse_subtree(const InputImage& image, int row, int col);
};

Tree::Tree(int value)
    : m_value(value), m_left(nullptr), m_right(nullptr)
{}

Tree::~Tree() {
    if (m_left) delete m_left;
    if (m_right) delete m_right;
}

Tree * Tree::parse(const InputImage & image) {
    int col = image.root_col();
    return parse_subtree(image, 0, col);
}

Tree * Tree::parse_subtree(const InputImage& image, int row, int col) {
    // parse root
    int value = image.ch(row, col) - '0';
    if (value < 0 || value>9)
        throw std::invalid_argument("malformed image");
    Tree* node = new Tree(value);

    // parse left subtree
    if (image.ch(row + 1, col - 1) == '/')
        node->m_left = parse_subtree(image, row + 2, col - 2);
    // parse right subtree
    if (image.ch(row + 1, col + 1) == '\\')
        node->m_right = parse_subtree(image, row + 2, col + 2);

    return node;
}

int Tree::paths_length() const {
    int sum = 0;
    subtree_paths_length(sum, 0);
    return sum;
}

void Tree::subtree_paths_length(int & sum, int partial) const {
    partial += m_value;
    if (m_left)     m_left->subtree_paths_length(sum, partial);
    if (m_right)    m_right->subtree_paths_length(sum, partial);
    if (!m_left && !m_right)    // at a leaf
        sum += partial;
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
    Tree* tree = Tree::parse(image);
    int n = tree->paths_length();
    std::cout << n << std::endl;
    delete tree;
}

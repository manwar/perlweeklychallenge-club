#include <iostream>
#include <limits>
#include <memory>
#include <stack>
#include <string>

using Branch = std::stack<std::string>;

struct Node {
    explicit Node(Node* parent, int amount, const char* label) :
    parent_{parent}, amount_{amount}, label_{label}, left_{nullptr},
    right_{nullptr}  {
    }

    Node(const Node&)=delete;
    Node& operator=(const Node&)=delete;

    Node* parent_;
    int amount_;
    std::string label_;
    std::unique_ptr<Node> left_;
    std::unique_ptr<Node> right_;
};

void traverse(Node* node, Branch& bestBranch, int& maxDepth, int depth) {

    if (depth < maxDepth && node->amount_ < 200) {
        node->left_.reset(new Node(node, node->amount_ * 2, "double"));
        node->right_.reset(new Node(node, node->amount_ + 1, "add one"));
        traverse(node->left_.get(), bestBranch, maxDepth, depth + 1);
        traverse(node->right_.get(), bestBranch, maxDepth, depth + 1);

    } else if (node->amount_ == 200) {
        if (depth < maxDepth) {
            maxDepth = depth;
            Branch branch;
            Node* current = node;

            while (current->parent_ != nullptr) {
                branch.push(current->label_);
                current = current->parent_;
            }
            bestBranch = branch;
        }    
    }
}

int main() {
    Branch result;
    int maxdepth = std::numeric_limits<int>::max();
    std::unique_ptr<Node> root(new Node(nullptr, 1, "")); 

    traverse(root.get(), result, maxdepth, 0);

    while(!result.empty()) {
        std::cout << result.top();
        result.pop();
        if (!result.empty()) { 
            std::cout << ", ";
        }
    }
    std::cout << '\n';
}
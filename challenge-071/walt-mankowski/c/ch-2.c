#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int val;
    struct Node *next;
} Node;

void make_list(Node *head, const int from, const int to) {
    Node *node = head;
    for (int i = from; i <= to; i++) {
        node->next = malloc(sizeof(Node));
        node = node->next;
        node->val = i;
        node->next = NULL;
    }
}

void print_list(const Node *head) {
    Node *node = head->next;
    while (node) {
        printf("%d", node->val);
        if (node->next)
            printf(" -> ");
        node = node->next;
    }
    printf("\n");
}

int list_len(Node *head) {
    Node *node = head;
    int len = 0;
    while (node->next) {
        len++;
        node = node->next;
    }
    return len;
}

void remove_from_end(Node *head, const int n) {
    int pos = list_len(head);
    Node *node = head;
    while (pos > n) {
        node = node->next;
        pos--;
    }
    Node *tmp = node->next;
    node->next = node->next->next;
    free(tmp);
}

int main(int argc, char *argv[]) {
    const int N = atoi(argv[1]);
    Node *head = malloc(sizeof(Node));
    head->next = NULL;

    make_list(head, 1, 5);
    print_list(head);
    remove_from_end(head, N);
    print_list(head);
}

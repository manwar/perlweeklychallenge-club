/*
Challenge 003

Challenge #1
Create a script to generate 5-smooth numbers, whose prime divisors are less
or equal to 5. They are also called Hamming/Regular/Ugly numbers. For more
information, please check this wikipedia.

*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

// implement deque
#define Q_SIZE 100

typedef struct Q {
    size_t  front;
    size_t  back;
    int     data[Q_SIZE];
} Q;

bool q_empty(Q* q) {
    return q->front == q->back;
}

int q_front(Q* q) {
    return q->data[q->front];
}

int q_back(Q* q) {
    return q->data[(q->back + Q_SIZE - 1) % Q_SIZE];
}

void q_push_back(Q* q, int n) {
    q->data[q->back] = n;
    q->back = (q->back + 1) % Q_SIZE;
}

void q_pop_back(Q* q) {
    q->back = (q->back + Q_SIZE -1) % Q_SIZE;
}

void q_push_front(Q* q, int n) {
    q->front = (q->front + Q_SIZE - 1) % Q_SIZE;
    q->data[q->front] = n;
}

void q_pop_front(Q* q) {
    q->front = (q->front +1) % Q_SIZE;
}

int min(int a, int b) {
    return a<b ? a : b;
}

int min3(int a, int b, int c) {
    return min(a, min(b, c));
}

// hamming number generator
Q q2, q3, q5;

int next_hamming(void) {
    // init three queues with 1
    if (q_empty(&q2)) {
        q_push_back(&q2, 1);
        q_push_back(&q3, 1);
        q_push_back(&q5, 1);
    }

    // get the smallest of the queue heads
    int n = min3(q_front(&q2), q_front(&q3), q_front(&q5));

    // shift used multiples
    if (n == q_front(&q2)) q_pop_front(&q2);
    if (n == q_front(&q3)) q_pop_front(&q3);
    if (n == q_front(&q5)) q_pop_front(&q5);

    // push next multiples
    q_push_back(&q2, 2*n);
    q_push_back(&q3, 3*n);
    q_push_back(&q5, 5*n);

    return n;
}

int main(int argc, char* argv[]) {
    if (argc == 2) {
        for (int i = 0; i < atoi(argv[1]); i++)
            printf("%d\n", next_hamming());
    }
}

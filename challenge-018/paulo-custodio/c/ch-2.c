/*
Challenge 018

Task #2
Write a script to implement Priority Queue. It is like regular queue except
each element has a priority associated with it. In a priority queue, an
element with high priority is served before an element with low priority.
Please check this wiki page for more informations. It should serve the
following operations:

is_empty: check whether the queue has no elements.
insert_with_priority: add an element to the queue with an associated priority.
pull_highest_priority_element: remove the element from the queue that has the
highest priority, and return it. If two elements have the same priority,
then return element added first.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "utlist.h"
#include "test.h"

typedef struct priority_queue {
    int priority;
    int value;
    struct priority_queue* next, * prev;
} PriorityQueue;

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

void pq_free(PriorityQueue** pq) {
    PriorityQueue* elt, * tmp;
    DL_FOREACH_SAFE(*pq, elt, tmp)
        free(elt);
    *pq = NULL;
}

bool pq_is_empty(PriorityQueue** pq) {
    return *pq == NULL;
}

void pq_insert(PriorityQueue** pq, int priority, int value) {
    PriorityQueue* elt = check_mem(calloc(1, sizeof(PriorityQueue)));
    elt->priority = priority;
    elt->value = value;

    PriorityQueue* found;
    bool inserted = false;
    DL_FOREACH(*pq, found) {
        if (priority > found->priority) {
            DL_PREPEND_ELEM(*pq, found, elt);
            inserted = true;
            break;
        }
    }
    if (!inserted)
        DL_APPEND(*pq, elt);
}

bool pq_pull(PriorityQueue** pq, int* result) {
    if (pq_is_empty(pq))
        return false;
    else {
        PriorityQueue* elt = *pq;
        *result = elt->value;
        DL_DELETE(*pq, elt);
        free(elt);
        return true;
    }
}

int main() {
    PriorityQueue* pq = NULL;
    int value;

    ok(pq_is_empty(&pq), "is empty");
    ok(!pq_pull(&pq, &value), "pull from empty queue");

    // insert same priority
    pq_insert(&pq, 1, 123);
    ok(!pq_is_empty(&pq), "is not empty");

    pq_insert(&pq, 1, 456);
    ok(!pq_is_empty(&pq), "is not empty");

    pq_insert(&pq, 1, 789);
    ok(!pq_is_empty(&pq), "is not empty");

    // pull
    ok(pq_pull(&pq, &value) == true && value == 123, "got element");
    ok(!pq_is_empty(&pq), "is not empty");

    ok(pq_pull(&pq, &value) == true && value == 456, "got element");
    ok(!pq_is_empty(&pq), "is not empty");

    ok(pq_pull(&pq, &value) == true && value == 789, "got element");
    ok(pq_is_empty(&pq), "is empty");

    // insert higher priority
    pq_insert(&pq, 1, 123);
    pq_insert(&pq, 1, 456);
    pq_insert(&pq, 2, 23);
    pq_insert(&pq, 3, 4);

    // insert lower priority
    pq_insert(&pq, 0, 999);
    pq_insert(&pq, 0, 998);

    ok(pq_pull(&pq, &value) == true && value == 4, "got element");
    ok(pq_pull(&pq, &value) == true && value == 23, "got element");
    ok(pq_pull(&pq, &value) == true && value == 123, "got element");
    ok(pq_pull(&pq, &value) == true && value == 456, "got element");
    ok(pq_pull(&pq, &value) == true && value == 999, "got element");
    ok(pq_pull(&pq, &value) == true && value == 998, "got element");
    ok(pq_is_empty(&pq), "is empty");

    pq_free(&pq);
    return done_testing();
}

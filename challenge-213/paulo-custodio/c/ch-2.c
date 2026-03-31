// Perl Weekly Challenge 213 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-213/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

// Dijkstra algorithm
typedef struct {
    int from;
    int to;
    int dist;
} Node;

typedef struct {
    Node* nodes;
    int size;
    int capacity;
} Graph;

// Dijkstra data
typedef struct {
    int* dist;
    int* prev;
    int size;
} Dijkstra;

Graph* graph_new() {
    int capacity = 8;
    Graph* graph = xmalloc(sizeof(Graph));
    graph->nodes = xmalloc(capacity * sizeof(Node));
    graph->size = 0;
    graph->capacity = capacity;
}

void graph_free(Graph* graph) {
    xfree(graph->nodes);
    xfree(graph);
}

void graph_add(Graph* graph, int from, int to, int dist) {
    if (graph->size >= graph->capacity) {
        graph->capacity *= 2;
        graph->nodes = xrealloc(graph->nodes, graph->capacity * sizeof(Node));
    }
    int idx = graph->size++;
    graph->nodes[idx].from = from;
    graph->nodes[idx].to = to;
    graph->nodes[idx].dist = dist;
}

void graph_erase(Graph* graph, int index) {
    assert(index >= 0 && index < graph->size);
    memmove(graph->nodes+index, graph->nodes+index+1, (graph->size - (index+1)) * sizeof(Node));
    graph->size--;
}

Dijkstra* dijkstra_new(Graph* graph) {
    // get max node
    int max_node = 0;
    for (int i = 0; i < graph->size; i++) {
        assert(graph->nodes[i].from >= 0);
        max_node = MAX(max_node, graph->nodes[i].from);
        assert(graph->nodes[i].to >= 0);
        max_node = MAX(max_node, graph->nodes[i].to);
    }

    // make structure
    Dijkstra* dijkstra = xmalloc(sizeof(Dijkstra));
    dijkstra->size = max_node+1;
    dijkstra->dist = xcalloc(dijkstra->size, sizeof(int));
    dijkstra->prev = xcalloc(dijkstra->size, sizeof(int));

    return dijkstra;
}

void dijkstra_free(Dijkstra* dijkstra) {
    xfree(dijkstra->dist);
    xfree(dijkstra->prev);
    xfree(dijkstra);
}

// compute the Dijkstra algorithm
Dijkstra* dijkstra(Graph* graph, int source) {
    Dijkstra* dis = dijkstra_new(graph);

    // 1. Initialize distances and predecessors
    for (int i = 0; i < graph->size; i++) {
        dis->dist[graph->nodes[i].from] = INT_MAX;
        dis->prev[graph->nodes[i].from] = -1;

        dis->dist[graph->nodes[i].to] = INT_MAX;
        dis->prev[graph->nodes[i].to] = -1;
    }
    dis->dist[source] = 0;

    // 2. Set of unvisited nodes
    IntArray* q = intarray_new();
    for (int i = 0; i < graph->size; i++) {
        int node;

        node = graph->nodes[i].from;
        if (intarray_find_index(q, node) < 0)
            intarray_push_back(q, node);

        node = graph->nodes[i].to;
        if (intarray_find_index(q, node) < 0)
            intarray_push_back(q, node);
    }

    // while queue is not empty
    while (q->size > 0) {
        // 3. Select the unvisited node with the smallest distance
        int min_index = 0;
        int min_node = q->data[min_index];
        int min_dist = dis->dist[min_node];
        for (int i = 0; i < q->size; i++) {
            int node = q->data[i];
            if (dis->dist[node] < min_dist) {
                min_index = i;
                min_node = q->data[min_index];
                min_dist = dis->dist[min_node];
            }
        }
        intarray_erase(q, min_index);
        int u = min_node;

        // 4. If the smallest distance is infinity, remaining nodes are unreachable
        if (dis->dist[u] == INT_MAX)
            break;

        // 5. For each neighbor of u
        for (int i = 0; i < graph->size; i++) {
            if (u == graph->nodes[i].from) {
                int v = graph->nodes[i].to;
                int cost = graph->nodes[i].dist;
                int alt = dis->dist[u] + cost;

                // 6. Relaxation step: check if a cheaper path is found
                if (alt < dis->dist[v]) {
                    dis->dist[v] = alt;
                    dis->prev[v] = u;
                }
            }

            if (u == graph->nodes[i].to) {
                int v = graph->nodes[i].from;
                int cost = graph->nodes[i].dist;
                int alt = dis->dist[u] + cost;

                // 6. Relaxation step: check if a cheaper path is found
                if (alt < dis->dist[v]) {
                    dis->dist[v] = alt;
                    dis->prev[v] = u;
                }
            }
        }
    }

    intarray_free(q);
    return dis;
}

IntArray* get_route(Dijkstra* dis, int target) {
    IntArray* route = intarray_new();
    int u = target;

    while (u >= 0) {
        intarray_push_front(route, u);
        u = dis->prev[u];
    }

    return route;
}

// route: 1,2,4
void parse_route(Graph* graph, const char* route_) {
    char* route = xstrdup(route_);

    char* p = strtok(route, " ,");
    if (p == NULL)
        return;

    int from = atoi(p);

    p = strtok(NULL, " ,");
    while (p != NULL) {
        int to = atoi(p);
        graph_add(graph, from, to, 1);
        from = to;
        p = strtok(NULL, " ,");
    }

    xfree(route);
}

int main(int argc, char* argv[]) {
    if (argc < 4)
        die("usage: %s routes... source target", argv[0]);

    int target = atoi(argv[--argc]);
    int source = atoi(argv[--argc]);

    Graph* graph = graph_new();
    for (int i = 1; i < argc; i++)
        parse_route(graph, argv[i]);

    Dijkstra* dis = dijkstra(graph, source);
    IntArray* route = get_route(dis, target);
    intarray_print(route);

    graph_free(graph);
    dijkstra_free(dis);
    intarray_free(route);
}

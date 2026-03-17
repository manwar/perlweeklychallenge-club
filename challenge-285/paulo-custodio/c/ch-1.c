#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    char from;
    char to;
} Route;

#define END_ROUTES '\0'

Route* parse_routes(int argc, char* argv[]) {
    // make one string with all the routes
    Str* args = str_new();
    for (int i = 0; i < argc; i++)
        str_append(args, argv[i]);

    // get list of routes
    Str* routes_list = str_new();
    char* p = strtok(args->body, ",");
    while (p != NULL) {
        if (strlen(p) != 2)
            die("invalid route: %s", p);
        str_append(routes_list, p);
        p = strtok(NULL, ",");
    }

    // split each route
    Route* routes = xmalloc((routes_list->size/2+1) * sizeof(Route));
    int w = 0;
    for (const char* p = routes_list->body; p[0] != '\0' && p[1] != '\0'; p++) {
        routes[w].from = p[0];
        routes[w].to = p[1];
        w++;
    }
    routes[w].from = END_ROUTES;
    routes[w].to = END_ROUTES;

    str_free(args);
    str_free(routes_list);

    return routes;
}

Str* find_no_connection(Route* routes) {
    bool endpoints[UCHAR_MAX] = {0};

    // find end_points with no connection
    for (int i = 0; routes[i].from != END_ROUTES; i++)
        endpoints[routes[i].to] = true;
    for (int i = 0; routes[i].from != END_ROUTES; i++)
        endpoints[routes[i].from] = false;

    // return as a string
    Str* no_connection = str_new();
    for (int i = 0; i < sizeof(endpoints)/sizeof(endpoints[0]); i++) {
        if (endpoints[i])
            str_printf(no_connection, "%c", i);
    }
    return no_connection;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s A B , C D , ...", argv[0]);

    Route* routes = parse_routes(argc-1, argv+1);
    Str* no_connection = find_no_connection(routes);
    printf("%s\n", no_connection->body);

    xfree(routes);
    str_free(no_connection);
}

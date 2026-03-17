#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    int interval;
    int start;
    int duration;
} Route;

typedef struct {
    int start;
    int finish;
} Bus;

StrArray* split(const char* str_, const char* separators) {
    char* str = xstrdup(str_);
    StrArray* words = strarray_new();
    char* p = strtok(str, separators);
    while (p != NULL) {
        strarray_push_back(words, p);
        p = strtok(NULL, separators);
    }
    xfree(str);
    return words;
}

Route* get_routes(const char* input, int* num_routes) {
    StrArray* route_strs = split(input, ",");
    *num_routes = route_strs->size;
    Route* routes = xmalloc(*num_routes * sizeof(Route));
    for (int i = 0; i < *num_routes; i++) {
        if (sscanf(route_strs->data[i],
                    "%d %d %d",
                    &routes[i].interval,
                    &routes[i].start,
                    &routes[i].duration) != 3)
            die("invalid route: %s", route_strs->data[i]);
    }
    strarray_free(route_strs);
    return routes;
}

int compare(const void* a, const void* b) {
    return ((Bus*)a)->start - ((Bus*)b)->start;
}

Bus* get_buses(Route* routes, int num_routes, int* num_buses) {
    int capacity = 16;
    Bus* buses = xmalloc(capacity * sizeof(Bus));
    *num_buses = 0;

    for (int i = 0; i < num_routes; i++) {
        for (int time = routes[i].start; time < 2*60; time += routes[i].interval) {
            Bus bus;
            bus.start = time;
            bus.finish = time + routes[i].duration;

            if (*num_buses >= capacity) {
                capacity *= 2;
                buses = xrealloc(buses, capacity * sizeof(Bus));
            }

            buses[*num_buses] = bus;
            (*num_buses)++;
        }
    }

    // sort buses by start time
    qsort(buses, *num_buses, sizeof(Bus), compare);
    return buses;
}

// skip bus at this minute to arrive sooner
bool skip_sooner(int minute, Bus* buses, int num_buses) {
    // get first bus that matches
    Bus first;
    int i = 0;
    for (; i < num_buses; i++) {
        if (buses[i].start >= minute) {
            first = buses[i];
            break;
        }
    }

    // check if a later bus arrives sooner
    for (; i < num_buses; i++) {
        if (buses[i].start > first.start && buses[i].finish < first.finish)
            return true;
    }

    return false;
}

IntArray* skip_minutes(Bus* buses, int num_buses) {
    IntArray* output = intarray_new();
    for (int minute = 0; minute < 60; minute++) {
        if (skip_sooner(minute, buses, num_buses))
            intarray_push_back(output, minute);
    }
    return output;
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s route,route,...", argv[0]);

    // get args
    Str* args = str_new();
    for (int i = 1; i < argc; i++)
        str_printf(args, "%s ", argv[i]);

    // get routes
    int num_routes = 0;
    Route* routes = get_routes(args->body, &num_routes);

    // get buses
    int num_buses = 0;
    Bus* buses = get_buses(routes, num_routes, &num_buses);

    // get skip-minutes
    IntArray* minutes = skip_minutes(buses, num_buses);
    intarray_print(minutes);

    str_free(args);
    xfree(routes);
    xfree(buses);
    intarray_free(minutes);
}

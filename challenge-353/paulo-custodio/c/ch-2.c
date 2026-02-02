#include <assert.h>
#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* code;
    char* name;
    bool status;
    bool result;
} Product;

Product* products = NULL;
size_t products_size = 0;

char *my_strtok(char *str, const char *delim) {
    static char *last = NULL;
    if (str) last = str;
    if (!last || *last == '\0') return NULL;

    char *token_start = last;
    char *next_delim = strpbrk(last, delim);

    if (next_delim) {
        *next_delim = '\0';
        last = next_delim + 1;
    }
    else {
        last = NULL;
    }

    return token_start;
}

char* trim(char* str) {
    char* start = str;
    while (isspace(*start))
        start++;
    char* end = start + strlen(start);
    while (end > start && isspace(end[-1]))
        end--;
    *end = '\0';
    return start;
}

void free_products() {
    for (size_t i = 0; i < products_size; i++) {
        free(products[i].code);
        free(products[i].name);
    }
    free(products);
    products = NULL;
    products_size = 0;
}

bool compute_result(const char* code, const char* name, bool status) {
    // codes[i] is non-empty and consists only of alphanumeric characters (a-z, A-Z, 0-9) and underscores (_).
    if (strlen(code) == 0)
        return false;
    for (const char* p = code; *p != '\0'; p++) {
        if (!isalnum(*p) && *p != '_')
            return false;
    }

    // names[i] is one of the following four categories: "electronics", "grocery", "pharmacy", "restaurant".
    static const char* categories[] = {
        "electronics", "grocery", "pharmacy", "restaurant", NULL
    };
    bool found = false;
    for (size_t i = 0; categories[i] != NULL && !found ; i++) {
        if (strcmp(name, categories[i]) == 0)
            found = true;
    }
    if (!found)
        return false;

    // status[i] is true.
    if (!status)
        return false;

    return true;
}

void add_product(const char* code) {
    size_t i = products_size++;
    products = realloc(products, products_size * sizeof(Product));
    assert(products != NULL);
    products[i].code = strdup(code);
    assert(products[i].code != NULL);
    products[i].name = NULL;
    products[i].status = false;
    products[i].result = false;
}

void read_products() {
    char line[BUFSIZ];

    // read codes
    if (fgets(line, sizeof(line), stdin) == NULL) {
        fputs("missing input data\n", stderr);
        exit(EXIT_FAILURE);
    }

    char* code = my_strtok(line, ",\n");
    while (code != NULL) {
        add_product(trim(code));
        code = my_strtok(NULL, ",\n");
    }

    // read name
    if (fgets(line, sizeof(line), stdin) == NULL) {
        fputs("missing input data\n", stderr);
        exit(EXIT_FAILURE);
    }

    size_t i = 0;
    char* name = my_strtok(line, ",\n");
    while (name != NULL && i < products_size) {
        products[i].name = strdup(trim(name));
        assert(products[i].name != NULL);
        i++;
        name = my_strtok(NULL, ",\n");
    }

    // read status
    if (fgets(line, sizeof(line), stdin) == NULL) {
        fputs("missing input data\n", stderr);
        exit(EXIT_FAILURE);
    }

    i = 0;
    char* status = my_strtok(line, ",\n");
    while (status != NULL && i < products_size) {
        products[i].status = strcmp(trim(status), "true") == 0 ? true : false;
        i++;
        status = my_strtok(NULL, ",\n");
    }
}

void compute_results() {
    for (size_t i = 0; i < products_size; i++) {
        products[i].result = compute_result(products[i].code,
                                            products[i].name,
                                            products[i].status);
    }
}

void print_results() {
    const char* separator = "";
    for (size_t i = 0; i < products_size; i++) {
        printf("%s%s", separator, products[i].result ? "true" : "false");
        separator = ", ";
    }
    printf("\n");
}

int main() {
    char line[BUFSIZ];

    read_products();
    compute_results();
    print_results();
    free_products();
}

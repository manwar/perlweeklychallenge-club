#include "alloc.h"

enum { NAME = 256, STR, NUM };

typedef struct {
    int type;
    int int_value;
    char* str_value;
} Token;

typedef struct {
    Token* data;
    int size;
    int capacity;
} Tokens;

Tokens* tokens_new() {
    Tokens* tokens = xmalloc(sizeof(Tokens));
    int capacity = 8;
    tokens->data = xmalloc(capacity * sizeof(Token));
    tokens->size = 0;
    tokens->capacity = capacity;
    return tokens;
}

void tokens_free(Tokens* tokens) {
    for (int i = 0; i < tokens->size; i++)
        xfree(tokens->data[i].str_value);
    xfree(tokens->data);
    xfree(tokens);
}

void tokens_grow(Tokens* tokens) {
    int new_capacity = tokens->capacity * 2;
    tokens->data = xrealloc(tokens->data, new_capacity * sizeof(Token));
    tokens->capacity = new_capacity;
}

void tokens_add_char(Tokens* tokens, char ch) {
    if (tokens->size >= tokens->capacity)
        tokens_grow(tokens);
    int idx = tokens->size++;
    tokens->data[idx].type = ch;
    tokens->data[idx].int_value = 0;
    tokens->data[idx].str_value = NULL;
}

void tokens_add_num(Tokens* tokens, int value) {
    if (tokens->size >= tokens->capacity)
        tokens_grow(tokens);
    int idx = tokens->size++;
    tokens->data[idx].type = NUM;
    tokens->data[idx].int_value = value;
    tokens->data[idx].str_value = NULL;
}

void tokens_add_str(Tokens* tokens, const char* str) {
    if (tokens->size >= tokens->capacity)
        tokens_grow(tokens);
    int idx = tokens->size++;
    tokens->data[idx].type = STR;
    tokens->data[idx].int_value = 0;
    tokens->data[idx].str_value = xstrdup(str);
}

void tokens_add_name(Tokens* tokens, const char* name) {
    if (tokens->size >= tokens->capacity)
        tokens_grow(tokens);
    int idx = tokens->size++;
    tokens->data[idx].type = NAME;
    tokens->data[idx].int_value = 0;
    tokens->data[idx].str_value = xstrdup(name);
}

void scan_line(Tokens* tokens, const char* line) {
    const char* p = line;
    while (*p) {
        if (isspace(*p)) {
            p++;
        }
        else if (isdigit(*p)) {
            int value = 0;
            while (isdigit(*p)) {
                value = 10 * value + *p - '0';
                p++;
            }
            tokens_add_num(tokens, value);
        }
        else if (isalpha(*p)) {
            Str* name = str_new();
            while (isalnum(*p)) {
                str_printf(name, "%c", *p);
                p++;
            }
            tokens_add_name(tokens, name->body);
            str_free(name);
        }
        else if (*p == '"') {
            Str* str = str_new();
            p++;
            while (*p != '"' && *p != '\0') {
                if (p[0] == '\\' && p[1] != '\0') {
                    str_printf(str, "%c", p[1]);
                    p += 2;
                }
                else {
                    str_printf(str, "%c", *p);
                    p++;
                }
            }
            if (*p == '"')
                p++;
            tokens_add_str(tokens, str->body);
            str_free(str);
        }
        else {
            tokens_add_char(tokens, *p);
            p++;
        }
    }
}

Tokens* scan_input() {
    Tokens* tokens = tokens_new();
    char line[BUFSIZ];
    while (fgets(line, sizeof(line), stdin)) {
        scan_line(tokens, line);
    }
    return tokens;
}

typedef struct {
    int type;
    char* name;
    int int_value;
    char* str_value;
} Field;

typedef struct {
    char* name;
    Field* data;
    int size;
    int capacity;
} Element;

Element* element_new() {
    Element* element = xmalloc(sizeof(Element));
    int capacity = 8;
    element->name = NULL;
    element->data = xmalloc(capacity * sizeof(Field));
    element->size = 0;
    element->capacity = capacity;
    return element;
}

void element_free(Element* element) {
    xfree(element->name);
    for (int i = 0; i < element->size; i++) {
        xfree(element->data[i].name);
        xfree(element->data[i].str_value);
    }
    xfree(element->data);
    xfree(element);
}

void element_grow(Element* element) {
    int new_capacity = element->capacity * 2;
    element->data = xrealloc(element->data, new_capacity * sizeof(Field));
    element->capacity = new_capacity;
}

void element_add_num_field(Element* element, const char* name, int value) {
    if (element->size >= element->capacity)
        element_grow(element);
    int idx = element->size++;
    element->data[idx].type = NUM;
    element->data[idx].name = xstrdup(name);
    element->data[idx].int_value = value;
    element->data[idx].str_value = NULL;
}

void element_add_str_field(Element* element, const char* name, const char* str) {
    if (element->size >= element->capacity)
        element_grow(element);
    int idx = element->size++;
    element->data[idx].type = STR;
    element->data[idx].name = xstrdup(name);
    element->data[idx].int_value = 0;
    element->data[idx].str_value = xstrdup(str);
}

Element* parse_element(const Tokens* tokens) {
    Element* element = element_new();

    int pos = 0;
    if (pos >= tokens->size || tokens->data[pos].type != '{')
        die("expected start marker");
    pos++;

    if (pos >= tokens->size || tokens->data[pos].type != '%')
        die("expected start marker");
    pos++;

    if (pos >= tokens->size || tokens->data[pos].type != NAME)
        die("expected element name");
    element->name = xstrdup(tokens->data[pos].str_value);
    pos++;

    while (pos < tokens->size && tokens->data[pos].type != '%') {
        if (pos >= tokens->size || tokens->data[pos].type != NAME)
            die("expected field name");
        const char* field_name = tokens->data[pos].str_value;
        pos++;

        if (pos >= tokens->size || tokens->data[pos].type != '=')
            die("expected '='");
        pos++;

        if (pos < tokens->size && tokens->data[pos].type == NUM) {
            int field_value = tokens->data[pos].int_value;
            element_add_num_field(element, field_name, field_value);
            pos++;
        }
        else if (pos < tokens->size && tokens->data[pos].type == STR) {
            char* field_value = tokens->data[pos].str_value;
            element_add_str_field(element, field_name, field_value);
            pos++;
        }
        else {
            die("invalid field value");
        }
    }

    if (pos >= tokens->size || tokens->data[pos].type != '%')
        die("expected end marker");
    pos++;

    if (pos >= tokens->size || tokens->data[pos].type != '}')
        die("expected end marker");
    pos++;

    if (pos < tokens->size)
        die("extra input");

    return element;
}

void print_element(Element* element) {
    printf("{\n");
    printf("  name => \"%s\",\n", element->name);
    printf("  fields => {\n");
    for (int i = 0; i < element->size; i++) {
        Field* field = &element->data[i];
        printf("    %s => ", field->name);
        if (field->type == NUM) {
            printf("%d,\n", field->int_value);
        }
        else if (field->type == STR) {
            printf("\"");
            for (const char* p = field->str_value; *p; p++) {
                if (*p == '"' || *p == '\\')
                    printf("\\%c", *p);
                else
                    printf("%c", *p);
            }
            printf("\",\n");
        }
        else {
            die("invalid field type");
        }
    }
    printf("  },\n");
    printf("}\n");
}

int main() {
    Tokens* tokens = scan_input();
    Element* element = parse_element(tokens);
    print_element(element);
    tokens_free(tokens);
    element_free(element);
}

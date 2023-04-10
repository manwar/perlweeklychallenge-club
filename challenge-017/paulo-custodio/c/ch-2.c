/*
Challenge 017

Task #2
Create a script to parse URL and print the components of URL. According to
Wiki page, the URL syntax is as below:

scheme:[//[userinfo@]host[:port]]path[?query][#fragment]

For example: jdbc://user:password@localhost:3306/pwc?profile=true#h1

  scheme:   jdbc
  userinfo: user:password
  host:     localhost
  port:     3306
  path:     /pwc
  query:    profile=true
  fragment: h1
*/

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define STR_OR_NULL(str)    ((str) ? (str) : "")

struct url {
    char* scheme;
    char* userinfo;
    char* host;
    char* port;
    char* path;
    char* query;
    char* fragment;
};

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

char* strndup(const char* str, size_t len) {
    char* ret = check_mem(malloc(len + 1));
    strncpy(ret, str, len);
    ret[len] = '\0';
    return ret;
}

void url_init(struct url* url) {
    memset(url, 0, sizeof(struct url));
}

void url_free(struct url* url) {
    free(url->scheme);
    free(url->userinfo);
    free(url->host);
    free(url->port);
    free(url->path);
    free(url->query);
    free(url->fragment);
}

bool parse_word(const char** p) {
    if (isalpha(**p) || **p == '_') {
        (*p)++;
        while (isalnum(**p) || strchr("_+-.", **p) != NULL)
            (*p)++;
        return true;
    }
    else
        return false;
}

bool match(const char** p, char c) {
    if (**p == c) {
        (*p)++;
        return true;
    }
    else
        return false;
}

bool match_str(const char** p, const char* str) {
    if (strncmp(*p, str, strlen(str)) == 0) {
        (*p) += strlen(str);
        return true;
    }
    else
        return false;
}

bool parse_scheme(const char** p, char** scheme) {
    const char* p0 = *p;
    *scheme = NULL;
    if (parse_word(p) && match(p, ':')) {
        *scheme = strndup(p0, *p - p0 - 1);
        return true;
    }
    else {
        *p = p0;
        return false;
    }
}

bool parse_password(const char** p) {
    if (**p == ':') {
        (*p)++;
        while (**p != '\0' && **p != '@')
            (*p)++;
        return true;
    }
    else
        return false;
}

bool parse_userinfo(const char** p, char** userinfo) {
    const char* p0 = *p;
    *userinfo = NULL;
    if (!parse_word(p))
        return false;
    parse_password(p);
    if (**p != '@') {
        *p = p0;
        return false;
    }
    *userinfo = strndup(p0, *p - p0);
    (*p)++;
    return true;
}

bool parse_port(const char** p, char** port) {
    if (**p == ':') {
        (*p)++;
        const char* p1 = *p;
        while (isdigit(**p))
            (*p)++;
        *port = strndup(p1, *p - p1);
        return true;
    }
    else
        return false;
}

bool parse_user(const char** p, char** userinfo, char** host, char** port) {
    const char* p0 = *p;
    *userinfo = NULL;
    *host = NULL;
    *port = NULL;
    if (!match_str(p, "//"))
        return false;
    parse_userinfo(p, userinfo);
    const char* p1 = *p;
    if (!parse_word(p)) {
        free(*userinfo);
        *userinfo = NULL;
        *p = p0;
        return false;
    }
    *host = strndup(p1, *p - p1);
    parse_port(p, port);
    return true;
}

bool parse_path(const char** p, char** path) {
    const char* p0 = *p;
    *path = NULL;
    while (parse_word(p) || match(p, '/'))
        ;
    if (*p != p0) {
        *path = strndup(p0, *p - p0);
        return true;
    }
    else
        return false;
}

bool parse_query(const char** p, char** query) {
    *query = NULL;
    if (**p == '?') {
        (*p)++;
        const char* p1 = *p;
        while (**p != '\0' && **p != '#')
            (*p)++;
        *query = strndup(p1, *p - p1);
        return true;
    }
    else
        return false;
}

bool parse_fragment(const char** p, char** fragment) {
    *fragment = NULL;
    if (**p == '#') {
        (*p)++;
        const char* p1 = *p;
        while (**p != '\0')
            (*p)++;
        *fragment = strndup(p1, *p - p1);
        return true;
    }
    else
        return false;
}

bool url_parse(struct url* url, const char* text) {
    url_init(url);
    const char* p = text;
    if (!parse_scheme(&p, &url->scheme))
        return false;
    parse_user(&p, &url->userinfo, &url->host, &url->port);
    if (!parse_path(&p, &url->path))
        return false;
    parse_query(&p, &url->query);
    parse_fragment(&p, &url->fragment);
    return true;
}

int main() {
    char line[BUFSIZ];
    while (fgets(line, sizeof(line), stdin)) {
        struct url url;
        if (url_parse(&url, line)) {
            printf("scheme:   %s\n", STR_OR_NULL(url.scheme));
            printf("userinfo: %s\n", STR_OR_NULL(url.userinfo));
            printf("host:     %s\n", STR_OR_NULL(url.host));
            printf("port:     %s\n", STR_OR_NULL(url.port));
            printf("path:     %s\n", STR_OR_NULL(url.path));
            printf("query:    %s\n", STR_OR_NULL(url.query));
            printf("fragment: %s\n", STR_OR_NULL(url.fragment));
        }
        else {
            puts("invalid url");
        }
    }
}

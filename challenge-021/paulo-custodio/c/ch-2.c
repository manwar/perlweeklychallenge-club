/*
Challenge 021

Task #2
Write a script for URL normalization based on rfc3986. This task was shared by
Anonymous Contributor.

According to Wikipedia, URL normalization is the process by which URLs are
modified and standardized in a consistent manner. The goal of the
normalization process is to transform a URL into a normalized URL so it is
possible to determine if two syntactically different URLs may be equivalent.
*/

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "utstring.h"

void decode_triplets(UT_string* result, const char* hex) {
    UT_string* hex_digits;
    utstring_new(hex_digits);
    utstring_printf(hex_digits, "%-.2s", hex);      // only 2 characters

    int c;
    sscanf(utstring_body(hex_digits), "%x", &c);
    if (isalnum(c) || strchr("_-.~", c) != NULL)
        utstring_printf(result, "%c", c);
    else
        utstring_printf(result, "%%%02X", c);

    utstring_free(hex_digits);
}


void normalize_url(UT_string* url) {
    UT_string* url2;
    utstring_new(url2);

    // normalize %-encoded triplets
    utstring_clear(url2);
    for (const char* p = utstring_body(url); *p != '\0'; ) {
        if (*p == '%' && isxdigit(p[1]) && isxdigit(p[2])) {
            decode_triplets(url2, p + 1);
            p += 3;
        }
        else {
            utstring_printf(url2, "%c", *p++);
        }
    }
    utstring_clear(url);
    utstring_concat(url, url2);

    // convert scheme to lower case
    for (char* p = utstring_body(url); *p != '\0' && *p != ':'; p++)
        *p = tolower(*p);

    // convert host to lower case
    char* p = strstr(utstring_body(url), "//");
    if (p != NULL) {
        p += 2;
        char* p1 = strchr(p, '@');
        if (p1 != NULL)
            p = p1;             // start of host
        for (; *p != '\0' && *p != '/'; p++)
            *p = tolower(*p);
    }

    // remove dot-segments
    while ((p = strstr(utstring_body(url), "/./")) != NULL) {
        memmove(p, p+2, strlen(p+2)+1);
        utstring_len(url) = strlen(utstring_body(url));
    }

    // remove dot-dot-segments
    while ((p = strstr(utstring_body(url), "/../")) != NULL) {
        char* p1 = p-1;
        while (*p1 != '/' && p1 > utstring_body(url))
            p1--;
        if (*p1 == '/') {
            memmove(p1, p+3, strlen(p+3)+1);
            utstring_len(url) = strlen(utstring_body(url));
        }
    }

    // convert empty path to /
    p = strstr(utstring_body(url), "//");
    if (p != NULL) {
        p += 2;
        p = strchr(p, '/');
        if (p == NULL)
            utstring_printf(url, "/");
    }

    // remove port 80
    p = strstr(utstring_body(url), ":80");
    if (p != NULL && !isdigit(p[3])) {
        memmove(p, p+3, strlen(p+3)+1);
        utstring_len(url) = strlen(utstring_body(url));
    }

    utstring_free(url2);
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-2 uri", stderr);
        return EXIT_FAILURE;
    }

    UT_string* url;
    utstring_new(url);
    utstring_printf(url, "%s", argv[1]);
    normalize_url(url);

    printf("%s\n", utstring_body(url));

    utstring_free(url);
}

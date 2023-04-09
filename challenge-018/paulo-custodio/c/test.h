// minimal test macros

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

static int test_count;
static int test_failed;

static void test_ok(bool result, const char* text, const char* filename, int lineno) {
    printf("%sok %d - %s\n", result ? "" : "not ", ++test_count, text);
    if (!result) {
        test_failed++;
        printf("# Failed test '%s'\n", text);
        printf("# at %s line %d\n", filename, lineno);
    }
}

#define ok(a,text)      test_ok((a),(text),__FILE__,__LINE__)
#define is(a,b,text)    test_ok((a)==(b),(text),__FILE__,__LINE__)

static int done_testing() {
    printf("%d..%d\n", 1, test_count);
    if (!test_failed) {
        return EXIT_SUCCESS;
    }
    else {
        printf("# Looks like you failed %d test of %d\n", test_failed, test_count);
        return EXIT_FAILURE;
    }
}

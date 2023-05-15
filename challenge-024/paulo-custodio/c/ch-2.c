/*
Challenge 024

Task #2
Create a script to implement full text search functionality using Inverted
Index. According to wikipedia:

In computer science, an inverted index (also referred to as a postings file
or inverted file) is a database index storing a mapping from content, such as
words or numbers, to its locations in a table, or in a document or a set of
documents (named in contrast to a forward index, which maps from documents to
content). The purpose of an inverted index is to allow fast full-text
searches, at a cost of increased processing when a document is added to the
database.
*/

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <sys/stat.h>
#include <sqlite3.h>

#define DATABASE    "index.db3"
#define SEPARATORS  " \t\r\n\v\f!\"#$%&'()*+,-./:;<=>?@[\\]^`{|}~"

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory\n", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

bool file_exists(const char *filename) {
    struct stat buffer;
    return (stat(filename, &buffer) == 0);
}

void basename(char* filename) {
    char* p = filename + strlen(filename);
    while (p > filename && p[-1] != '/' && p[-1] != '\\' && p[-1] != '.')
        p--;
    if (p > filename && p[-1] == '.')
        p[-1] = '\0';
}

char* strtolower(char* str) {
    for (char* p = str; *p; p++)
        *p = tolower(*p);
    return str;
}

void check_error(sqlite3* db, int rc) {
    if (rc != SQLITE_OK) {
        fprintf(stderr, "Database error: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        exit(EXIT_FAILURE);
    }
}

void check_error_step(sqlite3* db, int step) {
    if (step != SQLITE_DONE) {
        fprintf(stderr, "Database error: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        exit(EXIT_FAILURE);
    }
}

int callback(void *NotUsed, int argc, char **argv, char **azColName) {
    for(int i = 0; i < argc; i++) {
        printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
    }
    printf("\n");
    return 0;
}

sqlite3* open_database() {
    sqlite3 *db;
    int rc = sqlite3_open(DATABASE, &db);
    check_error(db, rc);
    return db;
}

void close_database(sqlite3* db) {
    sqlite3_close(db);
}

void create_database() {
    if (file_exists(DATABASE))
        return;

    sqlite3 *db = open_database();
    char *zErrMsg = NULL;

    const char* sql =
        "CREATE TABLE words ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "word TEXT UNIQUE);"
        "CREATE TABLE documents ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "title TEXT UNIQUE); "
        "CREATE TABLE found ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "document_id INTEGER, "
        "word_id INTEGER); "
        "CREATE UNIQUE INDEX found_index ON found(document_id, word_id); ";

    int rc = sqlite3_exec(db, sql, callback, 0, &zErrMsg);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "SQL error: %s\n", zErrMsg);
        sqlite3_free(zErrMsg);
        sqlite3_close(db);
        return;
    }

    close_database(db);
}

int get_or_add_document_id(sqlite3* db, const char* title) {
    bool found = false;
    int id = -1;

    const char* sql = "SELECT id FROM documents WHERE title = ?;";
    sqlite3_stmt* stmt;
    int rc = sqlite3_prepare_v2(db, sql, strlen(sql), &stmt, NULL);
    check_error(db, rc);
    sqlite3_bind_text(stmt, 1, title, strlen(title), NULL);
    int step = sqlite3_step(stmt);
    if (step == SQLITE_ROW) {
        id = sqlite3_column_int(stmt, 0);
        found = true;
    }
    sqlite3_finalize(stmt);

    if (found)
        return id;

    sql = "INSERT INTO documents(title) VALUES(?);";
    rc = sqlite3_prepare_v2(db, sql, strlen(sql), &stmt, NULL);
    check_error(db, rc);
    sqlite3_bind_text(stmt, 1, title, strlen(title), NULL);
    step = sqlite3_step(stmt);
    check_error_step(db, step);
    sqlite3_finalize(stmt);

    return sqlite3_last_insert_rowid(db);
}

int get_or_add_word_id(sqlite3* db, const char* word) {
    bool found = false;
    int id = -1;

    const char* sql = "SELECT id FROM words WHERE word = ?;";
    sqlite3_stmt* stmt;
    int rc = sqlite3_prepare_v2(db, sql, strlen(sql), &stmt, NULL);
    check_error(db, rc);
    sqlite3_bind_text(stmt, 1, word, strlen(word), NULL);
    int step = sqlite3_step(stmt);
    if (step == SQLITE_ROW) {
        id = sqlite3_column_int(stmt, 0);
        found = true;
    }
    sqlite3_finalize(stmt);

    if (found)
        return id;

    sql = "INSERT INTO words(word) VALUES(?);";
    rc = sqlite3_prepare_v2(db, sql, strlen(sql), &stmt, NULL);
    check_error(db, rc);
    sqlite3_bind_text(stmt, 1, word, strlen(word), NULL);
    step = sqlite3_step(stmt);
    check_error_step(db, step);
    sqlite3_finalize(stmt);

    return sqlite3_last_insert_rowid(db);
}

int add_found(sqlite3* db, int document_id, int word_id) {
    bool found = false;
    int id = -1;

    const char* sql = "SELECT id FROM found "
                      "WHERE document_id = ? AND word_id = ?;";
    sqlite3_stmt* stmt;
    int rc = sqlite3_prepare_v2(db, sql, strlen(sql), &stmt, NULL);
    check_error(db, rc);
    sqlite3_bind_int(stmt, 1, document_id);
    sqlite3_bind_int(stmt, 2, word_id);
    int step = sqlite3_step(stmt);
    if (step == SQLITE_ROW) {
        id = sqlite3_column_int(stmt, 0);
        found = true;
    }
    sqlite3_finalize(stmt);

    if (found)
        return id;

    sql = "INSERT INTO found(document_id, word_id) VALUES(?, ?);";
    rc = sqlite3_prepare_v2(db, sql, strlen(sql), &stmt, NULL);
    check_error(db, rc);
    sqlite3_bind_int(stmt, 1, document_id);
    sqlite3_bind_int(stmt, 2, word_id);
    step = sqlite3_step(stmt);
    check_error_step(db, step);
    sqlite3_finalize(stmt);

    return sqlite3_last_insert_rowid(db);
}

void add_document(const char* filename) {
    sqlite3* db = open_database();

    // title
    char* title = check_mem(strdup(filename));
    basename(title);

    // document id
    int document_id = get_or_add_document_id(db, title);

    // read document
    FILE* fp = fopen(filename, "r");
    if (fp == NULL) {
        perror(filename);
        close_database(db);
        free(title);
        exit(EXIT_FAILURE);
    }

    char line[BUFSIZ];
    while (fgets(line, sizeof(line), fp) != NULL) {
        char* word = strtok(line, SEPARATORS);
        while (word != NULL) {
            strtolower(word);
            int word_id = get_or_add_word_id(db, word);
            add_found(db, document_id, word_id);
            word = strtok(NULL, SEPARATORS);
        }
    }

    printf("Indexed %s\n", title);

    fclose(fp);
    close_database(db);
    free(title);
}

void search_documents(const char* word) {
    sqlite3* db = open_database();

    char* lcword = strtolower(check_mem(strdup(word)));

    const char* sql = "SELECT word, title "
                      "FROM documents, words, found "
                      "WHERE word = ? "
                      "AND found.document_id = documents.id "
                      "AND found.word_id     = words.id "
                      "ORDER BY title;";
    sqlite3_stmt* stmt;
    int rc = sqlite3_prepare_v2(db, sql, strlen(sql), &stmt, NULL);
    check_error(db, rc);
    sqlite3_bind_text(stmt, 1, lcword, strlen(lcword), NULL);
    int step;
    while ((step  = sqlite3_step(stmt)) == SQLITE_ROW) {
        printf("%s  %s\n",
               sqlite3_column_text(stmt, 0),
               sqlite3_column_text(stmt, 1));
    }
    sqlite3_finalize(stmt);

    close_database(db);
    free(lcword);
}

int usage(void) {
    fputs("usage: ch-2 add|search file|word\n", stderr);
    return EXIT_FAILURE;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        return usage();

    create_database();
    if (strcmp(argv[1], "add") == 0)
        add_document(argv[2]);
    else if (strcmp(argv[1], "search") == 0)
        search_documents(argv[2]);
    else
        return usage();
}

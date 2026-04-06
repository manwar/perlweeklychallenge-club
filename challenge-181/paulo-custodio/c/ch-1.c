// Perl Weekly Challenge 181 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-181/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define REFLOW_WIDTH 60

void trim(char* text) {
    int len = strlen(text);
    while (len > 0 && isspace(text[len-1]))
        text[--len] = '\0';
}

Str* read_input() {
    char line[BUFSIZ];
    Str* text = str_new();
    while (fgets(line, sizeof(line), stdin) != NULL) {
        trim(line);
        str_printf(text, "%s ", line);
    }
    trim(text->body);
    return text;
}

StrArray* split_sentences(char* text) {
    StrArray* sentences = strarray_new();
    char* p = strtok(text, ".");
    while (p) {
        while (isspace(*p))
            p++;
        if (*p == '\0')
            break;
        trim(p);
        strarray_push_back(sentences, p);

        p = strtok(NULL, ".");
    }
    return sentences;
}

char* reorder_sentence(char* sentence) {
    // build list of words
    StrArray* words = strarray_new();
    char* p = strtok(sentence, " ");
    while (p != NULL) {
        strarray_push_back(words, p);
        p = strtok(NULL, " ");
    }

    if (words->size == 0) {
        strarray_free(words);
        return xstrdup("");
    }

    // sort the words
    strarray_isort(words);

    // prepare a new sentence
    Str* result_sentence = str_new();
    for (int i = 0; i < words->size; i++) {
        if (i > 0)
            str_append(result_sentence, " ");
        str_append(result_sentence, words->data[i]);
    }
    str_append(result_sentence, ".");

    // extract result
    char* result = xstrdup(result_sentence->body);
    strarray_free(words);
    str_free(result_sentence);
    return result;
}

void reorder_sentences(StrArray* sentences) {
    for (int i = 0; i < sentences->size; i++) {
        char* sentence = reorder_sentence(sentences->data[i]);
        xfree(sentences->data[i]);
        sentences->data[i] = sentence;
    }
}

Str* reflow_paragraph(StrArray* sentences) {
    Str* result = str_new();
    int column = 0;
    for (int i = 0; i < sentences->size; i++) {
        char* p = strtok(sentences->data[i], " ");
        while (p != NULL) {
            if (column + 1 + strlen(p) > REFLOW_WIDTH) {
                str_append(result, "\n");
                str_append(result, p);
                column = strlen(p);
            }
            else {
                if (column > 0) {
                    str_append(result, " ");
                    column++;
                }
                str_append(result, p);
                column += strlen(p);
            }

            p = strtok(NULL, " ");
        }
    }
    str_append(result, "\n");
    return result;
}

int main() {
    Str* text = read_input();
    StrArray* sentences = split_sentences(text->body);
    reorder_sentences(sentences);
    Str* reflowed = reflow_paragraph(sentences);
    printf("%s", reflowed->body);

    str_free(text);
    str_free(reflowed);
    strarray_free(sentences);
}

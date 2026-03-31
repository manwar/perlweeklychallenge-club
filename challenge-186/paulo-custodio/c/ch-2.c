// Perl Weekly Challenge 186 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-186/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#define IN_FILE     "ch-2.in"
#define OUT_FILE    "ch-2.out"
#define EXP_FILE    "ch-2.exp"

// crude Unicode decoder, only for vowels with Latin accents
// should use a Unicode library for robust implementation
Str* unidecode(const unsigned char* buffer, size_t size) {
    Str* result = str_new();

    for (size_t i = 0; i < size; i++) {
        if      (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x83) { str_append(result, "A"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x8A) { str_append(result, "E"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x8D) { str_append(result, "I"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x92) { str_append(result, "O"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x99) { str_append(result, "U"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xA3) { str_append(result, "a"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xAA) { str_append(result, "e"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xAD) { str_append(result, "i"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xB2) { str_append(result, "o"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xB9) { str_append(result, "u"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x83) { str_append(result, "A"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x95) { str_append(result, "O"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xA3) { str_append(result, "a"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xB5) { str_append(result, "o"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x80) { str_append(result, "A"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x88) { str_append(result, "E"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x8C) { str_append(result, "I"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x92) { str_append(result, "O"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x99) { str_append(result, "U"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xA0) { str_append(result, "a"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xA8) { str_append(result, "e"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xAC) { str_append(result, "i"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xB2) { str_append(result, "o"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xB9) { str_append(result, "u"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x81) { str_append(result, "A"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x89) { str_append(result, "E"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x8D) { str_append(result, "I"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x93) { str_append(result, "O"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x9A) { str_append(result, "U"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xA1) { str_append(result, "a"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xA9) { str_append(result, "e"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xAD) { str_append(result, "i"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xB3) { str_append(result, "o"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xBA) { str_append(result, "u"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x82) { str_append(result, "A"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x8A) { str_append(result, "E"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x8E) { str_append(result, "I"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x94) { str_append(result, "O"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0x9B) { str_append(result, "U"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xA2) { str_append(result, "a"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xAA) { str_append(result, "e"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xAE) { str_append(result, "i"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xB4) { str_append(result, "o"); i++; }
        else if (buffer[i]==0xC3 && i+1<size && buffer[i+1]==0xBB) { str_append(result, "u"); i++; }
        else if (buffer[i]==0xC3 && i+1<size) die("unknown Unicode character 0xC3, 0x%02X", buffer[i+1]);
        else if (buffer[i]>=0x80) die("unknown Unicode character 0x%02X", buffer[i]);
        else str_printf(result, "%c", buffer[i]);
    }

    return result;
}

char* slurp_file(const char* filename, size_t* size) {
    *size = 0;
    FILE* fp = fopen(filename, "rb");
    if (fp == NULL)
        return NULL;

    // get size
    fseek(fp, 0, SEEK_END);
    *size = ftell(fp);
    fseek(fp, 0, SEEK_SET);

    // allocate buffer and read
    char* buffer = xmalloc(*size);
    if (fread(buffer, 1, *size, fp) != *size) {
        xfree(buffer);
        fclose(fp);
        return NULL;
    }

    return buffer;
}

bool spew_file(const char* filename, const char* buffer, size_t size) {
    FILE* fp = fopen(filename, "wb");
    if (fp == NULL)
        return false;

    fwrite(buffer, 1, size, fp);
    fclose(fp);
    return true;
}

int main() {
    // read unicode file
    size_t in_size = 0;
    char* in_buffer = slurp_file(IN_FILE, &in_size);
    if (in_buffer == NULL)
        die("failed to read " IN_FILE);

    // build unicode decoded file
    Str* decoded = unidecode(in_buffer, in_size);
    spew_file(OUT_FILE, decoded->body, decoded->size);

    // read golden file
    size_t exp_size = 0;
    char* exp_buffer = slurp_file(EXP_FILE, &exp_size);
    if (exp_buffer == NULL)
        die("failed to read " EXP_FILE);

    if (decoded->size != exp_size)
        die(OUT_FILE " has the wrong size");

    if (memcmp(decoded->body, exp_buffer, exp_size) != 0)
        die(OUT_FILE " has wrong content");

    remove(OUT_FILE);
    printf("ok\n");

    xfree(in_buffer);
    xfree(exp_buffer);
    str_free(decoded);
}

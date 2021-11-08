import std::io;

extern func ulong strtoull(char* str, char** str_end, int base);

/**
 * @require n > 0
 * @pure
 **/
func bool ugly(ulong n) {
    while (n != 1) {
        /* That's ugly, but compile-time $foreach isn't implemented yet,
           and a labelled continue segfaults the compiler… */
        if (n % 2 == 0) {
            n /= 2;
        } else if (n % 3 == 0) {
            n /= 3;
        } else if (n % 5 == 0) {
            n /= 5;
        } else {
            return false;
        }
    }
    return true;
}

func int main(int argc, char** argv) {
    if (argc != 2) return 1;

    ulong n = strtoull(argv[1], null, 10);
    ulong i;
    while (n > 0) {
        i++;
        if (ugly(i)) n--;
    }
    io::printf("%u\n", i);

    return 0;
}

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_in_network(const char* node_ip, const char* network_ip) {
    int b1, b2, b3, b4, bits;

    if (sscanf(node_ip, "%d.%d.%d.%d", &b1, &b2, &b3, &b4) != 4)
        return false;
    uint32_t node_addr = (b1 << 24) | (b2 << 16) | (b3 << 8) | b4;

    if (sscanf(network_ip, "%d.%d.%d.%d/%d", &b1, &b2, &b3, &b4, &bits) != 5)
        return false;
    uint32_t network_addr = (b1 << 24) | (b2 << 16) | (b3 << 8) | b4;
    uint32_t bitmask =  (UINT32_MAX >> (32 - bits )) << (32 - bits);

    return (node_addr & bitmask) == (network_addr & bitmask);
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s addr addr/bits", argv[0]);

    bool ok = is_in_network(argv[1], argv[2]);
    printf("%s\n", bool_to_string(ok));
}

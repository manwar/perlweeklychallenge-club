// Parrot: https://nvlabs.github.io/parrot

auto team_champion(auto arr) {
    auto sums = arr.sum(2_ic);
    return (sums.maxr() == sums).where().front() - 1;
}

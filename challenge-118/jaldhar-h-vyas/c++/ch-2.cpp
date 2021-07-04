// Compile with g++ -std=c++17 -O2 -g -Wall -Wextra -pedantic -o ch-2 ch-2.cpp

#include <algorithm>
#include <array>
#include <climits>
#include <cmath>
#include <iostream>
#include <iterator>
#include <optional>
#include <vector>

struct Position {
    int row_;
    int col_;
};

using Targets = std::array<Position, 6>;
using Deltas = std::array<Position, 8>;
using Path = std::vector<Position>;

std::ostream& operator<<(std::ostream& out, const Position& position) {
    out << (char)('a' + position.col_)  << 8 - position.row_;
    return out;
}

bool operator==(const Position& a, const Position& b) {
    return a.row_ == b.row_ && a.col_ == b.col_;
}

bool operator!=(const Position& a, const Position& b) {
    return !operator==(a, b);
}

bool operator<(const Position& a, const Position& b) {
    return (8 * a.row_ + a.col_) < (8 * b.row_ + b.col_);
}

// Unused in this program but hey why not...
bool operator>(const Position& a, const Position& b) {
    return !operator<(a, b);
}

std::optional<Position> tryMove(const Position& pos, const Position& delta) {
    auto dest = pos;
    dest.row_ += delta.row_;
    dest.col_ += delta.col_;
    return (dest.row_ >= 0 && dest.row_ < 8 && dest.col_ >= 0 && dest.col_ < 8)
        ? std::make_optional(dest)
        : std::nullopt;
}

std::vector<Position> possibleMoves(const Position& pos,const Position& target){
    static const Deltas deltas{{
        {-2, -1},
        {-2, 1},
        {-1, 2},
        {1, 2},
        {2, 1},
        {2, -1},
        {-1, -2},
        {1, -2}
    }};

    std::vector<Position> moves;

    std::for_each(deltas.begin(), deltas.end(),
    [&pos, &moves](const auto& delta) {
        if (auto move = tryMove(pos, delta)) {
            moves.push_back(*move);
        }
    });

    std::sort(moves.begin(), moves.end(),
    [&target](const auto& a, const auto& b) {
        return estimatedCost(a, target) < estimatedCost(b, target);
    });

    return moves;
}

// size_t used here because we will be comparing with path size.
std::size_t estimatedCost(const Position& position, const Position& goal){
    static const std::array<std::size_t, 64> distance{
        0, 3, 2, 3, 2, 3, 4, 5,
        3, 2, 1, 2, 3, 4, 3, 4,
        2, 1, 4, 3, 2, 3, 4, 5,
        3, 2, 3, 2, 3, 4, 3, 4,
        2, 3, 2, 3, 4, 3, 4, 5,
        3, 4, 3, 4, 3, 4, 5, 4,
        4, 3, 4, 3, 4, 5, 4, 5,
        5, 4, 5, 4, 5, 4, 5, 6
    };

    return distance[std::abs(position.row_ - goal.row_) * 8 +
        std::abs(position.col_ - goal.col_)];
}

int search(const Position& target, Path& path, std::size_t estimate) {
    const auto& current = path.back();
    const auto cost = path.size() + estimatedCost(current, target);

    if (cost > estimate) {
        return cost;
    }

    if (current == target) {
        return INT_MIN;
    }

    int min = INT_MAX;

    for (const auto& move: possibleMoves(current, target)) {
        if (std::find(path.begin(), path.end(), move) == path.end()) {
            path.push_back(move);
            int t = search(target, path, estimate);

            if (t == INT_MIN) {
                return INT_MIN;
            }

            if (t < min) {
                min = t;
            }
            path.pop_back();
        }
    }

    return min;
}

Path makePath(Position& knight, const Targets& targets) {
    Path path;
    path.push_back(knight);

    for(const auto& target: targets) {
        Path stage;
        stage.push_back(knight);
        auto estimate = estimatedCost(knight, target);

        while (true) {
            int t = search(target, stage, estimate);

            if (t == INT_MIN) {
                break;
            }

            // Can't solve; this shouldn't happen.
            if (t == INT_MAX) {
                break;
            }

            estimate = t;
        }

        std::copy(std::next(stage.begin()), stage.end(),
            std::back_inserter(path));

        stage.clear();
        knight = target;
    }

    return path;
}

int main() {
    Targets treasures{{
        {2, 4},
        {4, 2},
        {5, 1},
        {6, 0},
        {6, 1},
        {7, 1},
    }};

    std::size_t shortest = INT_MAX;
    Path shortestPath;
    do {
        Position knight{0, 0};

        auto path = makePath(knight, treasures);
        if (path.size() < shortest) {
            shortest = path.size();
            shortestPath = path;
        }

    } while (std::next_permutation(treasures.begin(), treasures.end()));

    std::copy(shortestPath.begin(), shortestPath.end(),
            std::ostream_iterator<Position>(std::cout, " "));
    std::cout << '\n';

    return 0;
}
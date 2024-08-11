
function convert_key_to_idxs( key )
    column, row = collect( key )
    idx_c = Int(column) - 96
    idx_r = Int(row) - 48
    
    idx_c > 0 && idx_c <= 8 &&
        idx_r > 0 && idx_r <= 8 ||
        error("bad range for key " * key)
    
    [idx_c, idx_r]
end

function get_moves( idx )
    moves = []
    to_check = [[2, 1], [1, 2], [-2, 1], [1, -2],
                [2, -1], [-1, 2], [-2, -1], [-1, -2]]
    for check in to_check
        next = idx + check
        if next[1] > 0 && next[1] <= 8 && next[2] > 0 && next[2] <= 8
            push!( moves, next )
        end
    end
    moves
end

function knight_path( start_key, end_key )
    start_idx = convert_key_to_idxs( start_key )
    end_idx = convert_key_to_idxs( end_key )

    board = -1 * ones( 8, 8 )

    queue = [start_idx]
    board[start_idx[1], start_idx[2]] = 0
    q_idx = 1
    while q_idx <= size( queue, 1)
        current = queue[q_idx]
        if current == end_idx
            return board[current[1], current[2]]
        end
        for next_pos in get_moves(queue[q_idx])
            if board[next_pos[1], next_pos[2]] == -1
                push!( queue, next_pos )
                board[next_pos[1], next_pos[2]] = board[current[1], current[2]] + 1
            end
        end
        q_idx += 1
    end
    return -1
end

for input = [("a1", "f1"), ("g2", "a8"), ("g2", "h2"), ("a1", "h8")]
    println( input, " => ", knight_path(input[1], input[2]) )
end

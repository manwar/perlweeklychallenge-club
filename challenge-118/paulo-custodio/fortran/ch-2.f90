! Challenge 118
!
! TASK #2 - Adventure of Knight
! Submitted by : Cheok - Yin Fung
! A knight is restricted to move on an 8×8 chessboard.The knight is denoted by
! N and its way of movement is the same as what it is defined in Chess.
! * represents an empty square. x represents a square with treasure.
!
! The Knight’s movement is unique.It may move two squares vertically and one
! square horizontally, or two squares horizontally and one square vertically
! (with both forming the shape of an L).
!
! There are 6 squares with treasures.
!
! Write a script to find the path such that Knight can capture all treasures.
! The Knight can start from the top - left square.
!
!       a b c d e f g h
!     8 N * * * * * * * 8
!     7 * * * * * * * * 7
!     6 * * * * x * * * 6
!     5 * * * * * * * * 5
!     4 * * x * * * * * 4
!     3 * x * * * * * * 3
!     2 x x * * * * * * 2
!     1 * x * * * * * * 1
!       a b c d e f g h
!
! https://en.m.wikipedia.org/wiki/Knight%27s_tour

program ch2
    implicit none

    character(len=256) :: board, solution
    integer :: row, col
    common /solution/ solution

    solution = repeat('*', 256)
    call parse_board(board, row, col)
    call solve(board, row, col)
    print *, solution(66:)

contains
    function board_pos(r, c)
        integer :: board_pos
        integer, intent(in) :: r, c

        board_pos = 1+r*8+c
    end function board_pos

    subroutine init_board(board)
        character(len=256), intent(out) :: board
        integer :: r, c, p

        board = ''
        do r = 0, 7
            do c = 0, 7
                p = board_pos(r, c)
                board(p:p) = '*'
            end do
        end do
    end subroutine init_board

    subroutine print_board(board)
        character(len=256), intent(in) :: board
        character(len=50) :: line
        integer :: r, c, p

        print *, "  a b c d e f g h"
        do r = 0, 7
            line = achar(iachar('8')-r)
            do c = 0, 7
                p = board_pos(r, c)
                line = trim(line)//' '//board(p:p)
            end do
            line = trim(line)//' '//achar(iachar('8')-r)
            print *, line
        end do
        print *, "  a b c d e f g h"
        print *, ""
        print *, "> " // board(66:)
    end subroutine print_board

    subroutine set_knight(board, r, c)
        character(len=256), intent(inout) :: board
        integer, intent(in) :: r, c
        integer :: p

        p = board_pos(r, c)
        board(p:p) = 'N'
        board = trim(board)//' '//achar(iachar('a')+c)//achar(iachar('8')-r)
    end subroutine set_knight

    subroutine set_treasure(board, r, c)
        character(len=256), intent(inout) :: board
        integer, intent(in) :: r, c
        integer :: p

        p = board_pos(r, c)
        board(p:p) = 'x'
    end subroutine set_treasure

    function visited(board, r, c)
        logical :: visited
        character(len=256), intent(in) :: board
        integer, intent(in) :: r, c
        integer :: p

        p = board_pos(r, c)
        if (board(p:p) == 'N') then
            visited = .true.
        else
            visited = .false.
        end if
    end function visited

    function ended(board)
        logical :: ended
        character(len=256), intent(in) :: board
        integer :: p

        p = index(board, 'x')
        if (p == 0) then
            ended = .true.
        else
            ended = .false.
        end if
    end function ended

    subroutine parse_board(board, knight_row, knight_col)
        character(len=256), intent(out) :: board
        integer, intent(out) :: knight_row, knight_col
        integer :: r, c
        character(len=2), dimension(9) :: t

        call init_board(board)

        ! read header
        read(*,*) t(1),t(2),t(3),t(4),t(5),t(6),t(7),t(8)
        ! read board
        do r = 0, 7
            read(*,*) t(1),t(2),t(3),t(4),t(5),t(6),t(7),t(8),t(9)
            do c = 0, 7
                if (trim(t(2+c)) == "N") then
                    call set_knight(board, r, c)
                    knight_row = r
                    knight_col = c
                else
                    if (trim(t(2+c)) == "x") then
                        call set_treasure(board, r, c)
                    end if
                end if
            end do
        end do
        ! read footer
        read(*,*) t(1),t(2),t(3),t(4),t(5),t(6),t(7),t(8)
    end subroutine parse_board

    subroutine add_move(board, r, c, moves, num_moves)
        character(len=256), intent(in) :: board
        integer, intent(in) :: r, c
        integer, intent(inout), dimension(8,3) :: moves ! (r,c,num_moves)
        integer, intent(inout) :: num_moves

        if (r >= 0 .and. r < 8) then
            if (c >= 0 .and. c < 8) then
                if (.not. visited(board, r, c)) then
                    num_moves = num_moves+1
                    moves(num_moves, 1) = r
                    moves(num_moves, 2) = c
                    moves(num_moves, 3) = 0
                end if
            end if
        end if
    end subroutine add_move

    subroutine possible_moves(board, r, c, moves, num_moves)
        character(len=256), intent(in) :: board
        integer, intent(in) :: r, c
        integer, intent(out), dimension(8,3) :: moves ! (r,c,num_moves)
        integer, intent(out) :: num_moves

        num_moves = 0
        call add_move(board, r+2, c+1, moves, num_moves)
        call add_move(board, r+2, c-1, moves, num_moves)
        call add_move(board, r-2, c+1, moves, num_moves)
        call add_move(board, r-2, c-1, moves, num_moves)
        call add_move(board, r+1, c+2, moves, num_moves)
        call add_move(board, r-1, c+2, moves, num_moves)
        call add_move(board, r+1, c-2, moves, num_moves)
        call add_move(board, r-1, c-2, moves, num_moves)
    end subroutine possible_moves

    subroutine next_moves(board, r, c, moves, num_moves)
        character(len=256), intent(in) :: board
        integer, intent(in) :: r, c
        integer, intent(out), dimension(8,3) :: moves ! (r,c,num_moves)
        integer, intent(out) :: num_moves
        integer :: i, j
        integer, dimension(8,3) :: temp_moves
        integer :: temp_num_moves, min_moves

        ! get first level moves
        call possible_moves(board, r, c, moves, num_moves)

        ! compute moves from each target
        min_moves = 8+1
        do i = 1, num_moves
            call possible_moves(board, moves(i,1), moves(i,2), temp_moves, temp_num_moves)
            moves(i,3) = temp_num_moves
            if (min_moves > temp_num_moves) then
                min_moves = temp_num_moves
            end if
        end do

        ! filter moves with minimum possible moves
        j = 0
        do i = 1, num_moves
            if (moves(i,3) == min_moves) then
                j = j + 1
                moves(j,1) = moves(i,1)
                moves(j,2) = moves(i,2)
                moves(j,3) = moves(i,3)
            end if
        end do
        num_moves = j
    end subroutine next_moves

    recursive subroutine solve(board, r, c)
        character(len=256), intent(in) :: board
        integer, intent(in) :: r, c
        character(len=256) :: solution, new_board
        integer, dimension(8,3) :: moves
        integer :: num_moves, i
        common /solution/ solution

        if (ended(board)) then
            if (len_trim(solution) > len_trim(board)) then
                solution = board
            end if
        else
            call next_moves(board, r, c, moves, num_moves)
            do i = 1, num_moves
                new_board = board
                call set_knight(new_board, moves(i,1), moves(i,2))
                call solve(new_board, moves(i,1), moves(i,2))
            end do
        end if
    end subroutine solve

end program ch2

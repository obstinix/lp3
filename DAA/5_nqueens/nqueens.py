"""Generate all solutions to the n-Queens problem using backtracking."""


def solve_n_queens(n):
    if n < 1:
        raise ValueError("The number of queens must be a positive integer.")

    board = [["." for _ in range(n)] for _ in range(n)]
    result = []
    cols = set()
    diag1 = set()
    diag2 = set()

    def backtrack(row):
        if row == n:
            result.append(["".join(board_row) for board_row in board])
            return

        for col in range(n):
            if col in cols or row - col in diag1 or row + col in diag2:
                continue

            board[row][col] = "Q"
            cols.add(col)
            diag1.add(row - col)
            diag2.add(row + col)

            backtrack(row + 1)

            board[row][col] = "."
            cols.remove(col)
            diag1.remove(row - col)
            diag2.remove(row + col)

    backtrack(0)
    return result


try:
    n = int(input("Enter the number of queens: "))
except ValueError:
    print("Please enter a positive integer.")
else:
    try:
        solutions = solve_n_queens(n)
    except ValueError as error:
        print(error)
    else:
        print("Total solutions:", len(solutions))
        for index, solution in enumerate(solutions, 1):
            print(f"\nSolution {index}:")
            for row in solution:
                print(row)

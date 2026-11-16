#include <iostream>
#include <string>
#include <vector>
using namespace std;

void solve(int row, int n, vector<string>& board, vector<bool>& columns,
           vector<bool>& diagonal1, vector<bool>& diagonal2,
           vector<vector<string>>& solutions) {
    if (row == n) {
        solutions.push_back(board);
        return;
    }

    for (int col = 0; col < n; ++col) {
        int firstDiagonal = row - col + n - 1;
        int secondDiagonal = row + col;
        if (columns[col] || diagonal1[firstDiagonal] || diagonal2[secondDiagonal]) {
            continue;
        }

        board[row][col] = 'Q';
        columns[col] = true;
        diagonal1[firstDiagonal] = true;
        diagonal2[secondDiagonal] = true;

        solve(row + 1, n, board, columns, diagonal1, diagonal2, solutions);

        board[row][col] = '.';
        columns[col] = false;
        diagonal1[firstDiagonal] = false;
        diagonal2[secondDiagonal] = false;
    }
}

int main() {
    int n;
    cout << "Enter the number of queens: ";
    if (!(cin >> n) || n < 1) {
        cerr << "The number of queens must be a positive integer.\n";
        return 1;
    }

    vector<string> board(n, string(n, '.'));
    vector<bool> columns(n, false);
    vector<bool> diagonal1(2 * n - 1, false);
    vector<bool> diagonal2(2 * n - 1, false);
    vector<vector<string>> solutions;

    solve(0, n, board, columns, diagonal1, diagonal2, solutions);

    cout << "Total solutions: " << solutions.size() << "\n";
    for (size_t i = 0; i < solutions.size(); ++i) {
        cout << "\nSolution " << i + 1 << ":\n";
        for (const string& row : solutions[i]) {
            cout << row << '\n';
        }
    }

    return 0;
}

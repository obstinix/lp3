#include <iostream>
#include <algorithm>
#include <vector>

using namespace std;

int main() {
    int n, capacity;

    cout << "Enter number of items: ";
    cin >> n;

    vector<int> weight(n + 1);
    vector<int> profit(n + 1);

    cout << "Enter weight and profit of each item:\n";
    for (int i = 1; i <= n; i++) {
        cout << "Item " << i << ": ";
        cin >> weight[i] >> profit[i];
    }

    cout << "Enter capacity of knapsack: ";
    cin >> capacity;

    // DP table.
    vector<vector<int>> dp(n + 1, vector<int>(capacity + 1, 0));

    // Build the DP table.
    for (int i = 1; i <= n; i++) {
        for (int w = 1; w <= capacity; w++) {
            if (weight[i] <= w) {
                dp[i][w] = max(
                    profit[i] + dp[i - 1][w - weight[i]],
                    dp[i - 1][w]
                );
            } else {
                dp[i][w] = dp[i - 1][w];
            }
        }
    }

    // Display the maximum profit.
    cout << "\nMaximum Profit = " << dp[n][capacity] << endl;

    // Find the selected items by tracing the DP table backwards.
    int w = capacity;
    cout << "Selected Items: ";

    for (int i = n; i >= 1; i--) {
        if (dp[i][w] != dp[i - 1][w]) {
            cout << i << " ";
            w -= weight[i];
        }
    }

    cout << endl;
    return 0;
}
# LP-3 Laboratory Programs

Programs, datasets and practical notes for Laboratory Practice III. The work is
grouped into three subject folders:

- `BT` for Blockchain Technology
- `DAA` for Design and Analysis of Algorithms
- `ML` for Machine Learning

```text
lp3/
├── BT/                 Solidity contracts, Fabric script, practical and viva notes
├── DAA/                C++ and Python programs, viva notes
├── ML/                 Jupyter notebooks and their CSV datasets
├── lp3-programs.sh     Download menu for single files (Bash)
└── lp3-programs.ps1    Download menu for single files (PowerShell)
```

## Download

```bash
git clone https://github.com/obstinix/lp3.git
```

```bash
curl -L https://github.com/obstinix/lp3/archive/refs/heads/main.zip -o lp3.zip
```

```bash
curl -L https://github.com/obstinix/lp3/archive/refs/heads/main.tar.gz -o lp3.tar.gz
```

To download individual programs, use the menu scripts:

```bash
curl -fL https://raw.githubusercontent.com/obstinix/lp3/main/lp3-programs.sh -o lp3-programs.sh
bash lp3-programs.sh list
bash lp3-programs.sh download daa quicksort
```

On Windows, run `lp3-programs.ps1` with
`powershell -ExecutionPolicy Bypass -File .\lp3-programs.ps1 list` instead.
The menus download only the notebooks, not the datasets.

## BT: Blockchain Technology

| Practical | Topic | Files |
|---|---|---|
| 1 | MetaMask setup and Ether transaction fees | `practical1_instruction.md` |
| 2 | MetaMask wallet for crypto transactions | `practical2_instruction.md` |
| 3 | Bank account smart contract | `Bank.sol`, `SimpleStorage.sol`, `practical3_instruction.md` |
| 4 | Student data using structures, arrays and fallback | `StudentRegistry.sol`, `practical4_instruction.md` |
| 5 | Hyperledger Fabric student registry | `setup-fabric.sh`, `practical5_instruction.md` |

Each practical also has a `practicalN_viva.md` file with viva questions.

**Dependencies:** Remix IDE, MetaMask with Sepolia test ETH, and Solidity 0.8.20
or newer. Practical 5 also needs Ubuntu or WSL with `sudo` access. The script
installs Docker and Fabric 2.5 itself.

**Run Practicals 3 and 4:** open the `.sol` file in
[Remix](https://remix.ethereum.org/). Compile it with 0.8.20, then deploy it
through *Injected Provider - MetaMask*.

**Expected results:**

- `SimpleStorage`: `getValue()` returns the last value stored with `setValue()`.
- `Bank`: `deposit` and `withdraw` update `getBalance()`. Withdrawing more than your balance reverts with `Insufficient balance`.
- `StudentRegistry`: `addStudent`, `getStudent`, `updateStudent` and `getStudentCount` manage the records. Sending ETH with unknown calldata increases `fallbackCallCount`.

**Run Practical 5:**

```bash
cd BT
chmod +x setup-fabric.sh
./setup-fabric.sh          # install, start network, deploy chaincode, run demo
./setup-fabric.sh status   # list Fabric containers
./setup-fabric.sh down     # stop the network
./setup-fabric.sh clean    # stop and remove generated data
```

## DAA: Design and Analysis of Algorithms

| Program | Files | Input |
|---|---|---|
| Fibonacci (iterative and recursive, step count) | `fibonacci.cpp`, `fibonacci_recursive.py`, `fibonacci_non_recursive.py` | number of terms |
| Huffman encoding (greedy) | `huffman.cpp` | number of characters, then `char frequency` pairs |
| 0/1 Knapsack (dynamic programming) | `knapsack.cpp` | number of items, then `weight profit` pairs, then capacity |
| N-Queens (backtracking) | `nqueens.cpp`, `nqueens.py` | number of queens |
| Quick sort, deterministic and randomized | `quicksort.cpp`, `quicksort.py` | array size; the elements are random |

Each topic also has a `*_viva.md` file.

**Dependencies:** `g++` with C++17 support and Python 3. No extra packages are needed.

**Run:**

```bash
cd DAA
g++ -std=c++17 -O2 knapsack.cpp -o knapsack
./knapsack
python3 nqueens.py
```

On Windows, run `knapsack.exe` instead of `./knapsack`, and `py` instead of `python3`.

**Expected outputs:**

- Fibonacci with `10` prints `0 1 1 2 3 5 8 13 21 34` and makes 276 recursive calls.
- Huffman with `a 5, b 9, c 12, d 13, e 16, f 45` gives `f:0 c:100 d:101 a:1100 b:1101 e:111`.
- Knapsack with weights and profits `10 60, 20 100, 30 120` and capacity `50` gives `Maximum Profit = 220`, using items 3 and 2.
- N-Queens with `4` finds 2 solutions and prints both boards.
- Quick sort prints the random array, then both sorted versions with their run times.

## ML: Machine Learning

| Notebook | Experiment | Dataset (in `ML/`) |
|---|---|---|
| `ML_1_UBER.ipynb` | Uber fare prediction: Linear Regression vs Random Forest | `uber.csv` (200,000 rows) |
| `ML_2_EMAIL_SPAM.ipynb` | Email spam classification: KNN vs SVM | `emails.csv` (5,172 emails, word counts) |
| `ML_3_BANK_CHURN.ipynb` | Bank customer churn: neural network | `Churn_Modelling.csv` (10,000 customers) |
| `ML_5_DIABETES.ipynb` | Diabetes prediction: KNN | `diabetes.csv` (768 patients) |
| `ML_6_SALES.ipynb` | Sales clustering: K-Means and hierarchical | `sales_data_sample.csv` (2,823 orders) |

Each notebook loads its CSV by file name, so run the notebooks from inside `ML/`.

**Dependencies:**

```bash
pip install notebook pandas numpy scikit-learn matplotlib seaborn tensorflow
```

TensorFlow is needed only for `ML_3_BANK_CHURN.ipynb`.

**Run:**

```bash
cd ML
jupyter notebook ML_5_DIABETES.ipynb
```

**Expected outputs:**

These are approximate. The neural network varies slightly between runs.

- Uber: Random Forest scores R² ≈ 0.78 and RMSE ≈ 1.95. Linear Regression scores R² ≈ 0.57.
- Email spam: SVM accuracy ≈ 0.96. KNN accuracy ≈ 0.86.
- Bank churn: neural network accuracy ≈ 0.86, with a confusion matrix and classification report.
- Diabetes: KNN accuracy ≈ 0.69, with a confusion matrix and classification report.
- Sales: K-Means silhouette ≈ 0.41. Hierarchical silhouette ≈ 0.38. Also shows elbow and dendrogram plots.

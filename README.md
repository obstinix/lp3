# LP-3 Laboratory Programs

Lab programs, practical instructions and viva notes for Laboratory Practice III
(LP-3). The repository covers three areas:

- **BT**: Blockchain Technology
- **DAA**: Design and Analysis of Algorithms
- **ML**: Machine Learning

It also includes small Bash and PowerShell menus that download only the files
you pick, so you don't need Git.

## Included programs and experiments

### Blockchain Technology (BT)

| Practical | Topic | Files |
|---|---|---|
| 1 | MetaMask setup and Ether transaction fees | `BT/Practical 1/INSTRUCTION.MD`, `viva.md` |
| 2 | MetaMask wallet for crypto transactions | `BT/Practical 2/instruction.md`, `viva.md` |
| 3 | Bank account smart contract (Sepolia) | `Programs/BT/Bank.sol`, `Programs/BT/SimpleStorage.sol` |
| 4 | Student data with structures, arrays and fallback | `Programs/BT/StudentRegistry.sol` |
| 5 | Hyperledger Fabric student registry | `Programs/BT/setup-fabric.sh` |

Practicals 3 to 5 also have `instruction.md` and `viva.md` files under `BT/Practical N/`.

### Design and Analysis of Algorithms (DAA)

| Program | C++ | Python |
|---|---|---|
| Fibonacci series (recursive and non-recursive) | `fibonacci.cpp` | `recursive.py`, `non_recursive.py` |
| Huffman encoding (greedy) | `huffman.cpp` | none |
| 0/1 Knapsack | `knapsack.cpp` | none |
| N-Queens (backtracking) | `nqueens.cpp` | `nqueens.py` |
| Quick sort analysis (deterministic and randomized) | `quicksort.cpp` | `quicksort.py` |

Each folder under `DAA/` also has a `viva.md` file. Copies of the C++ files are
in `Programs/DAA/`.

### Machine Learning (ML)

| Notebook | Experiment | Dataset expected |
|---|---|---|
| `ML_1_UBER.ipynb` | Uber fare prediction (regression) | `uber.csv` |
| `ML_2_EMAIL_SPAM.ipynb` | Email spam classification | `emails.csv` |
| `ML_3_BANK_CHURN.ipynb` | Bank customer churn (neural network) | `Churn_Modelling.csv` |
| `ML_5_DIABETES.ipynb` | Diabetes classification | `diabetes.csv` |
| `ML_6_SALES.ipynb` | Sales data clustering | `sales_data_sample.csv` |

The datasets aren't included in this repository. Put each CSV in the same folder
as its notebook before you run it.

## Technologies used

- **C++17** with `g++`, for the DAA programs
- **Python 3**, for the DAA Python versions
- **Jupyter Notebook** with pandas, NumPy, scikit-learn, Matplotlib, seaborn and TensorFlow, for ML
- **Solidity ^0.8.20** in Remix IDE with MetaMask on the Sepolia testnet, for BT practicals 1 to 4
- **Hyperledger Fabric** with Docker on Ubuntu/Linux, for BT practical 5
- **Bash** and **PowerShell**, for the selective download menus

## Repository structure

```text
lp3/
├── BT/
│   ├── Practical 1 … Practical 5/   Instructions and viva notes (P5 includes setup-fabric.sh)
├── DAA/
│   ├── 1_Fibonacci Series/          fibonacci.cpp, recursive.py, non_recursive.py, viva.md
│   ├── 2_huffman encoding/          huffman.cpp, viva.md
│   ├── 3_Knapsack/                  knapsack.cpp, viva.md
│   ├── 5_nqueens/                   nqueens.cpp, nqueens.py, viva.md
│   └── 6_quick sort analysis/       quicksort.cpp, quicksort.py, viva.md
├── Programs/                        Standalone copies used by the download menus
│   ├── BT/                          Bank.sol, SimpleStorage.sol, StudentRegistry.sol, setup-fabric.sh
│   ├── DAA/                         The five C++ programs
│   ├── ML/                          The five Jupyter notebooks
│   ├── cmd.md                       Per-file download and run commands (CMD, PowerShell, Linux)
│   ├── lp3-programs.sh              Bash download menu
│   └── lp3-programs.ps1             PowerShell download menu
└── README.md
```

## Download

| Method | Link |
|---|---|
| Repository | <https://github.com/obstinix/lp3> |
| ZIP | <https://github.com/obstinix/lp3/archive/refs/heads/main.zip> |
| TAR.GZ | <https://github.com/obstinix/lp3/archive/refs/heads/main.tar.gz> |
| Releases | <https://github.com/obstinix/lp3/releases> |

Clone the repository with Git:

```bash
git clone https://github.com/obstinix/lp3.git
```

Download it as a ZIP file:

```bash
curl -L https://github.com/obstinix/lp3/archive/refs/heads/main.zip -o lp3.zip
```

Download it as a TAR.GZ file:

```bash
curl -L https://github.com/obstinix/lp3/archive/refs/heads/main.tar.gz -o lp3.tar.gz
```

Extract the archive:

```bash
unzip lp3.zip            # creates lp3-main/
tar -xzf lp3.tar.gz      # creates lp3-main/
```

On Windows, use `curl.exe` instead of `curl` in PowerShell. To extract the ZIP
file, run `Expand-Archive lp3.zip`.

### Download single programs with the menu

The menu downloads only the files you choose. They're saved to
`./LP-3-Programs/` by default.

On Linux, macOS, WSL or Git Bash:

```bash
curl -fL https://raw.githubusercontent.com/obstinix/lp3/main/Programs/lp3-programs.sh -o lp3-programs.sh
chmod +x lp3-programs.sh
./lp3-programs.sh list
./lp3-programs.sh download daa quicksort
./lp3-programs.sh download all
```

On Windows PowerShell or CMD:

```powershell
curl.exe -fL https://raw.githubusercontent.com/obstinix/lp3/main/Programs/lp3-programs.ps1 -o lp3-programs.ps1
powershell -ExecutionPolicy Bypass -File .\lp3-programs.ps1 list
powershell -ExecutionPolicy Bypass -File .\lp3-programs.ps1 download ml diabetes
```

The menu uses these names:

| Category | Names |
|---|---|
| `bt` | `simplestorage`, `bank`, `studentregistry`, `setup-fabric` |
| `daa` | `fibonacci`, `huffman`, `knapsack`, `nqueens`, `quicksort` |
| `ml` | `uber`, `email-spam`, `bank-churn`, `diabetes`, `sales` |

To save files somewhere else with the Bash menu, set
`LP3_OUTPUT_DIR=./my-folder`. With the PowerShell menu, pass `-OutputDir`.

## Installation and execution

### DAA: C++

Install `g++`. On Ubuntu, run `sudo apt install g++`. On Windows, install
MinGW-w64 and add it to `PATH`.

```bash
g++ Programs/DAA/quicksort.cpp -std=c++17 -O2 -o quicksort
./quicksort
```

On Windows, run `quicksort.exe` instead. The same steps work for `fibonacci`,
`huffman`, `knapsack` and `nqueens`.

### DAA: Python

```bash
python3 "DAA/1_Fibonacci Series/recursive.py"
python3 "DAA/5_nqueens/nqueens.py"
python3 "DAA/6_quick sort analysis/quicksort.py"
```

On Windows, use `py` instead of `python3`.

### ML: Jupyter notebooks

```bash
python3 -m venv .venv
source .venv/bin/activate          # Windows: .venv\Scripts\activate
pip install notebook pandas numpy scikit-learn matplotlib seaborn tensorflow
python -m notebook Programs/ML/ML_5_DIABETES.ipynb
```

Put the dataset CSV for a notebook next to it before you run its cells.

### BT: Solidity (Practicals 1 to 4)

1. Open the `.sol` file from `Programs/BT/` in [Remix IDE](https://remix.ethereum.org/).
2. Select a Solidity `0.8.20` or newer compiler, then compile.
3. Deploy with an injected MetaMask provider on Sepolia, using test ETH only.

The step-by-step instructions are in `BT/Practical N/instruction.md`.

### BT: Hyperledger Fabric (Practical 5)

Run these on Ubuntu/Linux or WSL, with Docker available:

```bash
chmod +x Programs/BT/setup-fabric.sh
./Programs/BT/setup-fabric.sh           # set up network and deploy chaincode
./Programs/BT/setup-fabric.sh status
./Programs/BT/setup-fabric.sh down
./Programs/BT/setup-fabric.sh clean
./Programs/BT/setup-fabric.sh help
```

## Usage examples

```bash
# Compile and run N-Queens
g++ Programs/DAA/nqueens.cpp -std=c++17 -O2 -o nqueens && ./nqueens

# Download only the Bank contract and the Huffman program
./lp3-programs.sh download bt bank
./lp3-programs.sh download daa huffman
```

[`Programs/cmd.md`](Programs/cmd.md) has the download and run commands for
every file, for Windows CMD, PowerShell and Ubuntu/Linux.

## Notes

- Read scripts before you run them. `setup-fabric.sh` installs packages and uses `sudo`.
- Use test wallets and test ETH only. Never share a Secret Recovery Phrase or a private key.

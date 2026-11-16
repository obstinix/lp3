# BT, DAA, and ML commands

These commands download one file at a time. They do not require Git, GitHub
Desktop, or a GitHub account.

Run download commands from the folder where you want the `BT` and `DAA` folders
created.

## Interactive help and download menu

### Ubuntu/Linux

Download the Bash menu:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/lp3-programs.sh" -o "lp3-programs.sh"
```

Make it executable:

```bash
chmod +x lp3-programs.sh
```

Show help:

```bash
./lp3-programs.sh help
```

List available programs:

```bash
./lp3-programs.sh list
```

Download selected programs:

```bash
./lp3-programs.sh download bt bank
```

```bash
./lp3-programs.sh download daa quicksort
```

```bash
./lp3-programs.sh download ml diabetes
```

Download everything:

```bash
./lp3-programs.sh download all
```

Files are saved inside `./LP-3-Programs` by default. Choose another folder with:

```bash
LP3_OUTPUT_DIR=./my-programs ./lp3-programs.sh download daa fibonacci
```

### Windows PowerShell or CMD

The PowerShell menu works without Bash, WSL, or Git Bash.

Download the PowerShell menu:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/lp3-programs.ps1" -o "lp3-programs.ps1"
```

Show help:

```powershell
powershell -ExecutionPolicy Bypass -File .\lp3-programs.ps1 help
```

List available programs:

```powershell
powershell -ExecutionPolicy Bypass -File .\lp3-programs.ps1 list
```

Download selected programs:

```powershell
powershell -ExecutionPolicy Bypass -File .\lp3-programs.ps1 download bt bank
```

```powershell
powershell -ExecutionPolicy Bypass -File .\lp3-programs.ps1 download daa quicksort
```

```powershell
powershell -ExecutionPolicy Bypass -File .\lp3-programs.ps1 download ml diabetes
```

Download everything:

```powershell
powershell -ExecutionPolicy Bypass -File .\lp3-programs.ps1 download all
```

### Windows WSL or Git Bash

Use this only when you want to run the Bash menu on Windows. Install Ubuntu
through WSL or open Git Bash, then follow the Ubuntu/Linux section above.

Check WSL:

```bat
wsl --status
```

Install Ubuntu if needed from Administrator PowerShell:

```bat
wsl --install -d Ubuntu
```

Run the Bash menu from Windows CMD:

```bat
wsl bash lp3-programs.sh help
```

The Fabric script should run inside Ubuntu/WSL with Docker available.

## Common command templates

Only the filename and path change between programs.

### Download a file on Windows CMD

```bat
curl.exe -fL "RAW_GITHUB_URL" -o "LOCAL_FOLDER\FILE_NAME"
```

Example:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/fibonacci.cpp" -o "DAA\fibonacci.cpp"
```

### Download a file on Windows PowerShell

```powershell
curl.exe -fL "RAW_GITHUB_URL" -o "LOCAL_FOLDER\FILE_NAME"
```

### Download a file on Ubuntu/Linux

```bash
curl -fL "RAW_GITHUB_URL" -o "LOCAL_FOLDER/FILE_NAME"
```

### Compile a C++ file on Windows

```bat
g++ FOLDER\FILE_NAME.cpp -std=c++17 -O2 -o FOLDER\FILE_NAME.exe
```

### Run a C++ program on Windows CMD

```bat
FOLDER\FILE_NAME.exe
```

### Run a C++ program on Windows PowerShell

```powershell
.\FOLDER\FILE_NAME.exe
```

### Compile a C++ file on Ubuntu/Linux

```bash
g++ FOLDER/FILE_NAME.cpp -std=c++17 -O2 -o FOLDER/FILE_NAME
```

### Run a C++ program on Ubuntu/Linux

```bash
./FOLDER/FILE_NAME
```

### Run a Python file on Windows

```bat
py "FOLDER\FILE_NAME.py"
```

### Run a Python file on Ubuntu/Linux

```bash
python3 "FOLDER/FILE_NAME.py"
```

### Open a Jupyter notebook on Windows

```bat
py -m notebook "ML\FILE_NAME.ipynb"
```

### Open a Jupyter notebook on Ubuntu/Linux

```bash
python3 -m notebook "ML/FILE_NAME.ipynb"
```

### Run a shell script on Ubuntu/Linux

```bash
chmod +x FOLDER/FILE_NAME.sh
./FOLDER/FILE_NAME.sh
```

## Download files on Windows Command Prompt

Create the BT folder:

```bat
mkdir BT
```

Download `SimpleStorage.sol`:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/BT/SimpleStorage.sol" -o "BT\SimpleStorage.sol"
```

Download `Bank.sol`:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/BT/Bank.sol" -o "BT\Bank.sol"
```

Download `StudentRegistry.sol`:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/BT/StudentRegistry.sol" -o "BT\StudentRegistry.sol"
```

Download the Fabric setup script:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/BT/setup-fabric.sh" -o "BT\setup-fabric.sh"
```

Create the DAA folder:

```bat
mkdir DAA
```

Download `fibonacci.cpp`:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/fibonacci.cpp" -o "DAA\fibonacci.cpp"
```

Download `huffman.cpp`:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/huffman.cpp" -o "DAA\huffman.cpp"
```

Download `knapsack.cpp`:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/knapsack.cpp" -o "DAA\knapsack.cpp"
```

Download `nqueens.cpp`:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/nqueens.cpp" -o "DAA\nqueens.cpp"
```

Download `quicksort.cpp`:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/quicksort.cpp" -o "DAA\quicksort.cpp"
```

## Download files on Windows PowerShell

Create the folders:

```powershell
New-Item -ItemType Directory -Force BT, DAA
```

Download `SimpleStorage.sol`:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/BT/SimpleStorage.sol" -o "BT\SimpleStorage.sol"
```

Download `Bank.sol`:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/BT/Bank.sol" -o "BT\Bank.sol"
```

Download `StudentRegistry.sol`:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/BT/StudentRegistry.sol" -o "BT\StudentRegistry.sol"
```

Download the Fabric setup script:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/BT/setup-fabric.sh" -o "BT\setup-fabric.sh"
```

Download `fibonacci.cpp`:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/fibonacci.cpp" -o "DAA\fibonacci.cpp"
```

Download `huffman.cpp`:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/huffman.cpp" -o "DAA\huffman.cpp"
```

Download `knapsack.cpp`:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/knapsack.cpp" -o "DAA\knapsack.cpp"
```

Download `nqueens.cpp`:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/nqueens.cpp" -o "DAA\nqueens.cpp"
```

Download `quicksort.cpp`:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/quicksort.cpp" -o "DAA\quicksort.cpp"
```

## Download files on Ubuntu/Linux

Create the BT folder:

```bash
mkdir -p BT
```

Download `SimpleStorage.sol`:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/BT/SimpleStorage.sol" -o "BT/SimpleStorage.sol"
```

Download `Bank.sol`:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/BT/Bank.sol" -o "BT/Bank.sol"
```

Download `StudentRegistry.sol`:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/BT/StudentRegistry.sol" -o "BT/StudentRegistry.sol"
```

Download the Fabric setup script:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/BT/setup-fabric.sh" -o "BT/setup-fabric.sh"
```

Create the DAA folder:

```bash
mkdir -p DAA
```

Download `fibonacci.cpp`:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/fibonacci.cpp" -o "DAA/fibonacci.cpp"
```

Download `huffman.cpp`:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/huffman.cpp" -o "DAA/huffman.cpp"
```

Download `knapsack.cpp`:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/knapsack.cpp" -o "DAA/knapsack.cpp"
```

Download `nqueens.cpp`:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/nqueens.cpp" -o "DAA/nqueens.cpp"
```

Download `quicksort.cpp`:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/DAA/quicksort.cpp" -o "DAA/quicksort.cpp"
```

## Download ML notebooks on Windows CMD

Create the ML folder:

```bat
mkdir ML
```

Download `ML_1_UBER.ipynb`:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_1_UBER.ipynb" -o "ML\ML_1_UBER.ipynb"
```

Download `ML_2_EMAIL_SPAM.ipynb`:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_2_EMAIL_SPAM.ipynb" -o "ML\ML_2_EMAIL_SPAM.ipynb"
```

Download `ML_3_BANK_CHURN.ipynb`:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_3_BANK_CHURN.ipynb" -o "ML\ML_3_BANK_CHURN.ipynb"
```

Download `ML_5_DIABETES.ipynb`:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_5_DIABETES.ipynb" -o "ML\ML_5_DIABETES.ipynb"
```

Download `ML_6_SALES.ipynb`:

```bat
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_6_SALES.ipynb" -o "ML\ML_6_SALES.ipynb"
```

## Download ML notebooks on Windows PowerShell

Create the ML folder:

```powershell
New-Item -ItemType Directory -Force ML
```

Download `ML_1_UBER.ipynb`:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_1_UBER.ipynb" -o "ML\ML_1_UBER.ipynb"
```

Download `ML_2_EMAIL_SPAM.ipynb`:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_2_EMAIL_SPAM.ipynb" -o "ML\ML_2_EMAIL_SPAM.ipynb"
```

Download `ML_3_BANK_CHURN.ipynb`:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_3_BANK_CHURN.ipynb" -o "ML\ML_3_BANK_CHURN.ipynb"
```

Download `ML_5_DIABETES.ipynb`:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_5_DIABETES.ipynb" -o "ML\ML_5_DIABETES.ipynb"
```

Download `ML_6_SALES.ipynb`:

```powershell
curl.exe -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_6_SALES.ipynb" -o "ML\ML_6_SALES.ipynb"
```

## Download ML notebooks on Ubuntu/Linux

Create the ML folder:

```bash
mkdir -p ML
```

Download `ML_1_UBER.ipynb`:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_1_UBER.ipynb" -o "ML/ML_1_UBER.ipynb"
```

Download `ML_2_EMAIL_SPAM.ipynb`:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_2_EMAIL_SPAM.ipynb" -o "ML/ML_2_EMAIL_SPAM.ipynb"
```

Download `ML_3_BANK_CHURN.ipynb`:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_3_BANK_CHURN.ipynb" -o "ML/ML_3_BANK_CHURN.ipynb"
```

Download `ML_5_DIABETES.ipynb`:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_5_DIABETES.ipynb" -o "ML/ML_5_DIABETES.ipynb"
```

Download `ML_6_SALES.ipynb`:

```bash
curl -fL "https://raw.githubusercontent.com/obstinix/lp3/main/Programs/ML/ML_6_SALES.ipynb" -o "ML/ML_6_SALES.ipynb"
```

## Run C++ programs on Windows

Install MinGW-w64 and ensure `g++` is available in `PATH`.

Compile `fibonacci.cpp`:

```bat
g++ DAA\fibonacci.cpp -std=c++17 -O2 -o DAA\fibonacci.exe
```

Run Fibonacci:

```bat
DAA\fibonacci.exe
```

Compile and run the other programs by replacing `fibonacci` with `huffman`,
`knapsack`, `nqueens`, or `quicksort`:

```bat
g++ DAA\huffman.cpp -std=c++17 -O2 -o DAA\huffman.exe
DAA\huffman.exe
```

```bat
g++ DAA\knapsack.cpp -std=c++17 -O2 -o DAA\knapsack.exe
DAA\knapsack.exe
```

```bat
g++ DAA\nqueens.cpp -std=c++17 -O2 -o DAA\nqueens.exe
DAA\nqueens.exe
```

```bat
g++ DAA\quicksort.cpp -std=c++17 -O2 -o DAA\quicksort.exe
DAA\quicksort.exe
```

In PowerShell, run an executable with `.\DAA\fibonacci.exe`.

## Run C++ programs on Ubuntu/Linux

Install the compiler:

```bash
sudo apt update
```

```bash
sudo apt install g++
```

Compile `fibonacci.cpp`:

```bash
g++ DAA/fibonacci.cpp -std=c++17 -O2 -o DAA/fibonacci
```

Run Fibonacci:

```bash
./DAA/fibonacci
```

Compile and run the other programs:

```bash
g++ DAA/huffman.cpp -std=c++17 -O2 -o DAA/huffman
```

```bash
./DAA/huffman
```

```bash
g++ DAA/knapsack.cpp -std=c++17 -O2 -o DAA/knapsack
```

```bash
./DAA/knapsack
```

```bash
g++ DAA/nqueens.cpp -std=c++17 -O2 -o DAA/nqueens
```

```bash
./DAA/nqueens
```

```bash
g++ DAA/quicksort.cpp -std=c++17 -O2 -o DAA/quicksort
```

```bash
./DAA/quicksort
```

## Run Python programs

The Python files remain in their original DAA practical folders.

### Windows

```bat
py "DAA\1_Fibonacci Series\non_recursive.py"
```

```bat
py "DAA\1_Fibonacci Series\recursive.py"
```

```bat
py "DAA\5_nqueens\nqueens.py"
```

```bat
py "DAA\6_quick sort analysis\quicksort.py"
```

If `py` is unavailable, use `python` instead.

### Ubuntu/Linux

Install Python:

```bash
sudo apt update
```

```bash
sudo apt install python3
```

Run each file:

```bash
python3 "DAA/1_Fibonacci Series/non_recursive.py"
```

```bash
python3 "DAA/1_Fibonacci Series/recursive.py"
```

```bash
python3 "DAA/5_nqueens/nqueens.py"
```

```bash
python3 "DAA/6_quick sort analysis/quicksort.py"
```

## Run ML notebooks on Windows

Install Jupyter Notebook:

```bat
py -m pip install notebook
```

Open `ML_1_UBER.ipynb`:

```bat
py -m notebook "ML\ML_1_UBER.ipynb"
```

Open `ML_2_EMAIL_SPAM.ipynb`:

```bat
py -m notebook "ML\ML_2_EMAIL_SPAM.ipynb"
```

Open `ML_3_BANK_CHURN.ipynb`:

```bat
py -m notebook "ML\ML_3_BANK_CHURN.ipynb"
```

Open `ML_5_DIABETES.ipynb`:

```bat
py -m notebook "ML\ML_5_DIABETES.ipynb"
```

Open `ML_6_SALES.ipynb`:

```bat
py -m notebook "ML\ML_6_SALES.ipynb"
```

## Run ML notebooks on Ubuntu/Linux

Install Python, pip, and the virtual-environment package:

```bash
sudo apt update
```

```bash
sudo apt install python3 python3-pip python3-venv
```

Create and activate a virtual environment:

```bash
python3 -m venv .venv
```

```bash
source .venv/bin/activate
```

Install Jupyter Notebook:

```bash
python -m pip install notebook
```

Open `ML_1_UBER.ipynb`:

```bash
python -m notebook "ML/ML_1_UBER.ipynb"
```

Open `ML_2_EMAIL_SPAM.ipynb`:

```bash
python -m notebook "ML/ML_2_EMAIL_SPAM.ipynb"
```

Open `ML_3_BANK_CHURN.ipynb`:

```bash
python -m notebook "ML/ML_3_BANK_CHURN.ipynb"
```

Open `ML_5_DIABETES.ipynb`:

```bash
python -m notebook "ML/ML_5_DIABETES.ipynb"
```

Open `ML_6_SALES.ipynb`:

```bash
python -m notebook "ML/ML_6_SALES.ipynb"
```

## BT Solidity programs

Open each `.sol` file in [Remix IDE](https://remix.ethereum.org/), choose a
compatible Solidity `0.8.x` compiler, compile it, and deploy it using the
Practical 1-4 instructions. Solidity programs are not run from Command Prompt
or the Linux terminal.

## Run BT Practical 5

The Fabric script is intended for Ubuntu/Linux with Docker and `sudo`.

Make it executable:

```bash
chmod +x BT/setup-fabric.sh
```

Run the setup:

```bash
./BT/setup-fabric.sh
```

Show status:

```bash
./BT/setup-fabric.sh status
```

Stop the network:

```bash
./BT/setup-fabric.sh down
```

Clean generated data:

```bash
./BT/setup-fabric.sh clean
```

Show help:

```bash
./BT/setup-fabric.sh help
```

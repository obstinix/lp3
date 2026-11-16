param(
    [Parameter(Position = 0)]
    [string]$Action = "help",

    [Parameter(Position = 1)]
    [string]$Category,

    [Parameter(Position = 2)]
    [string]$Name,

    [string]$OutputDir = "LP-3-Programs"
)

$ErrorActionPreference = "Stop"
$BaseUrl = "https://raw.githubusercontent.com/obstinix/lp3/main/Programs"

function Show-Usage {
    @"
LP-3 Windows program downloader

Usage:
  .\lp3-programs.ps1 help
  .\lp3-programs.ps1 list
  .\lp3-programs.ps1 download bt <name>
  .\lp3-programs.ps1 download daa <name>
  .\lp3-programs.ps1 download ml <name>
  .\lp3-programs.ps1 download all

BT names:
  simplestorage, bank, studentregistry, setup-fabric

DAA names:
  fibonacci, huffman, knapsack, nqueens, quicksort

ML names:
  uber, email-spam, bank-churn, diabetes, sales

Examples:
  .\lp3-programs.ps1 list
  .\lp3-programs.ps1 download bt bank
  .\lp3-programs.ps1 download daa quicksort
  .\lp3-programs.ps1 download ml diabetes
  .\lp3-programs.ps1 download all

Use -OutputDir to choose another folder:
  .\lp3-programs.ps1 download ml sales -OutputDir .\my-programs
"@
}

function Download-ProgramFile([string]$RelativePath) {
    $destination = Join-Path $OutputDir $RelativePath
    $parent = Split-Path -Parent $destination
    New-Item -ItemType Directory -Force -Path $parent | Out-Null
    $url = "$BaseUrl/$($RelativePath.Replace('\', '/'))"
    Write-Output "Downloading $RelativePath..."
    Invoke-WebRequest -Uri $url -OutFile $destination
    Write-Output "Saved to $destination"
}

function Download-Bt([string]$ProgramName) {
    switch ($ProgramName) {
        "simplestorage" { Download-ProgramFile "BT\SimpleStorage.sol" }
        "bank" { Download-ProgramFile "BT\Bank.sol" }
        "studentregistry" { Download-ProgramFile "BT\StudentRegistry.sol" }
        "setup-fabric" { Download-ProgramFile "BT\setup-fabric.sh" }
        default { throw "Unknown BT name: $ProgramName" }
    }
}

function Download-Daa([string]$ProgramName) {
    switch ($ProgramName) {
        "fibonacci" { Download-ProgramFile "DAA\fibonacci.cpp" }
        "huffman" { Download-ProgramFile "DAA\huffman.cpp" }
        "knapsack" { Download-ProgramFile "DAA\knapsack.cpp" }
        "nqueens" { Download-ProgramFile "DAA\nqueens.cpp" }
        "quicksort" { Download-ProgramFile "DAA\quicksort.cpp" }
        default { throw "Unknown DAA name: $ProgramName" }
    }
}

function Download-Ml([string]$ProgramName) {
    switch ($ProgramName) {
        "uber" { Download-ProgramFile "ML\ML_1_UBER.ipynb" }
        "email-spam" { Download-ProgramFile "ML\ML_2_EMAIL_SPAM.ipynb" }
        "bank-churn" { Download-ProgramFile "ML\ML_3_BANK_CHURN.ipynb" }
        "diabetes" { Download-ProgramFile "ML\ML_5_DIABETES.ipynb" }
        "sales" { Download-ProgramFile "ML\ML_6_SALES.ipynb" }
        default { throw "Unknown ML name: $ProgramName" }
    }
}

function Show-List {
    @"
BT:
  simplestorage       SimpleStorage.sol
  bank                Bank.sol
  studentregistry     StudentRegistry.sol
  setup-fabric        setup-fabric.sh

DAA:
  fibonacci           fibonacci.cpp
  huffman             huffman.cpp
  knapsack            knapsack.cpp
  nqueens             nqueens.cpp
  quicksort           quicksort.cpp

ML:
  uber                ML_1_UBER.ipynb
  email-spam          ML_2_EMAIL_SPAM.ipynb
  bank-churn          ML_3_BANK_CHURN.ipynb
  diabetes            ML_5_DIABETES.ipynb
  sales               ML_6_SALES.ipynb
"@
}

function Download-All {
    Download-Bt "simplestorage"
    Download-Bt "bank"
    Download-Bt "studentregistry"
    Download-Bt "setup-fabric"
    Download-Daa "fibonacci"
    Download-Daa "huffman"
    Download-Daa "knapsack"
    Download-Daa "nqueens"
    Download-Daa "quicksort"
    Download-Ml "uber"
    Download-Ml "email-spam"
    Download-Ml "bank-churn"
    Download-Ml "diabetes"
    Download-Ml "sales"
}

try {
    switch ($Action.ToLowerInvariant()) {
        "help" { Show-Usage }
        "list" { Show-List }
        "download" {
            if ($Category -eq "all") {
                Download-All
                break
            }
            if ([string]::IsNullOrWhiteSpace($Name)) {
                Show-Usage
                throw "A program name is required."
            }
            switch ($Category.ToLowerInvariant()) {
                "bt" { Download-Bt $Name.ToLowerInvariant() }
                "daa" { Download-Daa $Name.ToLowerInvariant() }
                "ml" { Download-Ml $Name.ToLowerInvariant() }
                default {
                    Show-Usage
                    throw "Use bt, daa, ml, or all after download."
                }
            }
        }
        default {
            Show-Usage
            throw "Unknown command: $Action"
        }
    }
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}

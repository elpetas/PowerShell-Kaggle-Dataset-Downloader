param (
    [string]$kaggleUsername,
    [string]$kaggleKey,
    [string]$datasetLink,
    [int]$columnNumber
)

# Function to download dataset from Kaggle
function Download-Dataset {
    param (
        [string]$kaggleUsername,
        [string]$kaggleKey,
        [string]$datasetLink
    )

    $datasetName = $datasetLink.Split('/')[-1]

    if (-not (Test-Path "$datasetName.zip")) {
        Write-Host "Downloading dataset from Kaggle..."
        kaggle datasets download -d $datasetName -u $kaggleUsername -p .
        Expand-Archive -Path "$datasetName.zip" -DestinationPath .
        Remove-Item "$datasetName.zip"
        Write-Host "Dataset downloaded and extracted."
    } else {
        Write-Host "Dataset already exists. Skipping download."
    }

    return $datasetName
}

# Function to extract unique values from a CSV column
function Extract-UniqueValues {
    param (
        [string]$csvFile,
        [int]$columnNumber
    )

    if (-not (Test-Path $csvFile)) {
        Write-Error "Error: File not found - $csvFile"
        return
    }

    $uniqueValues = Import-Csv $csvFile | Select-Object -ExpandProperty "Column$columnNumber" -Unique
    $uniqueValues
}

# Function to format text file into SQL statements
function Format-ToSQL {
    param (
        [string]$inputFile
    )

    if (-not (Test-Path $inputFile)) {
        Write-Error "Error: File '$inputFile' not found."
        return
    }

    $outputFile = "$($inputFile -replace '\.txt$', '')_formatted.sql"
    $formattedLines = Get-Content $inputFile | ForEach-Object { "INSERT INTO traveling (item) VALUES ('$($_.Trim().Replace("'", "''"))');" }
    $formattedLines | Set-Content $outputFile

    Write-Host "Script completed. Formatted SQL statements are stored in '$outputFile'."
}

# Check if Kaggle credentials and dataset link are provided
if ($kaggleUsername -and $kaggleKey -and $datasetLink) {
    # Download dataset from Kaggle
    $datasetName = Download-Dataset -kaggleUsername $kaggleUsername -kaggleKey $kaggleKey -datasetLink $datasetLink

    # Check if CSV file exists in downloaded dataset
    $csvFile = Get-ChildItem -Path . -Filter "*.csv" | Select-Object -ExpandProperty FullName
    if (-not $csvFile) {
        Write-Error "Error: CSV file not found in the downloaded dataset."
        exit 1
    }

    # Extract unique values from CSV column
    $uniqueValues = Extract-UniqueValues -csvFile $csvFile -columnNumber $columnNumber
    Write-Host "Unique values in column $columnNumber:"
    $uniqueValues
}

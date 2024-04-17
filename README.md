# PowerShell Kaggle Dataset Downloader and Data Formatter

This PowerShell script allows you to download a dataset from Kaggle, extract unique values from a specified column in a CSV file within the dataset, and format the extracted values into SQL statements.

## Prerequisites

Before using this script, you need to have the following installed:

- [Kaggle API](https://github.com/Kaggle/kaggle-api)
- [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell)
- A Kaggle account with API access enabled
- Your Kaggle API credentials (username and key)

## Usage

1. **Clone the Repository**: Clone this repository to your local machine.

   ```bash
   git clone https://github.com/yourusername/powershell-kaggle-dataset-downloader.git
   ```

2. **Navigate to the Repository**: Go to the directory where you cloned the repository.

   ```bash
   cd powershell-kaggle-dataset-downloader
   ```

3. **Set Up Kaggle API Credentials**: Place your Kaggle API credentials (`kaggle.json`) in the repository directory.

4. **Run the Script**: Execute the PowerShell script with the necessary parameters.

   ```powershell
   .\MergeScript.ps1 -kaggleUsername "your_kaggle_username" -kaggleKey "your_kaggle_api_key" -datasetLink "https://www.kaggle.com/dataset_link" -columnNumber 2
   ```

   Replace `"your_kaggle_username"`, `"your_kaggle_api_key"`, `"https://www.kaggle.com/dataset_link"`, and `2` with your actual Kaggle username, API key, dataset link, and the desired column number, respectively.

5. **Review Output**: The script will download the dataset from Kaggle, extract unique values from the specified column in the CSV file, and display the unique values.

6. **Formatted SQL Statements**: If successful, the script will generate formatted SQL statements and store them in a file named `inputFile_formatted.sql`.

## Parameters

- **kaggleUsername**: Your Kaggle username.
- **kaggleKey**: Your Kaggle API key.
- **datasetLink**: The link to the Kaggle dataset you want to download.
- **columnNumber**: The number of the column from which you want to extract unique values (1-based index).

## License

This project is licensed under the [MIT License](LICENSE).

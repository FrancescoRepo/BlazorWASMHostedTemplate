# Define the paths
$rootDir = Get-Location
$foldersToClean = @("Client", "Server", "Shared")
$zipFileName = "Template.zip"

# Function to delete bin and obj folders from specified directories
foreach ($folder in $foldersToClean) {
    $binFolder = Join-Path $rootDir "$folder\bin"
    $objFolder = Join-Path $rootDir "$folder\obj"

    if (Test-Path $binFolder) {
        Remove-Item -Recurse -Force $binFolder
        Write-Host "Deleted: $binFolder"
        Start-Sleep -Seconds 1  # Delay for 1 second
    }

    if (Test-Path $objFolder) {
        Remove-Item -Recurse -Force $objFolder
        Write-Host "Deleted: $objFolder"
        Start-Sleep -Seconds 1  # Delay for 1 second
    }
}

# List of items to include in the zip file
$itemsToZip = @(
    "Client",
    "Server",
    "Shared",
    "BlazorWasmHostedTemplate.sln",
    "template.png",
    "WebApplication.vstemplate"
)

# Create the zip file
$zipFilePath = Join-Path $rootDir $zipFileName

if (Test-Path $zipFilePath) {
    Remove-Item $zipFilePath -Force
    Write-Host "Old zip file deleted: $zipFilePath"
    Start-Sleep -Seconds 1  # Delay for 1 second
}

Compress-Archive -Path $itemsToZip -DestinationPath $zipFilePath
Write-Host "Zip file created: $zipFilePath"

# Final sleep for effect
Start-Sleep -Seconds 2
Write-Host "Process complete."

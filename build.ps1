New-Item -ItemType Directory -Force -Path dist | Out-Null

# create an array of os and arch to build for
$osArch = @(
    @{os = "linux"; arch = "amd64"; fo = "linux-amd64"}
    @{os = "darwin"; arch = "amd64"; fo = "macos-intel"}
    @{os = "darwin"; arch = "arm64"; fo = "macos-apple-silicon"}
    @{os = "windows"; arch = "amd64"; fo = "windows-amd64"}
    @{os = "windows"; arch = "386"; fo = "windows-x86"}
)

# loop through the array and build for each os and arch
foreach ($item in $osArch) {
    $env:GOOS = $item.os
    $env:GOARCH = $item.arch
    $outputFile = "dist\8mb"
    if ($item.os -eq "windows") {
        $outputFile += ".exe"
    }
    Write-Output "Building for $env:GOOS-$env:GOARCH"
    go build -o $outputFile 8mb.go
    Compress-Archive -Path $outputFile -DestinationPath dist/8mb-$($item.fo).zip
    Remove-Item $outputFile
}
$rainbowTable = [System.IO.StreamWriter]::new(".\rainbow-table.txt", $false)


for ($i = 0; $i -lt 1000000; $i++) {
    $attemptCode = $i.ToString().PadLeft(6, '0')
    
    $attemptHash = (Get-FileHash -Algorithm SHA256 -InputStream ([System.IO.MemoryStream]::new([System.Text.Encoding]::UTF8.GetBytes($attemptCode)))).Hash

    $rainbowTable.WriteLine("$attemptCode=$attemptHash")

    if ($i % 100000 -eq 0) {
        $progress = ($i/10000)
        Write-Host "Rainbow table generation $([math]::Floor($progress))% complete"
    }
}

$rainbowTable.Close()

Write-Host "Table created as rainbow-table.txt"


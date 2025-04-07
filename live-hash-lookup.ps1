$searchHashes = @{
    'Erik'  = '9e89895d350e5fdac013006b2acb067f8516149cdf7e952b021ff0326718ab70';
    'Logan' = 'af95a5393589cace29a63eead5328f1647a8bc62b5ef18b023c574484a877ced';
    'Cody'  = '30fc150e7c8b42dd86b1bb6e67ee256be8230969bb37cc111749e87af383ae82'
}

for ($i = 000000; $i -lt 999999; $i++) {
    $attemptCode = $i.ToString().PadLeft(6, '0')
    
    $attemptHash = (Get-FileHash -Algorithm SHA256 -InputStream ([System.IO.MemoryStream]::new([System.Text.Encoding]::UTF8.GetBytes($attemptCode)))).Hash

    foreach ($key in $searchHashes.Keys) {
        if ($searchHashes[$key] -eq $attemptHash) {
            Write-Host -ForegroundColor Green "Successfully discovered the passcode of $key"
            Write-Host "$key Hash: $($searchHashes[$key])"
            Write-Host "Found Hash: $attemptHash"
            Write-Host "Unhashed passcode: $attemptCode"
            Write-Host ""
        }
    }

    if ($i % 100000 -eq 0) {
        $progress = ($i/10000)
        Write-Host "Search $([math]::Floor($progress))% complete"
    }
}

Write-Host "Search completed."
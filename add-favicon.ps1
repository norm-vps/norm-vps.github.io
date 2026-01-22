# Скрипт для добавления фавикона на все страницы блога
$blogPath = "C:\Users\celll\Desktop\norm-vps.github.io-main\blog"
$faviconCode = @"
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
    <link rel="icon" type="image/png" href="/favicon.png" />
    <link rel="apple-touch-icon" href="/apple-touch-icon.png" />
"@

Get-ChildItem -Path $blogPath -Directory | ForEach-Object {
    $indexFile = Join-Path $_.FullName "index.html"
    if (Test-Path $indexFile) {
        $content = Get-Content $indexFile -Raw -Encoding UTF8
        if ($content -notmatch 'favicon') {
            # Находим место после viewport и добавляем фавикон
            $content = $content -replace '(<meta name="viewport"[^>]*/>)', "`$1`n$faviconCode"
            Set-Content -Path $indexFile -Value $content -Encoding UTF8 -NoNewline
            Write-Host "Добавлен фавикон в: $($_.Name)"
        } else {
            Write-Host "Фавикон уже есть в: $($_.Name)"
        }
    }
}

Write-Host "`nГотово! Фавикон добавлен на все страницы блога."

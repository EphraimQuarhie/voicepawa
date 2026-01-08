# Comprehensive color replacement script - Convert all colors to black and white only

$htmlFiles = Get-ChildItem "www\*.html"

foreach ($file in $htmlFiles) {
    Write-Host "Processing $($file.Name)..."
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace Tailwind config colors
    $content = $content -replace "'vp-primary': '#[^']+'", "'vp-primary': '#000000'"
    $content = $content -replace "'vp-secondary': '#[^']+'", "'vp-secondary': '#000000'"
    $content = $content -replace "'vp-dark': '#[^']+'", "'vp-dark': '#ffffff'"
    
    # Replace rgba colors with non-black/white values to black with same opacity
    $content = $content -replace "rgba\(251,\s*191,\s*36,\s*([^)]+)\)", "rgba(0, 0, 0, `$1)"
    $content = $content -replace "rgba\(249,\s*115,\s*22,\s*([^)]+)\)", "rgba(0, 0, 0, `$1)"
    $content = $content -replace "rgba\(245,\s*158,\s*11,\s*([^)]+)\)", "rgba(0, 0, 0, `$1)"
    $content = $content -replace "rgba\(234,\s*88,\s*12,\s*([^)]+)\)", "rgba(0, 0, 0, `$1)"
    $content = $content -replace "rgba\(59,\s*130,\s*246,\s*([^)]+)\)", "rgba(0, 0, 0, `$1)" # blue
    $content = $content -replace "rgba\(147,\s*51,\s*234,\s*([^)]+)\)", "rgba(0, 0, 0, `$1)" # purple
    $content = $content -replace "rgba\(236,\s*72,\s*153,\s*([^)]+)\)", "rgba(0, 0, 0, `$1)" # pink
    $content = $content -replace "rgba\(234,\s*179,\s*8,\s*([^)]+)\)", "rgba(0, 0, 0, `$1)" # yellow
    $content = $content -replace "rgba\(34,\s*197,\s*94,\s*([^)]+)\)", "rgba(0, 0, 0, `$1)" # green
    
    # Replace hex color codes
    $content = $content -replace "#fbbf24|#f97316|#f59e0b|#ea580c|#fcd34d", "#000000"
    $content = $content -replace "#3b82f6|#6366f1|#ec4899|#eab308|#22c55e", "#000000"
    
    # Replace colored text/bg/border classes (but keep black/white/gray variants)
    $content = $content -replace 'text-(orange|yellow|blue|purple|pink|green|cyan|red|violet|indigo|amber|emerald|teal|lime|sky)-(\d+)', 'text-black'
    $content = $content -replace 'bg-(orange|yellow|blue|purple|pink|green|cyan|red|violet|indigo|amber|emerald|teal|lime|sky)-(\d+)', 'bg-black'
    $content = $content -replace 'border-(orange|yellow|blue|purple|pink|green|cyan|red|violet|indigo|amber|emerald|teal|lime|sky)-(\d+)', 'border-black'
    $content = $content -replace 'hover:bg-(orange|yellow|blue|purple|pink|green|cyan|red)-(\d+)', 'hover:bg-black'
    $content = $content -replace 'hover:text-(orange|yellow|blue|purple|pink|green|cyan|red)-(\d+)', 'hover:text-black'
    
    # Replace gradient backgrounds to black/white
    $content = $content -replace 'from-(orange|yellow|blue|purple|pink|green|cyan|red)-(\d+)', 'from-black'
    $content = $content -replace 'via-(orange|yellow|blue|purple|pink|green|cyan|red)-(\d+)', 'via-black'
    $content = $content -replace 'to-(orange|yellow|blue|purple|pink|green|cyan|red)-(\d+)', 'to-black'
    
    # Replace gradient-to-r that uses colors
    $content = $content -replace 'bg-gradient-to-r from-vp-primary via-orange-\d+ to-vp-primary', 'bg-black'
    $content = $content -replace 'bg-gradient-to-r from-vp-primary to-orange-\d+', 'bg-black'
    $content = $content -replace 'from-vp-primary via-orange-\d+ to-vp-primary', 'from-black via-black to-black'
    
    # Replace specific color mentions in styles
    $content = $content -replace 'background:\s*linear-gradient\([^)]*#fbbf24[^)]*\)', 'background: #000000'
    $content = $content -replace 'background:\s*linear-gradient\([^)]*#f97316[^)]*\)', 'background: #000000'
    
    Set-Content -Path $file.FullName -Value $content -NoNewline -Encoding UTF8
    Write-Host "  ✓ Completed $($file.Name)"
}

Write-Host "`nAll files updated successfully!"


# Atualiza requirements.txt periodicamente com o que está instalado na venv.
# Uso: abra um terminal na raiz do projeto e rode:
#   .\scripts\update_requirements.ps1
# Deixe essa janela aberta; ela roda em loop até você fechar (Ctrl+C para parar).

$intervalMinutes = 15

$root = Split-Path -Parent $PSScriptRoot
$pip = Join-Path $root ".venv\Scripts\pip.exe"
$reqFile = Join-Path $root "requirements.txt"

if (-not (Test-Path $pip)) {
    Write-Host "Venv não encontrada em $pip. Crie a venv antes de rodar este script." -ForegroundColor Red
    exit 1
}

Write-Host "Atualizando $reqFile a cada $intervalMinutes minuto(s). Ctrl+C para parar."

while ($true) {
    $packages = & $pip freeze
    [System.IO.File]::WriteAllLines($reqFile, $packages)
    Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] requirements.txt atualizado ($($packages.Count) pacotes)."
    Start-Sleep -Seconds ($intervalMinutes * 60)
}

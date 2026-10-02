param(
    [switch]$Foreground
)

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$python = Join-Path $projectRoot 'venv\Scripts\python.exe'
$server = Join-Path $projectRoot 'server\server.py'
$arguments = @(
    $server,
    '--mcp-port',
    '3000',
    '--disable-tools',
    'windows,bookmarks,history,requests,debug'
)

if (-not (Test-Path -LiteralPath $python)) {
    throw "FoxMCP virtual environment was not found at $python."
}

if ($Foreground) {
    & $python @arguments
    exit $LASTEXITCODE
}

Start-Process -FilePath $python -ArgumentList $arguments -WorkingDirectory $projectRoot -WindowStyle Hidden

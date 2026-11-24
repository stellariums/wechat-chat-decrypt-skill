# Modified by stellariums for this adaptation.
$ErrorActionPreference = 'Stop'
$source = Split-Path -Parent $PSScriptRoot
$output = if ($args.Count -gt 0) {
    [IO.Path]::GetFullPath($args[0])
} else {
    Join-Path (Split-Path -Parent $source) 'wechat-chat-decrypt-skill.zip'
}

$sourcePrefix = $source + [IO.Path]::DirectorySeparatorChar
if ($output -eq $source -or $output.StartsWith($sourcePrefix, [StringComparison]::OrdinalIgnoreCase)) {
    throw 'Output zip must be outside the skill directory.'
}
$prefix = & git -C $source rev-parse --show-prefix
if ($LASTEXITCODE -ne 0 -or $prefix) {
    throw 'Run packaging from a standalone Git checkout of the Skill.'
}

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $output) | Out-Null
& git -C $source archive --format=zip "--output=$output" --prefix=wechat-chat-decrypt/ HEAD
if ($LASTEXITCODE -ne 0) {
    throw 'Git could not archive the committed Skill.'
}
Write-Output "Created $output"

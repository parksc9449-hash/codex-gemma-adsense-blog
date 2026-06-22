param(
  [string]$GoogleToken = "",
  [string]$NaverToken = "",
  [string]$Repository = "parksc9449-hash/codex-gemma-adsense-blog",
  [switch]$SkipGitHubVariables
)

$ErrorActionPreference = "Stop"
$Root = Resolve-Path (Join-Path $PSScriptRoot "..")
$EnvPath = Join-Path $Root ".env"
$ExamplePath = Join-Path $Root ".env.example"

if (-not $GoogleToken -and -not $NaverToken) {
  Write-Host "Provide at least one token."
  Write-Host ".\scripts\set-search-verification.ps1 -GoogleToken `"google-token`""
  Write-Host ".\scripts\set-search-verification.ps1 -NaverToken `"naver-token`""
  exit 1
}

if (-not (Test-Path $EnvPath)) {
  Copy-Item $ExamplePath $EnvPath
}

function Set-EnvValue {
  param([string]$Name, [string]$Value)
  if (-not $Value) { return }
  $text = Get-Content $EnvPath -Raw
  $escaped = [regex]::Escape($Name)
  $line = "$Name=`"$Value`""
  if ($text -match "(?m)^$escaped=") {
    $text = $text -replace "(?m)^$escaped=.*$", $line
  } else {
    $text = $text.TrimEnd() + "`r`n" + $line + "`r`n"
  }
  Set-Content -Path $EnvPath -Value $text -Encoding UTF8
}

function Get-GitHubToken {
  $filled = "protocol=https`nhost=github.com`nusername=parksc9449-hash`n`n" | git credential fill
  $token = ($filled | Select-String '^password=' | Select-Object -First 1).Line -replace '^password=', ''
  if (-not $token) { throw "No parksc9449-hash GitHub credential found." }
  return $token
}

function Set-GitHubVariable {
  param([string]$Name, [string]$Value)
  if (-not $Value -or $SkipGitHubVariables) { return }
  $token = Get-GitHubToken
  $headers = @{
    Authorization = "Bearer $token"
    Accept = "application/vnd.github+json"
    "X-GitHub-Api-Version" = "2022-11-28"
    "User-Agent" = "Codex-Search-Verification"
  }
  $base = "https://api.github.com/repos/$Repository/actions/variables"
  $body = @{ name = $Name; value = $Value } | ConvertTo-Json
  try {
    Invoke-RestMethod -Method Get -Uri "$base/$Name" -Headers $headers -TimeoutSec 30 | Out-Null
    Invoke-RestMethod -Method Patch -Uri "$base/$Name" -Headers $headers -ContentType "application/json" -Body (@{ name = $Name; value = $Value } | ConvertTo-Json) -TimeoutSec 30 | Out-Null
    Write-Host "Updated GitHub variable $Name"
  } catch {
    $status = $_.Exception.Response.StatusCode.value__
    if ($status -eq 404) {
      Invoke-RestMethod -Method Post -Uri $base -Headers $headers -ContentType "application/json" -Body $body -TimeoutSec 30 | Out-Null
      Write-Host "Created GitHub variable $Name"
    } else {
      throw
    }
  }
}

Set-EnvValue -Name "GOOGLE_SITE_VERIFICATION" -Value $GoogleToken
Set-EnvValue -Name "NAVER_SITE_VERIFICATION" -Value $NaverToken
Set-GitHubVariable -Name "GOOGLE_SITE_VERIFICATION" -Value $GoogleToken
Set-GitHubVariable -Name "NAVER_SITE_VERIFICATION" -Value $NaverToken

Write-Host "Verification token configuration complete."
Write-Host "Next: npm run build"
Write-Host "Then: git add .github/workflows/pages.yml && git commit/push if needed, or rerun the Pages workflow."

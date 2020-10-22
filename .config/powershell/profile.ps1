# Zach's Powershell Profile

# Env Vars
Set-Variable TERM=xterm-256color
$env:COMPLETION_SHELL_PREFERENCE = 'zsh'

# Importing Modules I'll want every time
if (-Not (Import-Module PSReadLine)) {
  Install-Module PSReadLine -AllowPrerelease
}

if (-Not (Import-Module Microsoft.PowerShell.UnixCompleters)) {
  Install-Module -Name Microsoft.PowerShell.UnixCompleters
}

if (-Not (Import-Module PSScriptAnalyzer)) {
  Install-Module -Name PSScriptAnalyzer
}

# Making it work like any other prompt (that I've configured (;)
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord
Set-PSReadLineOption -EditMode Vi

# Colors
#Set-PSReadLineOption -Colors @{ Prediction = 'Green' }

# Functions
function ~ {
  Set-Location ~ # i.e. cd ~
}

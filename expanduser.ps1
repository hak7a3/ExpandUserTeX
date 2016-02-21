Param (
    [string]$Engine="latex",
    [Parameter(Mandatory=$True,Position=1)]
    [string]$Target
)

Get-Content header.tex, $Target | & $Engine "-jobname=getuser"
"%expanded user macros" > "expanded_${Target}"
Get-Content $Target | ForEach-Object { 
    $_ | & $Engine  "expander" "-interaction=errorstopmode"
    Get-Content ".\tmplineexpander.tex" >> "expanded_${Target}"
}


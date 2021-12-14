[CmdletBinding()]
Param(
      [Parameter(Mandatory=$false)][switch]$System=$false,  #none of the parameters are mandatory, will call specific funtions if these parameters are selected
      [Parameter(Mandatory=$false)][switch]$Disks=$false,
      [Parameter(Mandatory=$false)][switch]$Network=$false           
    )


#If statements to determine which parameter has been used, and which functions should be run

$all = 0
If ($System) {
    Get-CpuInfo
    Get-OpSystem
    Get-PhysMem
    Get-VidCard
    $all += 1		#added 'all' variable to check if a parameter was called
}

If ($Disks) {
    Get-PhysDiskDrive
    $all += 1
}

If ($Network) {
    Get-NetAdapterConf
    $all += 1
}

 if ($all -lt 1) {	#if 'all' is less than 1, meaning no parameters were used, all of the functions are called
    Get-SysHardware
    Get-OpSystem
    Get-Processor
    Get-PhysMem
    Get-PhysDiskDrive
    Get-NetAdapterConf
    Get-VidCard
    Get-CpuInfo
    Get-MyDisks
}
    

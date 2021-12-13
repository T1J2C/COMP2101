$totalRAM = 0
$horizontal = 0
$vertical = 0

"
System Hardware:
==============="
Get-WmiObject -Class win32_computersystem | 
Format-list Description


"Operating System:
=================="
Get-WmiObject -Class win32_operatingsystem |
    foreach {
        new-object -TypeName psobject -Property @{
            Name = $_.name
            Version = $_.Version
        }
    } | 
    format-list Name, Version


            
"Processor:
==========="
Get-WmiObject -Class win32_processor |
    foreach {
        new-object -TypeName psobject -Property @{
            Description = $_.Description
            "L1 Cache Size(KB)" = $_.L1CacheSize/1KB
            "L2 Cache Size(KB)" = $_.L2CacheSize/1KB
            "L3 Cache Size(KB)" = $_.L3CacheSize/1KB
            Cores = $_.NumberOfCores
            Speed = $_.MaxClockSpeed
        }
    } | 
    Format-list Description, "L1 Cache Size(KB)", "L2 Cache Size(KB)", "L3 Cache Size(KB)", Cores, Speed

            
"Physical Memory:
================="
#Physical Memory, retrieves Description, Manufacturer, Capacity and Bank of RAM
Get-WmiObject -Class win32_physicalmemory |
    foreach {
        new-object -TypeName psobject -Property @{
            Description = $_.Description
            Vendor = $_.Manufacturer
            "Size(MB)" = $_.capacity/1mb
            Bank = $_.BankLabel
        }
        $totalRAM += $_.capacity/1mb
    } |
    Format-table -AutoSize Descripton, Vendor, "Size(MB)", Bank

"Total RAM: ${totalRAM}MB"
    

"Physical Disk Drives:
======================"
$diskdrives = Get-CimInstance CIM_diskdrive

    foreach ($disk in $diskdrives) {
        $partitions = $disk | Get-CimAssociatedInstance -ResultClassName CIM_diskpartition
        foreach ($partition in $partitions) {
            $logicaldisks = $partition | Get-CimAssociatedInstance -ResultClassName CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                New-Object -TypeName PSObject -Property @{
                    Vendor = $disk.Manufacturer
                    Model = $disk.Model
                    "Size(GB)" = $logicaldisk.size / 1gb -as [int]
                    "Free Space(GB)" = $logicaldisk.FreeSpace / 1gb
                    "Free Space(%)" = ($logicaldisk.FreeSpace / $logicaldisk.size) * 100
                    } |Format-table Vendor, Model, "Size(GB)", "Free Space(GB)", "Free Space(%)"
                }  
                
            }
        }
    
    
"Network Adapter Config:
========================"
#Get-CIMInstance to retrieve network adapter info, only showing ip enabled adapters, selecting only the Description, Index, IP Address, Subnet mask, dns domain and the dns server(not found as a property?), finally formatting as a table and auotsizing.
get-ciminstance win32_networkadapterconfiguration | where-object ipenabled | Select-Object Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServer |format-table -autosize




"Video Card:
============"
Get-WmiObject -Class win32_videocontroller |
    foreach {
        new-object -TypeName psobject -Property @{
            Vendor = $_.Name
            Description = $_.Description
        }
        $horizontal += $_.CurrentHorizontalResolution
        $vertical += $_.CurrentVerticalResolution
    } |
    Format-list Vendor, Description
"Current Screen Resolution: $horizontal x $vertical"
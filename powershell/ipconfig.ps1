#Get-CIMInstance to retrieve network adapter info, only showing ip enabled adapters, selecting only the Description, Index, IP Address, Subnet mask, dns domain and the dns server(not found as a property?), finally formatting as a table and auotsizing.
get-ciminstance win32_networkadapterconfiguration | where-object ipenabled | Select-Object Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServer |format-table -autosize
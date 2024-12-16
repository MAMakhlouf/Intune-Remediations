#Enable SecureBoot

$ErrorActionPreference = "Ignore" 

Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted 

if (-not(Get-PackageProvider -name nuget)) { 

	Install-PackageProvider -Name NuGet -Confirm:$false 

	Start-Sleep -Seconds 60 

} 

if (-not(Get-InstalledModule -Name DellBIOSProvider)) { 

	Install-Module -Name DellBIOSProvider -Confirm:$false 

	Start-Sleep -Seconds 60 

} 

Import-Module DellBIOSProvider -force 

#Enable SecureBoot 

Start-Sleep -Seconds 60 

if (get-Item -Path DellSmbios:\SecureBoot\SecureBoot | select currentvalue) { 

	Set-Item -Path DellSmbios:\SecureBoot\SecureBoot "Enabled" -password "YourAdminBiosPassword" 

} 

exit

# ignore password parameter with you didn't set it before.
#https://www.dell.com/support/kbdoc/nl-nl/000178000/dell-command-configure
# Generate a recovery password
$RecoveryPasswordProtector = Add-BitLockerKeyProtector -MountPoint "C:" -RecoveryPasswordProtector

# Retrieve the generated recovery password
$RecoveryPassword = $RecoveryPasswordProtector.KeyProtector.RecoveryPassword
 Write-Output "BitLocker recovery password: $RecoveryPassword"

# Enable BitLocker with recovery password
Enable-BitLocker -MountPoint "C:" -RecoveryPasswordProtector -SkipHardwareTest -EncryptionMethod XtsAes256

Write-Output "BitLocker has been enabled on the system drive." 

# Get the BitLocker volume
$BitLockerVolume = Get-BitLockerVolume -MountPoint $env:SystemDrive

# Get the KeyProtectorId for the recovery password
$RecoveryProtector = $BitLockerVolume.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }

# Backup each KeyProtectorId to Azure AD
foreach ($Key in $RecoveryProtector.KeyProtectorID) {
    try {
        BackupToAAD-BitLockerKeyProtector -MountPoint $env:SystemDrive -KeyProtectorId $Key
        Write-Output "Successfully backed up KeyProtectorId $Key to Azure AD."
    } catch {
        Write-Output "Could not back up KeyProtectorId $Key to Azure AD. Error: $_"
    }
}
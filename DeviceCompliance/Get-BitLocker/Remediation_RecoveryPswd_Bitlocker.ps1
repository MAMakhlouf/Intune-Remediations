# Generate a recovery password
 $RecoveryPasswordProtector = Add-BitLockerKeyProtector -MountPoint "C:" -RecoveryPasswordProtector

# Retrieve the generated recovery password
$RecoveryPassword = $RecoveryPasswordProtector.KeyProtector.RecoveryPassword[0]
 Write-Output "BitLocker recovery password: $RecoveryPassword"

# Enable BitLocker with recovery password
Enable-BitLocker -MountPoint "C:" -RecoveryPasswordProtector -RecoveryPassword $RecoveryPassword -SkipHardwareTest -EncryptionMethod XtsAes256

Write-Output "BitLocker has been enabled on the system drive." 

#test
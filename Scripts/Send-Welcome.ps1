param ()

Import-Module ActiveDirectory

$SmtpServer = "smtp.yourcompany.domain"
$From       = "it-support@yourcompany.domain"
$Subject    = "Добро пожаловать в Your Company!"
$Template   = "C:\Templates\welcome-rbk-bilingual.html"
$LogPath    = "C:\Logs\welcome-mail.log"

$event = Get-WinEvent -LogName Security -FilterHashtable @{Id = 4720} -MaxEvents 1
if (-not $event) { exit 1 }

$xml = [xml]$event.ToXml()
$newUserSam = ($xml.Event.EventData.Data | Where-Object { $_.Name -eq "TargetUserName" }).'#text'

try {
    $user = Get-ADUser -Identity $newUserSam -Properties DisplayName, DistinguishedName
} catch {
    Add-Content -Path $LogPath -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ❌ Ошибка поиска: $newUserSam"
    exit 2
}

if ($user.DistinguishedName -notmatch '(?i)OU=Bank') {
    Add-Content -Path $LogPath -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ⏭ Пропущен (не OU=Bank): $($user.SamAccountName)"
    exit 0
}

$Email = "$($user.SamAccountName)@yourcompany.domain"
$FullName = if ($user.DisplayName) { $user.DisplayName } else { $user.SamAccountName }

try {
    $HtmlTemplate = Get-Content $Template -Raw
    $Body = $HtmlTemplate -replace "{{FullName}}", $FullName
} catch { exit 3 }

try {
    Send-MailMessage -From $From -To $Email -Subject $Subject -Body $Body -BodyAsHtml -SmtpServer $SmtpServer
    Add-Content -Path $LogPath -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ✅ Отправлено: $Email ($FullName)"
} catch {
    Add-Content -Path $LogPath -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ❌ Ошибка отправки: $Email ($FullName): $($_.Exception.Message)"
    exit 4
}


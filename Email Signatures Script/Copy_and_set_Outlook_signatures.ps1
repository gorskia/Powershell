#Modified by G3 on Sept 27, 2021 with ITS-586 / MKT-115

#Clean old signatures
$Path = $env:APPDATA + "\Microsoft\Signatures\*.*"
Remove-Item -Path $Path -Force

#Get current logged
$CurrentlyLoggedInUser = $env:UserName

$pathToSourceSignaturesPrefix = "\\TSDCORPSTOR01.tsd.com\TSD Documentation\Email Signatures\Auto-generated\";
$pathToTargetSignatures = $env:APPDATA + "\Microsoft\Signatures\"

[bool] $containsServicesSignature = 0
[bool] $containsSoftwareSignature = 0
[bool] $containsGroupSignature = 0
$signaturesCount = 0;

# Copy the generated signatures from the file share - TSD Services
$pathToSourceLongSignatureServices = $pathToSourceSignaturesPrefix + $CurrentlyLoggedInUser + "-Services-EN-long.htm";
$pathToSourceShortSignatureServices = $pathToSourceSignaturesPrefix + $CurrentlyLoggedInUser + "-Services-EN-short.htm";
if ([System.IO.File]::Exists($pathToSourceLongSignatureServices) -and [System.IO.File]::Exists($pathToSourceShortSignatureServices)) {
    copy $pathToSourceLongSignatureServices ($pathToTargetSignatures + $CurrentlyLoggedInUser + "-Services-EN-Long.htm")
    copy $pathToSourceShortSignatureServices ($pathToTargetSignatures + $CurrentlyLoggedInUser + "-Services-EN-Short.htm")
    $containsServicesSignature = 1;
    $signaturesCount = $signaturesCount + 1
}


# Copy the generated signatures from the file share - TSD Software
$pathToSourceLongSignatureSoftware = $pathToSourceSignaturesPrefix + $CurrentlyLoggedInUser + "-Software-EN-long.htm";
$pathToSourceShortSignatureSoftware = $pathToSourceSignaturesPrefix + $CurrentlyLoggedInUser + "-Software-EN-short.htm";
if ([System.IO.File]::Exists($pathToSourceLongSignatureSoftware) -and [System.IO.File]::Exists($pathToSourceShortSignatureSoftware)) {
    copy $pathToSourceLongSignatureSoftware ($pathToTargetSignatures + $CurrentlyLoggedInUser + "-Software-EN-Long.htm")
    copy $pathToSourceShortSignatureSoftware ($pathToTargetSignatures + $CurrentlyLoggedInUser + "-Software-EN-Short.htm")
    $containsSoftwareSignature = 1;
    $signaturesCount = $signaturesCount + 1
}


# Copy the generated signatures from the file share - TSD Group
$pathToSourceLongSignatureGroup = $pathToSourceSignaturesPrefix + $CurrentlyLoggedInUser + "-Group-EN-long.htm";
$pathToSourceShortSignatureGroup = $pathToSourceSignaturesPrefix + $CurrentlyLoggedInUser + "-Group-EN-short.htm";
if ([System.IO.File]::Exists($pathToSourceLongSignatureGroup) -and [System.IO.File]::Exists($pathToSourceShortSignatureGroup)) {
    copy $pathToSourceLongSignatureGroup ($pathToTargetSignatures + $CurrentlyLoggedInUser + "-Group-EN-Long.htm")
    copy $pathToSourceShortSignatureGroup ($pathToTargetSignatures + $CurrentlyLoggedInUser + "-Group-EN-Short.htm")
    $containsGroupSignature = 1;
    $signaturesCount = $signaturesCount + 1
}


# Set the New and Reply email signatures over again IF ONLY ONE SIGNATURE (ONE COMPANY)
if ($signaturesCount -eq 1) {
    $theCompany = "";

    if ($containsServicesSignature) {
        $theCompany = "-Services"
    }
    elseif ($containsSoftwareSignature) {
        $theCompany = "-Software"
    }
    elseif ($containsGroupSignature) {
        $theCompany = "-Group"
    }
    $MSWord = New-Object -com word.application 
    $EmailOptions = $MSWord.EmailOptions 
    $EmailSignature = $EmailOptions.EmailSignature 
    $EmailSignatureEntries = $EmailSignature.EmailSignatureEntries 
    $EmailSignature.NewMessageSignature = $CurrentlyLoggedInUser + $theCompany + "-EN-Long"
    $EmailSignature.ReplyMessageSignature = $CurrentlyLoggedInUser + $theCompany + "-EN-Short"
    $MSWord.Quit()
}
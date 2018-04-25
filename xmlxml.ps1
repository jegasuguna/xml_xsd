# xmlFileName: Filename of the XML file to validate
$xmlfilename="NewFile1.xml"

# Check if the provided file exists
if((Test-Path -Path $xmlFileName) -eq $false)
{
    Write-Host "XML validation not possible since no XML file found at '$xmlFileName'"
    exit 2
}

# Get the file
$XmlFile = Get-Item($xmlFileName)

# Keep count of how many errors there are in the XML file
$script:errorCount = 0

# Perform the XSD Validation
$readerSettings = New-Object -TypeName System.Xml.XmlReaderSettings
$readerSettings.ValidationType = [System.Xml.ValidationType]::Schema
$readerSettings.ValidationFlags = [System.Xml.Schema.XmlSchemaValidationFlags]::ProcessInlineSchema -bor [System.Xml.Schema.XmlSchemaValidationFlags]::ProcessSchemaLocation
$readerSettings.add_ValidationEventHandler(
{
    # Triggered each time an error is found in the XML file
    Write-Host $("`nError found in XML: " + $_.Message + "`n") -ForegroundColor Red
    $script:errorCount++
});


$reader = [System.Xml.XmlReader]::Create($XmlFile.FullName, $readerSettings)
while ($reader.Read()) { }
$reader.Close()

# Verify the results of the XSD validation
if($script:errorCount -gt 0)
{
    # XML is NOT valid
    exit 1
}
else
{
    # XML is valid
    Write-Host "The Validation Completed with no errors or Warnings"
    exit 0
}

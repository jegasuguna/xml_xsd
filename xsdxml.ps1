function Validate-XML-Wellformed($xmlfile="D:\suguna\myxmlSchema.xsd")
{
    return Test-Xml $xmlfile –Verbose
}

$result = Validate-XML-Wellformed "users.xml"

Write-Host "Is valid: " $result

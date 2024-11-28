function Convert-PFX {
    param(
        [Parameter(Mandatory=$true)]
        $filepath,
        [Parameter(Mandatory=$true)]
        $password
    )


    $filename = Split-Path $filepath -leaf
    $FilePathWithoutName = Split-Path -Path $filepath
    $filename = [io.path]::GetFileNameWithoutExtension($filename)

    if ([string]::IsNullOrEmpty($FilePathWithoutName)) {
        New-Item -ItemType Directory -Name $filename
        $outputpath =   $filename + "\"
    }
    else {
        New-Item -ItemType Directory -Path $FilePathWithoutName -Name $filename
        $outputpath =  $FilePathWithoutName + "\" + $filename + "\"
    }



    openssl pkcs12 -in $filepath -nocerts -nodes -passin pass:$password  | openssl rsa -out $outputpath$filename'.key'
    openssl pkcs12 -in $filepath -clcerts -nokeys -passin pass:$password | openssl x509 -out $outputpath$filename'.crt'

}

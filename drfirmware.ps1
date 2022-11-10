##############
# Dr. Firmware v1.0 by Gary Howard
# Prereq: PWSH 5.x or later, HPEilocmdlets module, iloip.csv, ilocred.csv file
# Purpose: To upgrade and change the iLO fimware and policies 
##############

#Import and load the iLO cmdlets module
Import-Module -name HPEiLOCmdlets

#Greet User and ask user iLO Cred information
Write-Host "
_____         ______ _                                      
|  __ \       |  ____(_)                                     
| |  | |_ __  | |__   _ _ __ _ __ _____      ____ _ _ __ ___ 
| |  | | '__| |  __| | | '__| '_ ` _ \ \ /\ / / _` | '__/ _ \
| |__| | |_   | |    | | |  | | | | | \ V  V / (_| | | |  __/
|_____/|_(_)  |_|    |_|_|  |_| |_| |_|\_/\_/ \__,_|_|  \___|
By Gary Howard                                                             
                                                             
"
$choice = Read-Host "Are the Creds for the iLO same for all servers? yes|no"
switch ($choice) {
    yes { 
        $Creds = Get-Credential -Message "Enter iLO Username and Password"

        #Ask user for iLO IP CSV file and stores it in an Array
        $filepath = Read-Host "Please provide the full path of the CSV file ex C:\Users"
        $Hostname=@()
        Import-Csv $filepath | ForEach-Object{
            $Hostname += $_.hostname
        }
        
        #Connection String for connecting to iLO 
        $connection = Connect-HPEilo -IP $Hostname -Credential $Creds -DisableCertificateAuthentication

        #Ask User for Path to iLO firmware .bin file
        #$Binpath = Read-Host "Please enter full path to .bin file"


        #Uploads firmware to iLO from path
        Update-HPEiLOFirmware -Connection $connection -Location "C:\script\ilo5_271.bin"

        #Start Timer for Update to finish and then Check versions
        Write-Host "Starting time for 5 mins"
        Start-Sleep -Seconds 300
        Get-HPEiLOFirmwareVersion -Connection $connection
        
        Write-Host "Update Completed! End of Program" -ForegroundColor Green

    
     }
     no {

        ##Look at combining variables 
        #Ask user for iLO IP CSV file and stores it in an Array
        $filepath = Read-Host "Please provide the full path of the iLO IP CSV file ex C:\Users"
        $Hostname=@()

        Import-Csv $filepath | ForEach-Object{
            $Hostname += $_.hostname
        }

        #Ask user for iLO cred CSV file and stores it in an Array
        $filepath = Read-Host "Please provide the full path of the iLO cred CSV file ex C:\Users"
        $Username=@()
        $Password=@()

        Import-Csv $filepath | ForEach-Object{
            $Username += $_.username
            $Password += $_.password

        }


        #Connection String for connecting to iLO 
        $connection = Connect-HPEilo -IP $Hostname -Username $Username -Password $Password -DisableCertificateAuthentication
        Test-HPEiLOConnection -Connection $connection

        #Ask User for Path to iLO firmware .bin file
        $Binpath = Read-Host "Please enter full path to .bin file"

        #Uploads firmware to iLO from path
        Update-HPEiLOFirmware -Connection $connection -Location $Binpath

        #Start Timer for Update to finish and then Check versions
        Write-Host "Starting timer for 5 mins"
        Start-Sleep -Seconds 300
        Write-Host "Now Checking iLO Firmware Version"
        Get-HPEiLOFirmwareVersion -Connection $connection
        
        Write-Host "Update Completed! End of Program" -ForegroundColor Green


     }
    Default {Write-Host "Please double check your inputs and run again " -ForegroundColor Red}
}


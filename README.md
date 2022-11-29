# Dr Firmware

To upgrade and change the iLO Firmware and Policies 

## Description

Dr. Firmware is an automation script created in powershell to communicate with the iLO (intergrated Lights-Out) on Proliant Servers.
The Script will depending on the user input will update the Firmware on the iLOs or change the firmware policy on more secured iLOs.


## Getting Started

### Dependencies

* Powershell 5.x or Greater
* OS: Windows 10 or Later, Mac OS X 11.x or Later, Linux 64 bit
* HPE iLO Cmdlet Library 3.x or Later

### Installing

* Extact the Zip file to a Directory 
* Check and make sure the Module folder is present

### Executing program

* open a shell with Administrative or root privilages 
* run Powershell to get into a PWSH shell
* cd to the Directory where you have extracted the program
* Run ./drfirmware.ps1
* Follow on screen instructions and all entry is case sensitive 

## Help

if the script fail to launch please make sure you have admin privilages 

## Authors

Gary Howard  
howardtechone@gmail.com

## Version History

* 1.1
    * Comming soon Dec 2022 Bug fixes and Optimizations
* 1.0
    * Initial Release

## License

This project is licensed under the GNU General Public License - see the LICENSE.md file for details

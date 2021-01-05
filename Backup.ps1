<# 
.Synopsis 
   Creates folder structure at the target backup location and copies Desktop, Documents and Favorities from User's profile 
 
.DESCRIPTION 
   Takes a target variable targetFolder, to be the parent backup location. Feel free to modify as needed. 
   Creates folder structure under targetFolder in YYYY_MMM_DD_HH.MM format and creates Desktop, Documents and Favorities folders 
   All files are copied under their respective folders in exact folder structure. 
#> 
# Target path. $TargetFolder can be modified to be the backup location.  
$targetFolder = "E:\TargetFolder" 
$date = Get-Date 
$targetSubFolder = $date.Year.ToString() +'_'+[cultureinfo]::InvariantCulture.DateTimeFormat.GetAbbreviatedMonthName($date.Month) + '_'+ $date.Day.ToString() + '_'+$date.Hour.ToString()+ '.'+$date.Minute.ToString() 
$finalBackupPath = $targetFolder + '\'+$targetSubFolder 
 
# Create the path for today's date/time. warn if already exists 
if(Test-Path $finalBackupPath) 
{ 
    Write-Warning "Target path for the date and time already exists, do you want to continue?" 
    $sayYes = Read-Host "..or exit here? Press 'Y' or 'y' for 'Yes', else press any key" 
    if($sayYes -eq 'y' -or $sayYes -eq 'Y') {} 
    else { Write-Warning "Existing..." -fore DarkYellow; exit} 
} 
else 
{ 
    New-Item -Type Directory -Path $finalBackupPath -Force |Out-Null 
} 
 
# Create Target Documents, Desktop and Favorites folder 
New-Item -Type Directory -Path ($finalBackupPath + '\Documents') -Force |Out-Null 
New-Item -Type Directory -Path ($finalBackupPath + '\Desktop') -Force |Out-Null 
New-Item -Type Directory -Path ($finalBackupPath + '\Favorites') -Force |Out-Null 
 
Get-ChildItem -Path $home\Favorites | Copy-Item -Destination ($finalBackupPath + '\Favorites') -Recurse -Container 
Write-Verbose "Favorites copied...." -for Green 
 
 
Get-ChildItem -Path $home\Desktop | Copy-Item -Destination ($finalBackupPath + '\Desktop') -Recurse -Container 
Write-Verbose "Desktop copied...." -for Green 
 
 
Get-ChildItem -Path $home\Documents | Copy-Item -Destination ($finalBackupPath + '\Documents') -Recurse -Container 
Write-Verbose "Documents copied...." -for Green 
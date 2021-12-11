# Add cmdlet
Add-Type -AssemblyName System.Web
$version = "0.1.0"
$githubver = "https://raw.githubusercontent.com/rickeymandraque/Twitch-Random_Medias/main/Current_Version.txt"
$ScriptFromGitHub = "https://raw.githubusercontent.com/rickeymandraque/Twitch-Random_Medias/main/Twitch-Random_Medias.ps1"
$Working_Dir = "$($PWD.Path)"


# Prametres utilisateur
$Sounds_Dir = "$Working_Dir\Sons"
$Vids_Dir =  "$Working_Dir\reportages"
$Temp_SoundName = "$Sounds_Dir\Son.mp3"
$Temp_VidsName = "$Sounds_Dir\Docu.mp4"
$DataStore = "$Working_Dir\Files.json"
$avalable_Ext = "-include ('*.mp4', '*.mkv')"
$During_Time_Units = "addseconds"
$Wait_Time = "30"
$During_Time = "180"


# Parametres du script
$TimeStart = Get-Date
$TimeEnd = $timeStart.${During_Time_Units}($During_Time)




# Début du script


function CheckUpdates () {

# Invoke-WebRequest -Uri $ScriptFromGitHub -OutFile .\Twitch-Random_Medias.ps1


	$updateavailable = $false
	$nextversion = $null
	try
	{
		$nextversion = (New-Object System.Net.WebClient).DownloadString($githubver).Trim([Environment]::NewLine)
	}
	catch [System.Exception] 
	{
		echo $_ 
	}
	
	echo "CURRENT VERSION: $version"
	echo "NEXT VERSION: $nextversion"
	if ([System.Version]${nextversion} -ne $null -and [System.Version]${version} -ne [System.Version]${nextversion})
	{
        echo "Les versions sont différentes"
		#An update is most likely available, but make sure
		$updateavailable = $false
		
		if ([System.Version]${nextversion} -gt [System.Version]${version})
			{
				echo "la version en ligne est plus grande"
                $updateavailable = $true

			}
        elseif ([System.Version]${nextversion} -lt [System.Version]${version})
            {
                echo "la version en ligne est plus petite"
                $updateavailable =  $false

            }
		
	}
    else
        {
        echo "les deux versions sont identiques"
        $updateavailable = $false
        }
		
		if ($updateavailable -eq $true)
		{
		if (Test-Connection 8.8.8.8 -Count 1 -Quiet)
	{
		echo "Mise à jour dispo"
		$response = Read-Host "`nSouhaitez-vous mettre à jour le script ? (O/o/Y/y/N/n)"
		while (($response -match "[YyOoNn]") -eq $false)
		{
			$response = Read-Host "Réponse invalide, Veuillez taper O ou o pour oui, Y ou y pour Yes, N ou n pour non."
		}

		if ($response -match "[YyOo]")
		{	
			echo "Téléchargement de la nouvelle version, vous devrez relancer le script"
            Invoke-WebRequest -Uri $ScriptFromGitHub -OutFile .\Twitch-Random_Medias.ps1
			exit
		}
		else 
		{
			echo "MAJ abandonée"
		}
		
	}
	else
	{
		echo "Impossible de vérifier les mises à jour. Pas de connxion internet disponible."
	}	
		}

}


function Random-Vidz {
Write-Host "Heure de début: $TimeStart"
write-host "Heure de fin  :   $TimeEnd"

Do { 
 $TimeNow = Get-Date
 if ($TimeNow -ge $TimeEnd) {
 mv $Temp_VidsName (Get-Content .\current.txt)
 rm .\current.txt
  Write-host "Le script est terminé"
 } else {
 Get-ChildItem $Vids_Dir\ $avalable_Ext -Name | Get-Random > current.txt
 mv (Get-Content .\current.txt) $Temp_VidsName
  Write-Host "fichier renommé, en attente du compte à rebours"
 }
 Start-Sleep -Seconds $Wait_Time
 mv $Temp_VidsName (Get-Content .\current.txt)
}
Until ($TimeNow -ge $TimeEnd)

}

CheckUpdates
# Random-Vidz

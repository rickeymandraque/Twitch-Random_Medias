# Add cmdlet
Add-Type -AssemblyName System.Web
$version = "0.1.1"
$githubver = "https://raw.githubusercontent.com/rickeymandraque/Twitch-Random_Medias/main/Current_Version.txt"
$ScriptFromGitHub = "https://raw.githubusercontent.com/rickeymandraque/Twitch-Random_Medias/main/Twitch-Random_Medias.ps1"
$Working_Dir = "$($PWD.Path)"


# Prametres utilisateur
$Sounds_Dir = "$Working_Dir\Sons"
$Vids_Dir = "$Working_Dir\reportages"
$Temp_SoundName = "$Sounds_Dir\Son.mp3"
$Temp_VidsName = "$Vids_Dir\Docu.mp4"
$DataStore = "$Working_Dir\Files.json"
$During_Time_Units = "addminutes"
$Wait_Time = "600"
$During_Time = "180"


# Parametres du script
$TimeStart = Get-Date
$TimeEnd = $timeStart.${During_Time_Units}($During_Time)
$Current_Txt = "$Working_Dir\current.txt"
Get-ChildItem $Vids_Dir -Include ('*.mp4') -Name | Get-Random > $Current_Txt


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
		Write-Host $_
	}

	Write-Host "VERSION LOCALE: $version"
	Write-Host "VERSION DISTANTE: $nextversion"
	if ([System.Version]${nextversion} -ne $null -and [System.Version]${version} -ne [System.Version]${nextversion})
	{
		Write-Host "Les versions sont différentes"
		#An update is most likely available, but make sure
		$updateavailable = $false

		if ([System.Version]${nextversion} -gt [System.Version]${version})
		{
			Write-Host "la version en ligne est plus grande"
			$updateavailable = $true

		}
		elseif ([System.Version]${nextversion} -lt [System.Version]${version})
		{
			Write-Host "la version en ligne est plus petite"
			$updateavailable = $false

		}

	}
	else
	{
		Write-Host "Narf ! Pas de MAJ Dispo !"
		$updateavailable = $false
	}

	if ($updateavailable -eq $true)
	{
		if (Test-Connection 8.8.8.8 -Count 1 -Quiet)
		{
			Write-Host "Mise à jour dispo"
			$response = Read-Host "`nSouhaitez-vous mettre à jour le script ? (O/o/Y/y/N/n)"
			while (($response -match "[YyOoNn]") -eq $false)
			{
				$response = Read-Host "Réponse invalide, Veuillez taper O ou o pour oui, Y ou y pour Yes, N ou n pour non."
			}

			if ($response -match "[YyOo]")
			{
				Write-Host "Téléchargement de la nouvelle version, vous devrez relancer le script"
				Invoke-WebRequest -Uri $ScriptFromGitHub -OutFile .\Twitch-Random_Medias.ps1
				exit
			}
			else
			{
				Write-Host "MAJ abandonée"
			}

		}
		else
		{
			Write-Host "Impossible de vérifier les mises à jour. Pas de connexion internet disponible."
		}
	}

}

function Random-Vidz {
	Write-Host "Heure de début: $TimeStart"
	Write-Host "Heure de fin  :   $TimeEnd"

	do {
		$TimeNow = Get-Date
		$Real_Name = (Get-Content $Current_Txt)
		if ($TimeNow -ge $TimeEnd) {
			Rename-Item -LiteralPath "${Vids_Dir}\${Real_Name}" -NewName "${Temp_VidsName}"
			Start-Sleep -Seconds $Wait_Time
			Rename-Item -LiteralPath "${Temp_VidsName}" -NewName "${Vids_Dir}\${Real_Name}"
			Write-Host "fin du script"
			Remove-Item $Current_Txt
		}

		else
		{
			Rename-Item -LiteralPath "${Vids_Dir}\${Real_Name}" -NewName "${Temp_VidsName}"
			Start-Sleep -Seconds $Wait_Time
			Rename-Item -LiteralPath "${Temp_VidsName}" -NewName "${Vids_Dir}\${Real_Name}"
			Get-ChildItem $Vids_Dir -Include ('*.mp4') -Name | Get-Random > $Current_Txt
		}
	}


	until ($TimeNow -ge $TimeEnd)


}


CheckUpdates
Start-Sleep 10
Clear-Host
Random-Vidz



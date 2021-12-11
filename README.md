# Twitch-Random_Medias
PowerShell Script to stream sounds or videos randomly for reward points with Shakabot or other services.  
Script PowerShell pour diffuser des vidéos ou des sons de façon aléatoire contre des points de chaînes avec Shakabot ou d'autres services.  

Ce script à été devellopé pour le streamer PLS Lemon  
https://www.twitch.tv/plslemon

# Fonctionnalité

- Auto-Update
- Choisis une vidéo au hasard
- Extension mp4 et mkv fonctionelle
- Possibilité d'ajouter différentes extensions de fichier.

### Fonctionnalité à venir

- prise en charge des sons
- intégration de YoutubeDL
- intégration d'un mode shuffle
- intégration d'un json contenant les hash pour renommer les medias correctement
- prise en charge d'un fichier .ini pour conserver les parametres



# Utilisation

- Placez le script dans un dossier (ex: D:\Twitch\Shakabot)
- Placez vos médias dans des dossiers séparé (ex: D:\Twitch\Shakabot\Vidéos ; D:\Twitch\Shakabot\Sons)
- Faites un [MAJ]+[Clic Droit] > "Ouvrir la fenêtre PowerShell ici"
- Tapez "Twi" et [TAB] pour voir apparaitre " Twitch-Random_Medias.ps1 et tapez [Entrée]


# Parametrages

Il suffit de changer la valeurs des variables.

### Nom des dossiers 

#### par défaut:  

$Sounds_Dir = "$Working_Dir\Sons" pour les Sons  
$Vids_Dir =  "$Working_Dir\reportages" pour les vidéos  

Pour changer les noms par defaut, il suffit de remplacer le nom des dossiers ou des fichier dans le script !  

    $Sounds_Dir = "$Working_Dir\VOTRE_NOM_DE_DOSSIER_SONS"  
    $Vids_Dir =  "$Working_Dir\VOTRE_NOM_DE_DOSSIER_VIDEOS"  

### Durées par défaut

Le script va renommer les medias toutes les 10 minutes et ce pendant 3h  

Nous pouvons choisir l'unité de durée du script, qui est en minutes par défaut, avec la variable $During_Time_Units.  
Les options possible, uniquement en anglais, sont "seconds" ; "minutes" et "days" précédé de "add".  

La variable $Wait_Time, exprimé en secondes, est le temps entre 2 renomage de fichier.  
La variable $During_Time est le temps d'execution en minutes par defaut.  

      $Wait_Time = "NOMBRE_SECONDES"  
      $During_Time = "NOMBRES_MINUTE" 

#### Nota-bene:

Le temps d'atente doit obligatoirement etre exprimé en secondes.

#### Exemples

    $During_Time_Units = "adddays" 
    $During_Time_Units = "addhours"
    $During_Time_Units = "addminutes"
    $During_Time_Units = "addseconds"


### Extensions de fichiers

Les mp4 et les mkv sont prise en charge grace à la variable $avalable_Ext.  

     $avalable_Ext = "-include ('*.mp4', '*.mkv')"


Pour d'autres extension, il suffit de l'ajouter entre les parenthéses comme ceci :

      $avalable_Ext = "-include ('*.mp4', '*.mkv', '*.avi')"
      
Script en évolution !




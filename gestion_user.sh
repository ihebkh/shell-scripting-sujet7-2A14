#!/bin/bash

#afficher la fonction show usage
function show_usage()
{
	echo "$0 :[-h]--help] [-T][-t][-n][-N][-d][-m][-s]chemin..";

}

# Verouillage d'un compte utilisateur
function verrouiller()
{
    echo "Donner le nom de l'utilisateur à verrouiller son compte:"
    read user
    echo $user >> liste_user_v.txt
    sudo passwd -l "$user"
}

# Dévrouillage d'un compte utilisateur
function deverrouiller()
{
    echo "Donner le nom de l'utilisateur à deverrouiller son compte:"
    read user
    grep -v "$user" liste_user_v.txt > temp.txt
    
    mv temp.txt liste_user_v.txt

    sudo passwd -u "$user"
}

#Modifier le répertoire
function modifier()
{
     echo "Donner le nom de l'utilisateur à modifier le répertoire :"
     read user
     echo "Donner la nouvelle répertoire de l'utilisateur:"
     read dir
     sudo usermod -m -d "$dir" $user
}


#le menu textuel
function menu_textuel()
{
    while :
do
	clear
	echo " "
	echo "-------------------------------------"
	echo "            Menu Textuel"
	echo "-------------------------------------"
	echo "[1] Afficher le help.txt"
	echo "[2] Afficher la fonction show_usage"
	echo "[3] Afficher un menu textuel et gérer les fonctionnalité de façon graphique"
	echo "[4] Afficher le nom des auteurs et version du code."
	echo "[5] Déverouiller le compte d’un utilisateur."
	echo "[6] Verouiller le compte d’un utilisateur."
	echo "[7] Modifier le repertoire personnel de l’utilisateur."
	echo "[8] Exit"
	echo "====================================="
	echo "Entrez votre choix : [1-8]: "
	read m_menu
	
	case "$m_menu" in

		1) cat help.txt; read;;	    		
		2) echo "$0 :[-h]--help] [-T][-t][-n][-N][-d][-m][-s]chemin.."; read ;;
		3) menu_graphique;read;;
        	4) echo "Auteurs : Iheb khmiri && Med aziz temimi ||  Version : v2.1"; read; ;;
		5) deverrouiller; read;;
		6) verrouiller; read;;
		7) modifier; read;;
		
		8) exit 0;;
		*) echo "Choix invalide";
		   echo "Tappez ENTER pour continuer..." ; read ;;
	esac
done
}

#fonction help graphique
function help_graphique()
{
	yad  --form \
	--title="Help" --width=500 --height=500 --text="		
	Liste des options :

	-h: Afficher le help détaillé à partir d’un fichier texte. 

	-s: Afficher la fonction show_usage.

	-g: Afficher un menu textuel et gérer les fonctionnalité de façon  
		graphique(Utilisation de YAD).
 
	-v: Afficher le nom des auteurs et version du code.
 
	-m: Afficher un menu textuel.

	-d: Déverouiller le compte d’un utilisateur.

	-V: Verouiller le compte d’un utilisateur.

	-M: Modifier le repertoire personnel de l’utilisateur."
}

#fonction show_usage_graphique
function show_usage_graphique()
{
	yad  --form \
	--title="show_usage" --width=500 --height=500 --text="		
	show_usage:[-h]--help] [-T][-t][-n][-N][-d][-m][-s]chemin.."

}

#fonction Acteurs_graphique
function Acteur_graphique()
{
	yad  --form \
	--title="Nom des acteurs" --width=500 --height=500 --text="		
	Auteurs : Iheb khmiri et Med aziz temimi.
	
	Version du code : v2.1"

}

#fonction verrouillage_graphique
function verrouillage_graphique()
{
	user=$(yad --form \
	--title="Verouillage d'un compte utilisateur" --width=500 --height=500 --entry --entry-label="Donner le nom de l'utilisateur à verrouiller son compte:" --entry-text="Écrivez ici")

	echo $user >> liste_user_v.txt
    	sudo passwd -l "$user"


}

#fonction deverrouillage_graphique
function deverrouillage_graphique()
{
	user=$(yad  --form \
	--title="Déverouillage d'un compte utilisateur" --width=500 --height=500 --entry --entry-label="Donner le nom de l'utilisateur à deverrouiller son compte:" --entry-text="Écrivez ici")

	grep -v "$user" liste_user_v.txt > temp.txt
    
    	mv temp.txt liste_user_v.txt

    	sudo passwd -u "$user"
	

}

#fonction modification_graphique
function modification_graphique()
{

	user=$(yad  --form \
	--title="Modifier le repertoire personnel" --width=500 --height=500 --entry --entry-label="Donner le nom de l'utilisateur à modifier le répertoire :" --entry-text="Écrivez ici")
	dir=$( yad  --form \
	--title="Modifier le repertoire personnel" --width=500 --height=500 --entry --entry-label="Donner la nouvelle répertoire de l'utilisateur:" --entry-text="Écrivez ici")
	sudo usermod -m -d "$dir" $user

}

#le menu graphique
function menu_graphique()
{
	choice=$(yad  --form \
	--title="Gestion des utilisateurs" --width=600 --height=600 --text="
	[1] Afficher le help.txt

	[2] Afficher la fonction show_usage

	[3] Afficher le nom des auteurs et version du code.

	[4] Déverouiller le compte d’un utilisateur.

	[5] Verouiller le compte d’un utilisateur.

	[6] Modifier le repertoire personnel de l’utilisateur." --entry --entry-label="Veulliez choisir une option entre 1-6:" --entry-text="Écrivez ici")

	
	
	
	case $choice in

		1) help_graphique;;
		2) show_usage_graphique;;
		3) Acteur_graphique;;
        	4) deverrouillage_graphique;;			
		5) verrouillage_graphique;;
		6) modification_graphique;;
		*) echo "Choix invalide";
		   
	esac



}



function main()
{
   
	 while getopts ":hsgvmdVM" opt; do
	 
	    case "$opt" in

	    h)
	    cat help.txt
	    exit 0;
	    ;;
			
	    v)
	    echo "Auteurs : Iheb khmiri && Med aziz temimi ||  Version : v2.1"
	    ;;

	    m)
	    menu_textuel
	    ;;

	    g)
	    menu_graphique
	    ;;
	    
	    s)
	    show_usage
	    exit 0
	    ;;


            d) deverrouiller
		exit 0
	        ;;
		
	    V) verrouiller
		exit 0
	    	;;

	    M) modifier
		exit 0
	    	;;
	  
	    esac





	 done
	
	if [ $OPTIND -eq 1 ]; then show_usage exit 1 ; fi
	
}



main $*



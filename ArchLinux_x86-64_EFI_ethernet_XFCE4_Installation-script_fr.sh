loadkeys fr #mettre le clavier en azerty
timedatectl set-ntp true #mettre à jour l'horloge système
cfdisk #lancer l'outil de partitionnement de disque
#gpt
#/dev/sda1 400M EFI system
#/dev/sda2 600M Linux swap
#/dev/sda3 4G   Linux filesystem
#write
#quit
mkfs.fat -F32 /dev/sda1 #formater la partition qui va être utilisée en tant que partition EFI
mkfs.ext4 /dev/sda3 #formater la partition de linux fielesystem
mkswap /dev/sda2 #monter la partition swap
swapon /dev/sda2 #indiquer la nature de la partition
mount /dev/sda3 /mnt #monter la partition linux filesystem
mkdir /mnt/boot #créer un répertoire pour le montage de la partition EFI
mount /dev/sda1 /mnt/boot
pacstrap /mnt base linux linux-firmware #installer le système de base

genfstab -U /mnt >> /mnt/etc/fstab #générer le fichier fstab
arch-chroot /mnt #changer la racine sur le système installé
ln -sf /usr/share/zoneinfo/Zone/SubZone /etc/localtime #configurer le fuseau horaire
hwclock --systohc #gérer les paramètres régionaux
pacman -S nano #installer nano qui va servir à éditer certains fichiers pour personnaliser l'installation
nano /etc/locale.gen #retirer le # de son paramètre puis sauvegarder pour appliquer la disposition de la langue
locale-gen #mettre à jour le fichier édité plus haut
echo "LANG=en_US.UTF-8" > /etc/locale.conf #paramétrer la langue du système
echo "stalarch" > /etc/hostname #définir le nom de la machine

pacman -S grub efibootmgr #télécharger le chargeur de démarrage grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #installer grub dans la partition EFI précédemment créée
grub-mkconfig -o /boot/grub/grub.cfgpa #générer le fichier de configuration

passwd #créer un mot de passe pour l'utilisateur root
exit #sortir du chroot
reboot #rebootez sur le livecd pour configurer les paramètres réseaux et pouvoir utiliser internet sur le système installé sur le disque
#UEFI Firmware Settings
#Boot Manager
#UEFI VBOX CD-ROM VB2-01700376

loadkeys fr #mettre le clavier en azerty
mount /dev/sda3 /mnt #monter la partition linux filesystem
arch-chroot /mnt #monter la chroot
pacman -S dhcpcd #installer l'outil réseau dhcpcd
systemctl enable dhcpcd #activer dhcpcd
exit #sortir du chroot
reboot #rebootez maintenant sur le système arch installé

#login: root
#password: le mot de passe que vous avez entré

loadkeys fr #mettre le clavier en azerty
pacman -S xfce4 #télécharger xfce4
pacman -S lightdm lightdm-gtk-greeter #téléchargez le gestionnaire de connexion LightDM
systemctl enable lightdm #activez lightDM
reboot #redémarrer, le bureau de xfce devrait apparaître
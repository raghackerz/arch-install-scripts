#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
sed -i s/"#en_US.UTF-8"/"en_US.UTF-8"/ /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=colemak" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
#echo root:password | chpasswd
echo enter password for root user
passwd


# iw, acpi_call, sof-firmware (for mic), firewalld
pacman -S --needed grub efibootmgr networkmanager dialog wpa_supplicant iw base-devel linux-headers avahi nss-mdns bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack acpi acpid tlp

# pacman -S --needed nvidia nvidia-utils nvidia-settings nvidia-prime


# Disable nvidia card
# disabled from bios and used udev rules
#
# arch wiki
#
# /etc/modprobe.d/blacklist-nouveau.conf
# blacklist nouveau
# options nouveau modeset=0

###################################
# /etc/udev/rules.d/00-remove-nvidia.rules
# # Remove NVIDIA USB xHCI Host Controller devices, if present
# ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
# 
# # Remove NVIDIA USB Type-C UCSI devices, if present
# ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
# 
# # Remove NVIDIA Audio devices, if present
# ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
# 
# # Remove NVIDIA VGA/3D controller devices
# ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable avahi-daemon
systemctl enable tlp 
systemctl enable fstrim.timer
systemctl enable acpid
# systemctl enable sshd
# systemctl enable reflector.timer
# systemctl enable firewalld

useradd -m raghackerz
echo raghackerz:password | chpasswd
echo enter password for raghackerz 
passwd raghackerz

echo "raghackerz ALL=(ALL) ALL" >> /etc/sudoers.d/raghackerz


printf "\e[1;32mDone! Type exit, umount -R /mnt and reboot.\e[0m"


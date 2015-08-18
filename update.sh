#Austin Hyder (Doctor Mooch)
#Ver 1.0.1
#
#8/17/15

#Mount rEFInd partition to /mnt
sudo mount /dev/sda1 /mnt

#Update official Arch repositories
sudo pacman -Suy
#Update Arch User Repositories (AUR) via yaourt
yaourt -Suya

#Stores md5 sum for both kernel files on the rEFInd partiton, and /boot partition
kernel1=($(md5sum /boot/vmlinuz-linux))
kernel2=($(md5sum  /mnt/EFI/Arch/vmlinuz-linux))

#Stores md5 sum for both initramfs files on the rEFInd partition, and /boot partition
initram1=($(md5sum /boot/initramfs-linux.img))
initram2=($(md5sum /mnt/EFI/Arch/initramfs-linux.img))

#Checks for mismatches between kernels and initramfs
if [[ "$kernel1" == "$kernel2" && "$initram1" == "$initram2" ]]; then #Kernel and Initramfs match
	echo "You're all set! Kernel and Initramfs match!"
elif [[ "$kernel1" != "$kernel2" && "$initram1" == "$initram2" ]]; then #Kernel does not match
	echo "Your kernel didnt match, fixing now!"
	sudo cp -L /boot/vmlinuz-linux /mnt/EFI/Arch/
elif [[ "$kernel1" == "$kernel2" && "$initram1" != "$initram2" ]]; then #Initramfs does not match
	echo "Your initramfs didnt match, fixing now!"
	sudo cp -L /boot/initramfs-linux.img /mnt/EFI/Arch/
elif [[ "$kernel1" != "$kernel2" && "$initram1" != "$initram2" ]]; then #Kernel and Initramfs do not match
	echo "Both the kernel and the initramfs didnt match! Fixing now!"
	sudo cp -L /boot/vmlinuz-linux /mnt/EFI/Arch/
	sudo cp -L /boot/initramfs-linux.img /mnt/EFI/Arch/
else
	#Could not generate a md5 sum, or initramfs/kernel could not be located
	echo "A problem occured, difference between files could not be determined"
fi

#Unmounts rEFInd partition
sudo umount /mnt

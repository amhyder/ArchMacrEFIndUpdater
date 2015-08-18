#Austin Hyder (Doctor Mooch)
#Ver 1.0
#
#8/17/15

sudo mount /dev/sda1 /mnt

sudo pacman -Suy
yaourt -Suya

kernel1=($(md5sum /boot/vmlinuz-linux))
kernel2=($(md5sum  /mnt/EFI/Arch/vmlinuz-linux))

initram1=($(md5sum /boot/initramfs-linux.img))
initram2=($(md5sum /mnt/EFI/Arch/initramfs-linux.img))

if [[ "$kernel1" == "$kernel2" && "$initram1" == "$initram2" ]]; then
	echo "You're all set! Kernel and Initramfs match!"
elif [[ "$kernel1" != "$kernel2" && "$initram1" == "$initram2" ]]; then
	echo "Your kernel didnt match, fixing now!"
	sudo cp -L /boot/vmlinuz-linux /mnt/EFI/Arch/
elif [[ "$kernel1" == "$kernel2" && "$initram1" != "$initram2" ]]; then
	echo "Your initramfs didnt match, fixing now!"
	sudo cp -L /boot/initramfs-linux.img /mnt/EFI/Arch/
elif [[ "$kernel1" != "$kernel2" && "$initram1" != "$initram2" ]]; then
	echo "Both the kernel and the initramfs didnt match! Fixing now!"
	sudo cp -L /boot/vmlinuz-linux /mnt/EFI/Arch/
	sudo cp -L /boot/initramfs-linux.img /mnt/EFI/Arch/
else
	echo "A problem occured, difference between files could not be determined"
fi

sudo umount /mnt

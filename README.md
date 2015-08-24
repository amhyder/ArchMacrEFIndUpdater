# ArchMacrEFIndUpdater
To be used with most Mac devices dual booting Arch Linux via rEFInd and using "yaourt"

# Whats Going On
This script mounts the rEFInd partition to /mnt, updates all packages via pacman, updates all packages via yaourt, and finally checks to make sure your initramfs and kernel match previous to the update, if not, it will copy over the new initramfs and kernel if a mismatch is detected.

**Update Commands Used**
- sudo pacman -Suy
- yaourt -Suya

# Prerequisites
- rEFInd must be installed and located at /dev/sda1 on your machine.
- You must be running Arch Linux, this will not work with other distros.
- You must have yaourt installed.

# Instructions
- 0. Make sure your rEFInd partition is /dev/sda1 and have nothing mounted in /mnt/
- 1. Run the update.sh script
- 2. If needed, reboot after the script has completed.

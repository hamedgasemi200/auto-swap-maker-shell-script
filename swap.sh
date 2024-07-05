# If user UID is not 0 or is not root
if [ "$EUID" -ne 0 ]; then
   echo -e "You are not authorized. try with root access."
   exit
fi

SIZE=$((2 * $(free -g | grep Mem | awk '{print $2}')))
SWAP_EXISTS=$(free | awk '/^Swap:/ {exit !$2}')

# Set swap off
echo -e "\n ↻ 1. Setting swap off."
if $SWAP_EXISTS; then
   #swapoff -a
   echo -e " ✓ 1. Set swap off.\n"
else
   echo -e "✓ Swap is already off.\n"
fi

# Making swap file.
echo -e " ↻ 2. Writing $SIZE gigs of null bytes to swapfile."
#dd if=/dev/zero of=/swapfile bs=1G count=22 status=progress
echo -e " ✓ 2. Made a complete swapfile.\n"

# Setting permision only to the root user.
echo -e " ↻ 3. Setting permission only to root user."
chmod 600 /swapfile
echo -e " ✓ 3. Set permission only to root user.\n"

# Setting swapfile.
echo -e " ↻ 4. Setting swapfile as a partition."
mkswap /swapfile
echo -e " ✓ 4. Set swapfile as a partition.\n"

# Enabling swapfile
echo -e " ↻ 5. Enabling swap again"
swapon /swapfile
echo -e " ✓ 5. Enabled swapfile.\n"

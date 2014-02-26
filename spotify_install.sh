#! /bin/bash

# Check to see if Spotify repository is in the /etc/apt/sources.list
echo "  Checking /etc/apt/sources.list for repository."
spotify_sources=`grep -o -E "deb http://repository.spotify.com stable non-free" /etc/apt/sources.list | wc -l`
if [ $spotify_sources -eq 0 ]; then
  #Add to /etc/apt/sources.list
  echo '' | sudo tee -a /etc/apt/sources.list
  echo '## SPOTIFY' | sudo tee -a /etc/apt/sources.list
  echo 'deb http://repository.spotify.com stable non-free' | sudo tee -a /etc/apt/sources.list
else
  echo "  Skipping addition to /etc/apt/sources.list."
fi

# Verify downloaded packages
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59

# Run apt-get update
sudo apt-get update

# Get libssl0.9.8
wget http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb

# Install libssl0.9.8
sudo dpkg -i libssl0.9.8_0.9.8o-4squeeze14_amd64.deb

# Remove temp package
rm libssl0.9.8_0.9.8o-4squeeze14_amd64.deb

# Install spotify!
sudo apt-get install libqtgui4 libqtdbus4 libqt4-network spotify-client

echo "  Done. Add Spotify to your menu and you are off to the races."
echo "  Press any key to continue."
read

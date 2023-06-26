DEBIAN_FRONTEND=noninteractive

apt install gnome-pkg-tools -y

# Clone Upstream
git clone https://gitlab.gnome.org/GNOME/gnome-shell -b 44.2 gnome-shell-vrr
cp -rvf ./debian ./gnome-shell-vrr
cd ./gnome-shell-vrr

# Get build deps
apt-get build-dep ./ -y

# Build package
LOGNAME=root dh_make --createorig -y -l -p gnome-shell-vrr_44.2
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/

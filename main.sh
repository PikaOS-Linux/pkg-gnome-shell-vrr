DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://gitlab.gnome.org/GNOME/gnome-shell -b 43.1
mv ./gnome-shell ./gnome-shell-vrr
cp -rvf ./debian ./gnome-shell-vrr
cd ./gnome-shell-vrr

# Get build deps
apt-get build-dep ./ -y

# Build package
LOGNAME=root dh_make --createorig -y -l -p gnome-shell-vrr_43.1
dpkg-buildpackage

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/

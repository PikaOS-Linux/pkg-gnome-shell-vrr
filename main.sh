DEBIAN_FRONTEND=noninteractive

apt-mark hold pbuilder
apt install gnome-pkg-tools -y

# Clone Upstream
git clone https://gitlab.gnome.org/GNOME/gnome-shell -b 45.0 gnome-shell-vrr
cp -rvf ./debian ./gnome-shell-vrr
cd ./gnome-shell-vrr
for i in $(cat ../patches/series) ; do echo "Applying Patch: $i" && patch -Np1 -i ../patches/$i || bash -c "echo "Applying Patch $i Failed!" && exit 2"; done

# Get build deps
apt-get build-dep ./ -y

# Build package
LOGNAME=root dh_make --createorig -y -l -p gnome-shell-vrr_45.1
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/

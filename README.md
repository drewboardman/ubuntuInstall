## Step 1
- Download Ubuntu 16.04.3 and copy to usb device

```
dd bs=512 if=path/to/ubuntu.iso of=/dev/sd? status=progress  # where ? is the usb device
```

- Check "Download updates while installing ubuntu"
- Select "Erase disk and install ubuntu"
- Timezone New York

## Step 2
- If you have an nvidia GPU, you'll need to [install the latest
  drivers](http://www.linuxandubuntu.com/home/how-to-install-latest-nvidia-drivers-in-linux) before you install i3wm.

- Configure system and install packages:

```bash
    wget -O - https://goo.gl/UjTi9R | bash
```

- Log out and log back in for group assignments & user settings to take effect

## Optional Steps

#### Change font to Adobe Source Code Pro
- in you `gnome-terminal` you should change the font to Adobe Source Code Pro Medium 11
- Also hide the menu bar (you can just right click anywhere in the terminal and get the same outcome)

#### Increasing audio fidelity
*NOTE*: These are automatically added by this install script. If you wish to change them or remove them, this info is helpful. You should keep them
though, for the sweet sweet fidelity.

  - open the pulseaudio daemon conf `sudo vim /etc/pulse/daemon.conf`
  - uncomment (by deleting `;` and change the following lines:

```
resample-method = src-sinc-medium-quality
default-sample-format = s24le
default-sample-rate = 48000
```

  - restart pulseaudio

```
pulseaudio -k
pulseaudio --start
```

  - check that it worked

```
pacmd list-sinks | grep sample
=> sample spec: s32le 2ch 44100Hz
```

#### Adding another hard drive

```
sudo mkdir /media/hdd
sudo mount /dev/sdb1 /media/hdd
sudo chown drew:drew /media/hdd
```

Now you want to add it to the `/etc/fstab` file.

Get the UUID with `lsblk -f`

Now add the following line to the bottom of the `fstab`

```
sudo vim /etc/fstab

# add this
UUID=<myuuid> /media/hdd ext4    defaults    0    0
```

#### Connecting to a VPN

#### `openvpn` (for work)

Copy the relevent ovpn and cert files into `/etc/openvpn`.
For instance, here is my dir:

```
-rw-r--r--   1 root root  916 Jan 12 09:01 drew-boardman.key
-rw-r--r--   1 root root  729 Jan 12 09:01 drew-boardman.csr
-rw-r--r--   1 root root 3.8K Jan 12 09:01 drew-boardman.crt
-rw-r--r--   1 root root  122 Jan 12 09:01 work.ovpn
-rw-r--r--   1 root root 1.3K Jan 12 09:01 ca.crt
```

Then connect to the vpn with

```
cd /etc/openvpn && sudo openvpn --config /etc/openvpn/work.ovpn
```

#### PIA
These are instructions to set up PIA to autoconnect using NetworkManager GUI.

```
wget https://www.privateinternetaccess.com/installer/pia-nm.sh
sudo bash pia-nm.sh
```

Now open the `nm-connection-manager` either by clicking `nm-applet` in the
bottom right, or just running `nm-connection-manager`.

Double click on *US-East* (or wherever you want to proxy), and click
*Advanced*->*General*.

Under "Set virtual device type" select `TUN` and name is `tun1` (this is the
config that `.i3status.conf` is looking for.

Now go back and double click the "wired ethernet" or whatever your default
connection is.

Under *General* just select the VPN proxy you configured.

#### VPN issues with DNS
1. Get `openvpn` with `sudo apt-get install openvpn`
2. unzip `ovpn` files
3. Copy the `yourName/**` files into `/etc/openvpn`
4. Connect to the VPN

```
cd /etc/openvpn && sudo openvpn --config /etc/openvpn/YOURFILE.ovpn
```

**NOTE**
There are issues with dns resolving sometimes.

- Download `resolvconf` package.
- backup current `resolv.conf` and symlink the `resolvconf` one in its place

```
cp /etc/resolv.conf ~/tmp
sudo rm /etc/resolv.conf
ln -s /run/resolvconf/resolv.conf /etc/resolv.conf
```

- Now add the following to your `/etc/openvpn/YOURFILE.ovpn`

```
up /etc/openvpn/update-resolv-conf
down /etc/openvpn/update-resolv-conf
```

#### Screen brightness controls
You're going to get errors about how xbacklight can't find inputs that allow brightness controls.

You need to do 2 things:

1. `sudo find /sys/ -type f -iname '*brightness*'`

The output should give you something like this:

`/sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-LVDS-1/intel_backlight/brightness`

symlink this

`sudo ln -s /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-LVDS-1/intel_backlight  /sys/class/backlight
`

2. Make `/etc/X11/xorg.conf` and inside put the following (where you path is replaced with the correct one):

```
Section "Device"
  Identifier  "Card0"
  Driver      "intel"
  Option      "Backlight"  "/sys/class/backlight/intel_backlight"
  EndSection
>>>>>>> 9c41e499b91523cb6dc347ac03cde21bc057d6ae
```
### Using VMs
Once you have a VM set up, there are useful commands you can use

```
drew@hansolo ~/tmp/ubuntuInstall (master) $ vboxmanage list vms
"Ubuntu - Project 1 - Lab environment" {35ff08f3-6096-4c52-9c3d-07383c5601b2}
drew@hansolo ~/tmp/ubuntuInstall (master) $ vboxmanage list runningvms
"Ubuntu - Project 1 - Lab environment" {35ff08f3-6096-4c52-9c3d-07383c5601b2}
# start the vm headless in the background
drew@hansolo ~/tmp/ubuntuInstall (master) $ VBoxHeadless --startvm 35ff08f3-6096-4c52-9c3d-07383c5601b2 &
# this will save the state of the disk and power off the vm
drew@hansolo ~/tmp/ubuntuInstall (master) $ vboxmanage controlvm 35ff08f3-6096-4c52-9c3d-07383c5601b2 savestate
```




#### TODO
- intellij
- scala

#set -x

function download()
{
    echo "downloading $2:"
    curl --location --silent --output /tmp/org.rehabman.download.txt https://bitbucket.org/RehabMan/$1/downloads/
    scrape=`grep -o -m 1 "/RehabMan/$1/downloads/$2.*\.zip" /tmp/org.rehabman.download.txt|perl -ne 'print $1 if /(.*)\"/'`
    url=https://bitbucket.org$scrape
    echo $url
    if [ "$3" == "" ]; then
        curl --remote-name --progress-bar --location "$url"
    else
        curl --output "$3" --progress-bar --location "$url"
    fi
    echo
}

if [ ! -d ./downloads ]; then mkdir ./downloads; fi && rm -Rf downloads/* && cd ./downloads

if [ "$1" == "--usb-kexts" ]; then
    mkdir ./kexts && cd ./kexts
    download os-x-fakesmc-kozlek RehabMan-FakeSMC
    download os-x-realtek-network RehabMan-Realtek-Network
    download os-x-fake-pci-id RehabMan-FakePCIID
    download os-x-usb-inject-all RehabMan-USBInjectAll
    download os-x-voodoo-ps2-controller RehabMan-Voodoo
    exit
fi

# download kexts
mkdir ./kexts && cd ./kexts
download os-x-fakesmc-kozlek RehabMan-FakeSMC
download os-x-realtek-network RehabMan-Realtek-Network
download os-x-voodoo-ps2-controller RehabMan-Voodoo
download os-x-acpi-battery-driver RehabMan-Battery
download os-x-fake-pci-id RehabMan-FakePCIID
download os-x-brcmpatchram RehabMan-BrcmPatchRAM
#download os-x-intel-backlight RehabMan-IntelBacklight
download os-x-usb-inject-all RehabMan-USBInjectAll
download os-x-eapd-codec-commander RehabMan-CodecCommander
download lilu RehabMan-Lilu
download intelgraphicsfixup RehabMan-IntelGraphicsFixup
cd ..

# download tools
mkdir ./tools && cd ./tools
download os-x-maciasl-patchmatic RehabMan-patchmatic
download os-x-maciasl-patchmatic RehabMan-MaciASL
download acpica iasl iasl.zip
cd ..

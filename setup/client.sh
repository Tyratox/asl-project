#!/bin/bash

PFSENSE_PWD=$1
$DEFAULT_CERT_BASE64="LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUVsRENDQTN5Z0F3SUJBZ0lJUGdNTWt1MHVjd3N3RFFZSktvWklodmNOQVFFTEJRQXdXakU0TURZR0ExVUUKQ2hNdmNHWlRaVzV6WlNCM1pXSkRiMjVtYVdkMWNtRjBiM0lnVTJWc1ppMVRhV2R1WldRZ1EyVnlkR2xtYVdOaApkR1V4SGpBY0JnTlZCQU1URlhCbVUyVnVjMlV0TmpFNFpUVXpOVFpqT1RBeE9UQWVGdzB5TVRFeE1USXhNVFF6Ck1UaGFGdzB5TWpFeU1UVXhNVFF6TVRoYU1Gb3hPREEyQmdOVkJBb1RMM0JtVTJWdWMyVWdkMlZpUTI5dVptbG4KZFhKaGRHOXlJRk5sYkdZdFUybG5ibVZrSUVObGNuUnBabWxqWVhSbE1SNHdIQVlEVlFRREV4VndabE5sYm5ObApMVFl4T0dVMU16VTJZemt3TVRrd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUUMvCnRRMmplcyt0VFRkNHZueCtzaXJyQmZDOElHV01aVGNiaDRsdGhhSjZoWFZ1ajRtdTVsbmdTYngrcnJkbTNSVEMKbmpneUp0WUt2TG0ySSthVDlkTm50RWxlaVd4UHkyc21EeFZML0Zqc2Z1amo0bjQvTmVmMjduMEpWck9ZeVU4dQpuMHFQWW42eHpIcFNZWE5Tclh5aEQxdEhqU2ZYbWczYTZsbjFhWFNZSExseUdzUlhKdVFUaHNTSTVZTm9uQ2NNCit2SjFFTVg4SDFUeWJ6VkZQR0FDWXpoc0ZJK1Q3b3NrVDdXdHN0anVzd3hLZVI4SEl5Rk1tbU9oNTR1SlJwOW0KMlJnMmFFWDNDcVV3THlOaUZCRU1rV3B3Z1Z1amUxeFhocDVFUFFwOWYxTDR1SzNmTVpoclBRT0pGN05uT1NNZgp6dS9uQkhiNy9kYWZCWitmZUpRYkFnTUJBQUdqZ2dGY01JSUJXREFKQmdOVkhSTUVBakFBTUJFR0NXQ0dTQUdHCitFSUJBUVFFQXdJR1FEQUxCZ05WSFE4RUJBTUNCYUF3TXdZSllJWklBWWI0UWdFTkJDWVdKRTl3Wlc1VFUwd2cKUjJWdVpYSmhkR1ZrSUZObGNuWmxjaUJEWlhKMGFXWnBZMkYwWlRBZEJnTlZIUTRFRmdRVTN3WXF3QUJ4Q1kxOQp6WGdzVmRtLzJGaUhiL3N3Z1lzR0ExVWRJd1NCZ3pDQmdJQVUzd1lxd0FCeENZMTl6WGdzVmRtLzJGaUhiL3VoClhxUmNNRm94T0RBMkJnTlZCQW9UTDNCbVUyVnVjMlVnZDJWaVEyOXVabWxuZFhKaGRHOXlJRk5sYkdZdFUybG4KYm1Wa0lFTmxjblJwWm1sallYUmxNUjR3SEFZRFZRUURFeFZ3WmxObGJuTmxMVFl4T0dVMU16VTJZemt3TVRtQwpDRDREREpMdExuTUxNQ2NHQTFVZEpRUWdNQjRHQ0NzR0FRVUZCd01CQmdnckJnRUZCUWNEQWdZSUt3WUJCUVVJCkFnSXdJQVlEVlIwUkJCa3dGNElWY0daVFpXNXpaUzAyTVRobE5UTTFObU01TURFNU1BMEdDU3FHU0liM0RRRUIKQ3dVQUE0SUJBUUNXY1lTWEZ6NS9nRVZlR24wcXBncFAzRGhNNWt0T1JtS08wYlV5aE03MUNTemp1YktaTFJ1SAozcVhKb0dOR1dWWW9WSm5NVGdhN1h1eU9xZVRXUzE0Uy9qbUk1MVlNTy9PMDhqSDNyaFYxNnlGaDVYZ2NONCttCkFGOFdTMEJJdkJtQzdkdEhsUkluY3dIRFlBK2lhVHdWdW9TQ1lDUlRMREU1a1hJTnNCenB6UmlacXZvQWNVOTcKNkxuSlFITXNBVEZVeGM0cktWenl5NGxBOGtqMFc4dSthUEozbTZpbGdnckFvSnRIY2dXTHVaMzhZZXdFWUVHdQp4SllGY3VZTnFhM3JpblFjT0lQVVN6QWEvalIyeFNyWS82aGpiN2NycXRSU3NVY1Fna211d2ZWTFk1d29nVWh4ClhvSGRlVFRhMWNtTGk0cW1KZXBiODRsL1lJY2xtUDVLCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
$DEFAULT_KEY_BASE64="LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2Z0lCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktnd2dnU2tBZ0VBQW9JQkFRQy90UTJqZXMrdFRUZDQKdm54K3NpcnJCZkM4SUdXTVpUY2JoNGx0aGFKNmhYVnVqNG11NWxuZ1NieCtycmRtM1JUQ25qZ3lKdFlLdkxtMgpJK2FUOWRObnRFbGVpV3hQeTJzbUR4VkwvRmpzZnVqajRuNC9OZWYyN24wSlZyT1l5VTh1bjBxUFluNnh6SHBTCllYTlNyWHloRDF0SGpTZlhtZzNhNmxuMWFYU1lITGx5R3NSWEp1UVRoc1NJNVlOb25DY00rdkoxRU1YOEgxVHkKYnpWRlBHQUNZemhzRkkrVDdvc2tUN1d0c3RqdXN3eEtlUjhISXlGTW1tT2g1NHVKUnA5bTJSZzJhRVgzQ3FVdwpMeU5pRkJFTWtXcHdnVnVqZTF4WGhwNUVQUXA5ZjFMNHVLM2ZNWmhyUFFPSkY3Tm5PU01menUvbkJIYjcvZGFmCkJaK2ZlSlFiQWdNQkFBRUNnZ0VCQUxyZk5taEJjdWV2K1g3TjBIV0FINjN4b0hVQjczc252c3dyRnArWVFJWEcKU201M3BQTEV3SitOd1J5TUcyTTk1dHEvZUhBS3cySzhEUnVyYXp5WHlIZXlta0o1R3dlOWRya213cy9MTUxONApFblR4ZDdjT1NRdS85a3FBSlptdHdtM2tBTDQ4ZU52QVF3ekN5Yk95UVdhT25aL2x6UXl4c3dmT29kcEQ3Yy9ICm9FMW9zcFp5ektNMlBNa0E4cm92djYwWHRLTGtoT1FRUGVRVmFkYnBCK2xQS1h3OXVHWWRkdnA0ay9LbXBnb0IKUTYyNU1hQXdJdFZ4QjJHa2JyNXozTVA1SXUyRnkxMWVBL0ZnV284SisvT3pEdG5sUS9peGtjRDZGK3hSMFdzQwpvWTNGNG42aEw5R0RwMW12R3QxRU1wWnlta1ZjUklyN3BqdGlpZ0F4djRFQ2dZRUE0bTRMWlNMRmJpL2w3bWZsCm5TN1JnSFc5Q0xFd0xLSmw4TUdQcFQ3YWJOUEJqL005SVdBV2NVZHVKN25yeGxMbGdYVGFKRFRma0NuVlhYaE8KZ1dOSVg2azFuNnFVQXNsdVUvRHlDZGlUbWIrMzFQVTNQdmc2b01HUmVXd0tjWWsvcEUyREgzOS8xOGZpSVNoawp0em9nU3NibnI3ODlndi90c0RoOTQxZUFwV3NDZ1lFQTJMNHJXODlUOTd1REZpYm9TaU5udGtPS1paaGVyelkzCkhZeXd4QjQ0NjVkT0RpM0R2b1pXbFBkWXlQRTM5bWt2bWZBWTlxWHoyNzZuR0ROVUJGbXhRN3VRTFNLSUNtd3kKMHk1VHF6NWZHUHAvSTBWUnQrTHVmbkRWdlVtRUhVRXNCMGFZMnVUNktYVVFzc2c0a2FsZndocTR5NmdJRGpIegp0YWZ4RXFhV3lCRUNnWUJRb2ZONDNuc0VGQmFEWVloSkF5VWo0OG1mVU1uZyt5dm1JbWV1NXNVTndCTEwya2pJCm05a2lHZGZHV2RUMldRclZvUEVWdDZadFJoaHZJcXFDTlFMTzNnajBoT0FVWmZyZDlZMmJwLzVYNEFmczFDNEsKUklkTU8rSThKUmRLK3g4b3VWbWFXK01BeW5OaWIybitQYnJHSmpMWFNQajByNExMSURMa1JJTFJaUUtCZ0VTYQpyUTY2YVZHWXdMMWFRMXgwS0hmQW1TWGZQTmtveC9sS2R3a2NwOWVxWk1LSUtkVThvRnMyajV2Sy9uTzRoNkNxCkpyeXJlcXlyaENoYzF0TXBzTHBIdkRNTkl4SnBmUXpyTlFDWEZYTEtsME9LeFhyM0VaWmtFTU9CYVpmNDhQNjgKa2RWM2ROZDZmbmFZZVk5aGxUWFRUM3JuRE9XeFdmcTkxY2laZ2xDQkFvR0JBTCtaRjZ5VEQ0cXBZOXZvSHhrRApDY2RIQ0xuRzYwbVluenZDUlhEQUpndHpxT3F5ZUdTOEhJUm1QcWRNaG9kcmtHK0xQNXBGaU1nRmhCcWl2WGxHCkZrQ0g3eW8wdjF0eEE0OCtUOE9GOStYZGFhV2tWUWRNUHBKaFdLMHFycEM4YWZDRUc3Ky9LVVVJM2RHMkxDMlIKanI0U2h1N2JHMmJpMzlYTWt5eVhzVElwCi0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0K"

# set the hostname
./optional/set-hostname.sh "client1.imovies.ch"

# general debian hardening is not needed for the client

# except for sudo
apt -y install sudo

# now install the custom root certificate. extension must be .crt
cp ./public-keys/web-root.crt /usr/local/share/ca-certificates/
update-ca-certificates

# resolve hostnames using /etc/hosts
echo "192.168.0.1 imovies.ch" >> /etc/hosts
echo "192.168.0.2 ca.imovies.ch" >> /etc/hosts
echo "192.168.0.2 auth.imovies.ch" >> /etc/hosts

echo "10.0.0.254 fw-1.imovies.ch" >> /etc/hosts
echo "10.0.0.253 fw-2.imovies.ch" >> /etc/hosts

echo "172.16.0.1 backup.imovies.ch" >> /etc/hosts

# change network interface name s.t. the first interface is called eth0
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

cat ./configs/client-interfaces.conf > /etc/network/interfaces

# set the ip of the computer
sed -i 's/address 10.0.0.0/address 10.0.0.1/' /etc/network/interfaces

# if an argument was passed, edit the config file
if [ -n "$PFSENSE_PWD" ]
then
  OLD_HASH='$2y$10$ToXr.qZNhukmRUOUaddJFOhnn07fs1/9U/M/mUEEXDkW738orfgpK'
  # install htpasswd, required for generating a bcrypt hash
  apt -y install apache2-utils
  HASH=$(htpasswd -bnBC 10 "" "$PFSENSE_PWD" | tr -d ':\n')
  apt -y purge apache2-utils

  # replace hash inside the config file
  sed -i "s/$OLD_HASH/$HASH/" ./configs/pfsense/fw-1.imovies.ch.xml
  sed -i "s/$OLD_HASH/$HASH/" ./configs/pfsense/fw-2.imovies.ch.xml
fi

if [ -n "$PFSENSE_USERNAME" ]
then
  sed -i "s/<name>admin</name>/<name>$PFSENSE_USERNAME</name>/" ./configs/pfsense/fw-1.imovies.ch.xml
  sed -i "s/<name>admin</name>/<name>$PFSENSE_USERNAME</name>/" ./configs/pfsense/fw-2.imovies.ch.xml
  sed -i "s/admin@/$PFSENSE_USERNAME@/g" ./configs/pfsense/fw-1.imovies.ch.xml
  sed -i "s/admin@/$PFSENSE_USERNAME@/g" ./configs/pfsense/fw-2.imovies.ch.xml
fi

# download certificates and private keys
git clone https://github.com/asl-project-group-7-2021/asl-project-keys.git ../asl-project-keys

CRT_1_BASE64=$(cat ../asl-project-keys/fw-1.imovies.ch/fw-1.imovies.ch.crt)
CRT_2_BASE64=$(cat ../asl-project-keys/fw-2.imovies.ch/fw-2.imovies.ch.crt)

KEY_1_BASE64=$(cat ../asl-project-keys/fw-1.imovies.ch/fw-1.imovies.ch.key)
KEY_2_BASE64=$(cat ../asl-project-keys/fw-2.imovies.ch/fw-2.imovies.ch.key)

sed -i "s/<crt>$DEFAULT_CERT_BASE64<\/crt>/<crt>$CRT_1_BASE64<\/crt>/" ./configs/pfsense/fw-1.imovies.ch.xml
sed -i "s/<crt>$DEFAULT_CERT_BASE64<\/crt>/<crt>$CRT_2_BASE64<\/crt>/" ./configs/pfsense/fw-2.imovies.ch.xml

sed -i "s/<prv>$DEFAULT_KEY_BASE64<\/prv>/<prv>$KEY_1_BASE64<\/prv>/" ./configs/pfsense/fw-1.imovies.ch.xml
sed -i "s/<prv>$DEFAULT_KEY_BASE64<\/prv>/<prv>$KEY_2_BASE64<\/prv>/" ./configs/pfsense/fw-2.imovies.ch.xml

./cleanup.sh
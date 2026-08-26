# step0
Make sure everyone backed up the data.

# step1
Test which Ubuntu version we can go up to starting with 26.04 and going down if needed until all works.
After the version is determined, the update can begin. 

```{bash}
sudo apt update
sudo apt upgrade -y
systemctl reboot
```

Install ```update-manager-core``` if not installed

```{bash}
sudo do-release-upgrade
```
Repeat until arrived at the last possible version.

# step2
Check of any old software is missing. Install all missing software.
```{bash}
lsb_release -a
apt-mark showmanual > post-upgrade_manual-packages.txt
diff pre-upgrade_manual-packages.txt post-upgrade_manual-packages.txt
```

# step3
Install slurm according to the guide: https://slurm.schedmd.com/quickstart_admin.html#quick_start

# step4
Install all requested packages if they are not installed already

# step5
set max resources slurm jobs can use

# step6 (optional)
Set a maximum of scratch space usage

# step7 (optional)
Install ```lmod``` or ```environment-modules``` if we want to have system-wide modules.

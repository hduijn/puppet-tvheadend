puppet-tvheadend
===================

Puppet modules for deployment of tvheadend with oscam for use with Ziggo digital TV

Parameters
-------------
All parameters are set as defaults in init.pp or can be overwritten using the Foreman

Classes
-------------
- tvheadend

Dependencies
-------------
- no module dependencies.


Parameters
-------------
Version and packages, defaults to the packages needed for compiling from source.


```
  $packages         = ['build-essential','autoconf','openmpi-bin','libopenmpi-dev','libmpich2-dev','mpich2','subversion','libtool','pkg-config','openjdk-6-jdk'] 
  $tvheadendrepo     = 'https://github.com/tvheadend/tvheadend.git',
  $tvheadendrepotype = 'git',
  $oscamrepo         = 'http://www.streamboard.tv/svn/oscam/trunk',
  $oscamrepotype     = 'svn',
  $packages          = ['build-essential','autoconf','git','subversion','pkg-config','libssl-dev','bzip2','wget','dialog'],
  $htsdirs           = ['/home/hts','/home/hts/.hts','/home/hts/.hts/tvheadend','/home/hts/.hts/tvheadend/caclient'],
  $oscamdirs         = ['/opt/oscam','/opt/oscam/etc','/opt/oscam/etc/cw'],
  $usbbusnr          = '003',  # find usbbus and usbdevnr using lsusb command
  $usbdevnr          = '003',
  $resetusingcron    = true,
  $resethour         = 5,

```
Result
-------------

Limitations
-------------
This module has been built on and tested against Puppet 3 and higher.

The module has been tested on:
- Ubuntu 14.04LTS


Authors
-------------
Author Name <hugo.vanduijn@naturalis.nl>


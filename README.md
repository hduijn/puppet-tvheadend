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
  $oscamversion     = '3.2.2',
  $tvheadendversion = '1.2.1',
  $packages         = ['build-essential','autoconf','openmpi-bin','libopenmpi-dev','libmpich2-dev','mpich2','subversion','libtool','pkg-config','openjdk-6-jdk'] 

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


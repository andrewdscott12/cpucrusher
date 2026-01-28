# cpucrusher
A simple POSIX Threaded based utility for exercising CPU dispatch targets

## Compilation

```bash
make
```

This compiles with: `gcc -O3 -lm -lpthread`

## Installation

### From Source
```bash
make install DESTDIR=/ INSTALL_DIR=/usr/local/bin
```

### DEB Package (Debian/Ubuntu)
```bash
dpkg-buildpackage -us -uc
sudo dpkg -i ../cpucrusher_1.0-1_amd64.deb
```

### RPM Package (Fedora/RHEL/CentOS)
```bash
./buildrpm.sh
sudo rpm -ivh ~/rpmbuild/RPMS/x86_64/cpucrusher-1.0-1.fc*.x86_64.rpm
```
### Building under IBM AIX 7.x
This package will work on IBM AIX if the IBM Open Source Toolbox is installed, using GCC. The AIX rpmbuild is older, so macros need to be set. Before building, create a ~/.rpmmacros file with these content:
```bash
%_topdir %(echo $HOME)/rpmbuild
%_builddir %{_topdir}/BUILD
%_rpmdir %{_topdir}/RPMS
%_srcrpmdir %{_topdir}/SRPMS
%_sourcedir %{_topdir}/SOURCES
%__debug_install_post %{nil}

## Usage
```bash
cpucrusher <numthreads> <iterations>
```

### Example
```bash
cpucrusher 4 100000
```

This spawns 4 threads, each performing 100,000 iterations of math operations to stress the CPU.

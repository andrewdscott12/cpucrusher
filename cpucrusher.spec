Name:           cpucrusher
Version:        1.0
Release:        1%{?dist}
Summary:        A POSIX threaded utility for exercising CPU dispatch targets

License:        GPL-2.0-or-later
URL:            https://github.com/yourusername/cpucrusher
Source0:        cpucrusher-%{version}.tar.gz

BuildRequires:  gcc
BuildRequires:  glibc-devel

Requires:       glibc
Requires:       libgomp

%global debug_package %{nil}

%description
cpucrusher is a simple POSIX threaded utility for exercising CPU dispatch targets.
It spawns multiple threads and performs mathematical operations to stress the CPU.

%prep
%setup -q

%build
make

%install
%make_install DESTDIR=%{buildroot} INSTALL_DIR=%{_bindir}

%files
%{_bindir}/%{name}

%changelog
* Tue Jan 28 2026 Andrew Scott <andrew@andrewdscott.com> - 1.0-1
- Initial package release

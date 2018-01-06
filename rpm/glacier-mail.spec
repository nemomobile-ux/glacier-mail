Name:       glacier-mail
Summary:    Mail application for nemo
Version:    0.1.0
Release:    1
Group:      Applications/System
License:    GPLv2
URL:        https://github.com/nemomobile-ux/glacier-mail
Source0:    %{name}-%{version}.tar.bz2

Requires:   qt-components-qt5
Requires:   libqmfmessageserver1-qt5
Requires:   nemo-qml-plugin-email-qt5 >= 0.0.8
Requires:   mapplauncherd-booster-qtcomponents-qt5
Requires:   libglacierapp >= 0.1.1

BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5WebKit)
BuildRequires:  pkgconfig(qdeclarative5-boostable)
BuildRequires:  desktop-file-utils
BuildRequires:  pkgconfig(glacierapp)

%description
Mail application using Qt Quick for Nemo Mobile.

%prep
%setup -q -n %{name}-%{version}

%build

%qmake5 

make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
%qmake5_install

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_bindir}/glacier-mail
%{_datadir}/glacier-mail
%{_datadir}/applications/glacier-mail.desktop

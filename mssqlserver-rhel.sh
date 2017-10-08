#!/bin/bash

clear

tput setaf 4;
echo ""
echo "$(tput bold)Microsoft SQL Server 2017 Installer Script$(tput sgr 0)"
echo ""
echo "$(tput bold)Linux Version:    RHEL 7 Workstation/Server$(tput sgr 0)"
echo "$(tput bold)Script Version:   1.0$(tput sgr 0)"
echo "$(tput bold)Author:           Gregory Zuckerman$(tput sgr 0)"
echo ""
  tput setaf 7;
    curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-2017.repo
      tput setaf 6;
echo ""
echo "Package Added"
echo ""
  tput setaf 7;
    yum install -y mssql-server
      tput setaf 6;
echo ""
echo "Install completed"
echo ""
  tput setaf 7;
    /opt/mssql/bin/mssql-conf setup
      tput setaf 6;
echo ""
echo "Basic setup completed"
echo ""
  tput setaf 7;
    systemctl status mssql-server
      tput setaf 6;
echo ""
echo "Adding Firewall rules"
echo ""
  tput setaf 7;
    sudo firewall-cmd --zone=public --add-port=1433/tcp --permanent
      sudo firewall-cmd --reload
        tput setaf 6;
echo ""
  read -p "Would you like to install the command line tools? (y/n): " choice
    case "$choice" in
      y|Y )   sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/7/prod.repo
              echo ""
              echo "Package Added"
              echo ""
              echo "Installing command line tools"
              sudo yum remove unixODBC-utf16 unixODBC-utf16-devel
              sudo yum install -y mssql-tools unixODBC-devel
              echo ""
              echo "Adding to PATH"
              echo ""
              echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
              echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
              source ~/.bashrc
              echo "";;
      n|N)    tput setaf 7;
              echo ""
              echo "$(tput setab 2)Installation completed$(tput sgr 0)"
              echo "";;
      * ) echo "Invalid option.";;
    esac
tput sgr 0

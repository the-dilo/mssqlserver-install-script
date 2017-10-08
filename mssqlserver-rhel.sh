#!/bin/bash

#########################################################################
# mssqlserver-rhel.sh
#
# MS SQL Server 2017 Install Script
#
# A simple BASH script to install MS SQL Server from the
# Microsoft YUM repository.
#
# Author    : Gregory Zuckerman
# Created   : 8 Oct 2017
# Github    : https://github.com/gregoryzuckerman/
#
#########################################################################

clear

tput setaf 4;
echo ""
echo -e "$(tput bold)Microsoft SQL Server 2017 Installer Script$(tput sgr 0)\n"
echo "$(tput bold)Linux Version:    RHEL 7 Workstation/Server$(tput sgr 0)"
echo -e "$(tput bold)Script Version:   1.0$(tput sgr 0)\n"
  tput setaf 7;

####### Add Microsoft YUM repository
    curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-2017.repo
      tput setaf 6;
echo ""
echo -e "Package Added\n"

####### Install MS SQL Server
  tput setaf 7;
    yum install -y mssql-server
      tput setaf 6;
echo ""
echo -e "Install completed\n"
  tput setaf 7;

####### Initialize setup
    /opt/mssql/bin/mssql-conf setup
      tput setaf 6;
echo ""
echo -e "Basic setup completed\n"

####### Start MS SQL Server
  tput setaf 7;
    systemctl status mssql-server
      tput setaf 6;

####### Adding default MS SQL port to the firewall
echo ""
echo -e "Adding Firewall rules\n"
  tput setaf 7;
    sudo firewall-cmd --zone=public --add-port=1433/tcp --permanent
      sudo firewall-cmd --reload
        tput setaf 6;

####### Offer user the option to install SQL Server command line tools
echo ""
  read -p "Would you like to install the command line tools? (y/n): " choice
    case "$choice" in
      y|Y )   sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/7/prod.repo
              echo ""
              echo -e "Package Added\n"
              echo ""
              echo "Installing command line tools"
              sudo yum remove unixODBC-utf16 unixODBC-utf16-devel
              sudo yum install -y mssql-tools unixODBC-devel
              echo ""
              echo -e "Adding to PATH\n"
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


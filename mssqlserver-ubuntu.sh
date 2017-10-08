#!/bin/bash

######################################################################################
# mssqlserver-rhel.sh
#
# Microsoft SQL Server 2017 Install Script
#
# A simple BASH script to install MS SQL Server from the Microsoft APT repository.
#
# Author    : Gregory Zuckerman
# Created   : 8 Oct 2017
# Github    : https://github.com/gregoryzuckerman/mssqlserver-install-script/
#
######################################################################################

clear

tput setaf 4;
echo ""
echo -e "$(tput bold)Microsoft SQL Server 2017 Installer Script$(tput sgr 0)\n"
echo "$(tput bold)Linux Version:    Ubuntu Workstation/Server$(tput sgr 0)"
echo -e "$(tput bold)Script Version:   1.0$(tput sgr 0)\n"
echo ""
      tput setaf 7;
        curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
          tput setaf 4;
echo ""
echo -e "Imported the public repository GPG keys.\n"
echo -e "Registered the Microsoft SQL Server Ubuntu repository.\n"
      tput setaf 7;
        sudo add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"
          sudo apt-get update
            sudo apt-get install -y mssql-server
              tput setaf 2;
echo ""
echo -e "Package Installed\n"
echo -e "Starting configuration\n"
      tput setaf 7;
        /opt/mssql/bin/mssql-conf setup
          tput setaf 4;
echo ""
echo -e "Configuration completed\n"
      tput setaf 7;
        systemctl status mssql-server
          tput setaf 2;
echo ""
echo -e "$(tput bold)Information:$(tput sgr 0)\n"
echo -e "$(tput setaf 7)If you plan to connect remotely, you will also need to open the SQL Server TCP port (default 1433) on your firewall.$(tput sgr 0)\n"
      tput setaf 6;
        read -p "Would you like to install the command line tools? (y/n): " choice
          case "$choice" in
            y|Y )   curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
              echo ""
              echo -e "Imported the public repository GPG keys.\n"
              echo "Registering the Microsoft Ubuntu repository."
                sudo add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list)"
              echo "Installing Tools"
                sudo apt-get update
                  sudo apt-get install -y mssql-tools unixodbc-dev
              echo "";;
            n|N)   tput setaf 7;
              echo ""
              echo -e "$(tput setab 2)Installation completed$(tput sgr 0)\n";;
            * ) echo "Invalid option.";;
          esac
tput sgr 0

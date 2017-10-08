#!/bin/bash

clear

tput setaf 4;
echo ""
echo "$(tput bold)Microsoft SQL Server 2017 Installer Script$(tput sgr 0)"
echo ""
echo "$(tput bold)Linux Version:    Ubuntu Workstation/Server$(tput sgr 0)"
echo "$(tput bold)Script Version:   1.0$(tput sgr 0)"
echo "$(tput bold)Author:           Gregory Zuckerman$(tput sgr 0)"
echo ""
      tput setaf 7;
        curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
          tput setaf 4;
echo ""
echo "Imported the public repository GPG keys."
echo ""
echo "Registered the Microsoft SQL Server Ubuntu repository."
echo ""
      tput setaf 7;
        sudo add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"
          sudo apt-get update
            sudo apt-get install -y mssql-server
              tput setaf 2;
echo ""
echo "Package Installed"
echo ""
echo "Starting configuration"
echo ""
      tput setaf 7;
        /opt/mssql/bin/mssql-conf setup
          tput setaf 4;
echo ""
echo "Configuration completed"
echo ""
      tput setaf 7;
        systemctl status mssql-server
          tput setaf 2;
echo ""
echo "$(tput bold)Information:$(tput sgr 0)"
echo ""
echo "$(tput setaf 7)If you plan to connect remotely, you will also need to open the SQL Server TCP port (default 1433) on your firewall.$(tput sgr 0)"
echo ""
      tput setaf 6;
        read -p "Would you like to install the command line tools? (y/n): " choice
          case "$choice" in
            y|Y )   curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
              echo ""
              echo "Imported the public repository GPG keys."
              echo ""
              echo "Registering the Microsoft Ubuntu repository."
                sudo add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list)"
              echo "Installing Tools"
                sudo apt-get update
                  sudo apt-get install -y mssql-tools unixodbc-dev
              echo "";;
            n|N)   tput setaf 7;
              echo ""
              echo "$(tput setab 2)Installation completed$(tput sgr 0)"
              echo "";;
            * ) echo "Invalid option.";;
          esac
tput sgr 0

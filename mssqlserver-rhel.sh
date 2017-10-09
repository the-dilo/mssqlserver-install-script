#!/bin/bash

######################################################################################
# mssqlserver-rhel.sh
#
# Microsoft SQL Server 2017 Install Script
#
# A simple BASH script to install MS SQL Server from the Microsoft YUM repository.
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
echo    "$(tput bold)Linux Version:    RHEL 7 Workstation/Server$(tput sgr 0)"
echo -e "$(tput bold)Script Version:   1.0$(tput sgr 0)\n"
  tput setaf 7;

read -p "New install or Upgrade of Microsoft SQL Server 2017? (n/u): " install_type
case "$install_type" in

* )

 echo ""
  echo "Invalid option.";;

u|U )

 tput setaf 7;
   yum update mssql-server
    echo ""
     echo -e "Check for upgrade complete\n";;

n|N )

####### Add Microsoft YUM repository

  sudo rm -rf /etc/yum.repos.d/mssql-server.repo
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

esac

####### Offer user the option to install SQL Server command line tools

  read -p "Would you like to install or update the command line tools? (y/n/U): " tools
    case "$tools" in

      y|Y )   sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/7/prod.repo
              tput setaf 7;
              echo ""
              echo -e "Package Added\n"
              echo "Installing command line tools"
              sudo yum remove unixODBC-utf16 unixODBC-utf16-devel
              sudo yum install -y mssql-tools unixODBC-devel
              echo ""
               echo -e "Adding to PATH environment variables\n"

                ####### Adding to both login and non-login sessions

                echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
                echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
                source ~/.bashrc
                echo -e "$(tput setaf 2)Installation Completed\n$(tput sgr 0)";;

      n|N)     tput setaf 7;
                echo ""
                echo -e "$(tput setaf 2)Installation Completed\n$(tput sgr 0)";;

      u|U)     tput setaf 7;
                echo ""
                echo -e "Checking for update\n"
                sudo yum update mssql-tools unixODBC-devel
                  echo ""
                  echo -e "$(tput setaf 2)Installation Completed\n$(tput sgr 0)";;

      * )     echo "Invalid option.";;

esac

tput sgr 0

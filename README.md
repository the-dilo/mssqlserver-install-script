# Microsoft SQL Server BASH Script

Bash script to install Microsoft SQL Server on Linux.

SQL Server 2017 has the following system requirements for Linux:

|   |        |
| ------------- |:--------------|
| Memory        | 3.25 GB |
| File System   | XFS or EXT4 |
| Disk space	      | 6 GB     |
| Processor speed   | 2 GHz      |
| Processor cores   | 2 cores |
| Processor type    | x64-compatible only  |

Usage:

RHEL 7.3 or 7.4:

```bash
wget https://raw.githubusercontent.com/gregoryzuckerman/mssqlserver-install-script/master/mssqlserver-rhel.sh && chmod u+x mssqlserver-rhel.sh && sudo ./mssqlserver-rhel.sh

```

Ubuntu 16.04:

```bash
wget https://raw.githubusercontent.com/gregoryzuckerman/mssqlserver-install-script/master/mssqlserver-ubuntu.sh && chmod u+x mssqlserver-ubuntu.sh && sudo ./mssqlserver-ubuntu.sh

```

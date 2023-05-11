import 'package:flutter/material.dart';

var defaultBackgroundColor = Colors.grey[300];
var appBarColor = Colors.grey[900];
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: const Text(' '),
  centerTitle: false,
);
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);
var myDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  elevation: 0,
  child: Column(
    children: [
      const DrawerHeader(
        child: Icon(
          Icons.dock,
          size: 64,
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: const Icon(Icons.home),
          title: Text(
            'D A S H B O A R D',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: const Icon(Icons.settings),
          title: Text(
            'S E T T I N G S',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: const Icon(Icons.info),
          title: Text(
            'A B O U T',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: const Icon(Icons.logout),
          title: Text(
            'L O G O U T',
            style: drawerTextColor,
          ),
        ),
      ),
    ],
  ),
);
Map<String, String> database = {
  'TRACEROUTE': ' check the route packets take to a specified host.',
  'CHPASSWORD':
      ' allows users to change the password for various user accounts.',
  'JOURNALCTL': ' query the systemd journal.',
  'SYSTEMCTL': ' central management tool for controlling the init system.',
  'NSLOOKUP': ' query Internet name servers (NS) interactively.',
  'KILLALL': ' Sends a kill signal to all instances of a process by name.',
  'GLANCES': ' htop Alternatives:',
  'APROPOS': ' Search man page names and descriptions.',
  'NETSTAT': ' for network statistics.',
  'NETHOGS': ' network traffic analyzer.',
  'USERMOD':
      ' used to modify or change any attributes of an existing user account.',
  'USERDEL': ' used to delete a user account and all related files.',
  'USERADD': ' create a new user or update default new user information.',
  'HISTORY': ' used to view the previously executed commands.',
  'CHROOT': ' run command or interactive shell with a special root directory.',
  'SCREEN':
      ' hold a session open on a remote server. (also a full-screen window manager)',
  'PSTREE': ' display a tree of processes.',
  'IOSTAT': ' for storage I/O statistics.',
  'PASSWD': ' change a user password.',
  'PARTED': ' for creating and manipulating partition tables.',
  'VMSTAT':
      ' shows system memory, processes, interrupts, paging, block I/O, and CPU info.',
  'LOCATE': ' search files in Linux.',
  'UPTIME': ' shows system uptime and load average.',
  'WHOIS': ' client for the whois directory service.',
  'TOUCH':
      ' used to update the access date and modification date of a computer file or directory.',
  'NMCLI': ' command-line tool for controlling NetworkManager.',
  'FDISK': ' manipulate the disk partition table.',
  'RSYNC': ' remote file transfers and syncing.',
  'NOHUP': ' Run Commands in the Background.',
  'BLKID': ' command-line utility to locate/print block device attributes.',
  'BZIP2': ' similar to gzip. It uses a different compression algorithm.',
  'SLEEP': ' suspends program execution for a specified time.',
  'MKDIR': ' create or make new directories.',
  'MOUNT': ' provides access to an entire filesystem in one directory.',
  'CLEAR': ' clears the screen of the terminal.',
  'DMESG': ' prints the message buffer of the kernel ring.',
  'IOTOP': ' interactive I/O viewer. Get an overview of storage r/w activity.',
  'IFTOP': ' network traffic viewer.',
  'DSTAT':
      ' view processes, memory, paging, I/O, CPU, etc., in real-time. All-in-one for vmstat, iostat, netstat, and ifstat.',
  'UMASK': ' set file mode creation mask.',
  'CHEAT':
      ' allows you to create and view interactive cheatsheets on the command line.',
  'CHMOD': ' change the access permissions of file system objects.',
  'CHOWN': ' change file owner and group.',
  'NLOAD': ' a super simple, command-line network interface monitoring tool.',
  'WGET': ' retrieve files over HTTP, HTTPS, FTP, and FTPS.',
  'CURL':
      ' transferring data using various network protocols. (supports more protocols than wget)',
  'MORE': ' display file contents one screen/page at a time.',
  'MKFS': ' build a Linux file system.',
  'FSCK': '  tool for checking the consistency of a file system.',
  'TAIL': ' used to display the tail end of a text file or piped data.',
  'LESS': ' similar to the more command with additional features.',
  'HOST': ' perform DNS lookups in Linux.',
  'FREE': ' display memory usage.',
  'BTOP': ' C++ version and continuation of bashtop and bpytop.',
  'FIND': ' locates files based on some user-specified criteria.',
  'NCDU': ' a disk utility for Unix systems.',
  'LAST': ' show a listing of last logged-in users.',
  'TLDR': ' Collaborative cheatsheets for console commands.',
  'GREP':
      ' Search a file for a pattern of characters, then display all matching lines.',
  'HTOP': ' interactive process viewer and manager.',
  'ATOP': ' For Linux server performance analysis.',
  'SUDO': ' execute commands with administrative privilege.',
  'TMUX': ' a terminal multiplexer.',
  'GZIP': ' file compression and decompression.',
  'WAIT':
      ' Suspend script execution until all jobs running in the background have been terminated.',
  'CRON': ' set up scheduled tasks to run.',
  'PING': ' send ICMP ECHO_REQUEST to network hosts.',
  'KILL': ' terminate a process.',
  'ENV': ' Run a command in a modified environment.',
  'SAR':
      ' collects, reports, and saves system activity information, including CPU, memory, disk, and network usage.',
  'MTR': ' network diagnostic tool.',
  'CAT': ' display file contents.',
  'TAC': ' output file contents, in reverse.',
  'DIG': ' DNS lookup utility.',
  'SCP': ' securely Copy Files Using SCP, with examples.',
  'TOP': ' shows an overall system view.',
  'ZIP': ' for packaging and compressing (to archive) files.',
  'TAR': ' an archiving utility.',
  'MAN': ' for reading system reference manuals.',
  'SSH': ' secure command-line access to remote Linux systems.',
  'PWD': ' shows your current directory location.',
  'LS': ' list directory contents.',
  'DF': ' display disk space usage.',
  'DU': ' estimate file space usage.',
  'SS': ' utility to investigate sockets.',
  'CD': ' directory navigation.',
  'CP': ' copying files and folders.',
  'MV': ' moving files and folders.',
  'RM': ' removing files and folders.',
  'PS': ' information about the currently running processes.',
  'IP':
      ' from Iproute2, a collection of utilities for controlling TCP/IP networking and traffic control in Linux.',
  'DD': ' convert and copy files.',
  'NC': ' command-line networking utility.',
  'VI': ' text editor.',
  'W': ' show a list of currently logged-in user sessions.',
};

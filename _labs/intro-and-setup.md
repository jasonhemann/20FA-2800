---
layout: single
---

### Objectives 

	 

In your first lab you will set up the technology we will use for this course. This will provide you with all the tools you need to complete the first homework. 

  - If you are not already familiar with basic unix commands, find and read one of the many online tutorials so that you can create directories, rename files, etc. from an `xterm`.
  - We will be using a virtual machine (VM). If you do not know what that is, find and read an introduction to virtual machines.

## Piazza 

  1. You should have received an invitation to our course's Piazza site. Go there and register. 
  2. The top and only post on that Piazza site has a link to the course site on the handins (bottlenose) server. 

## 



## Hypothes.is 

[Register here](https://hypothes.is/signup) for Hypothes.is, the
collaborative editing tool. You may find some portions of the reading
assignments less clear than others, sub-optimally ordered, or
otherwise with room for improvement. We will overcome this by
collaboratively annotationg. I will expect student to collaboratively
edit and annotate certain notes and documents.



Chrome users can download and install the [extension](https://chrome.google.com/webstore/detail/bjfhmglciegochdpefhhlphglcehbmek), if you
wish. Users of other browsers can [install the bookmarklet](https://web.hypothes.is/start/#chrome-missing:~:text=For%20any%20browser%2C%20drag%20this%20button,or%20right%2Dclick%2Fcontrol%2Dclick%20to%20bookmark%20the%20link.). I will link
all our `pdf` documents via hypothesis. FYI, if you are on an Android
device, you can send any page to hypothesis via the [following app](https://play.google.com/store/apps/details?id=com.navasgroup.annoteweb).

-- https://hypothes.is/groups/97DiEo3n/fa20cs2800



# Technology Setup and Installation. 

Installation instructions

Follow the installation instructions for your OS.
Linux installation
Windows installation
Mac installation
Getting Started with ACL2s

Documentation on ACL2s can be found here. In particular, see the Get Set section on how to set up Eclipse.
ACL2s is built on top of ACL2, which has extensive documentation. I suggest that you download a local copy of the documentation. Save and expand the documentation file in a convenient location which will make looking up documentation easier.
Once you have ACL2s up and running, you should:
Use ACL2s to define some simple functions in ACL2s mode. Only use ACL2s mode.
Explore the ACL2s GUI and keyboard shortcuts.
Information on how to do all of this is available from the ACL2s Web page.
Running ACL2s on Khoury Virtual Desktops

You can run ACL2s using the Khoury Virtual Desktops Infrastructure (VDI). See the documentation. You have many options including using an HTML client that allows you to log into a virtual machine and run ACL2s using a browser. Use your Khoury CS account credentials and select "CCIS-WINDOWS"; then select "Linux Lab" and you will see a Desktop. Use the file explorer and click on "Other Locations", "Computer", "bin" and then "acl2s". Drap the acl2s icon to your Desktop while holding "Alt" or "Option" (on Mac) and when you release it, a menu will pop up; select "link here" and you will have a direct link to ACL2s in your Desktop. Double click on the acl2s icon in your desktop and this will start ACL2s on your VM.
FAQ

The resolution of eclipse is horrible. What can I do?
Adjust your display settings as described here.
I did not follow the installation instructions/I am in a weird state. What should I do?
First, try running vagrant destroy and then vagrant up. This will delete your existing VM and create a new one for you. Again, this process may take 20-30 minutes. Just start over and go through the instructions carefully. Delete the whole directory with the ACL2s installation and run vagrant destroy, andthen start again. Make sure to download the Vagrantfile again in case you have an old version.
I am getting error messages about permissions. What should I do?
Make sure you have administrative permissions so that you can install software on your machine.
I tried to install ACL2s on a Mac in the /Applications directory. It isn't working; what should I do?
Install ACL2s in your home directory (say in Desktop) because installing software in /Applications/ on a Mac involves extra work.
When I try saving the state of the VM, I get errors when I try to start it up again. Now what?
Just use the "Power off machine" option. It is more stable and that should resolve your issues.
How do I use the synced workspace directory?
Only create directories in workspace using ACL2s because eclipse will not recognize a project directory it did not create. Once you create a project directory, you can add files to the directory from you OS using the synced directory. Don't add files to the workspace directory from your OS in any other way! Once you have added files (say homework files you downloaded), then in eclipse, in the project explorer, refresh the project and you will now see and will be able to access the files you added.
VirtualBox is telling me that there is a new version of a box. What should I do?
The box ubuntu/bionic64 gets updated routinely, but there is no reason for you to upgrade, destroy or recreate the machine. Assuming you have a working installation, there is no need to update unless we explictly tell you to do so.
I tried everything and I am getting timeout error messages.
Make sure that your VM can access the network. A firewall or some other kind of software you have installed may be stopping VirtualBox from accessing the internet. You can check if you have internet access by logging into your VM and typing
ping google.com

If you see timeout messages that means you do not have networking capabilities. How to resolve this depends on your configuration and is not something we can help you with.
I am getting errors about VT-x being disabled. What should I do?
You have to to enable virtualization technology in your bios. See the Windows installation instructions.
I am getting error messages when I run vagrant that say something about "no providers found" but I installed Virtualbox!
Make sure that Virtualbox is version 6.0.14 and not 6.1. Additionally, make sure that you installed vagrant after Virtualbox - if you didn't or you're not sure, just reinstall vagrant.

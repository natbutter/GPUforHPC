---
title: "Connecting to Artemis"
---

Connections to Artemis are **remote connections** -- you'll never sit at one of Artemis' machines, which are stored in a secure data-centre in Western Sydney. Instead, you connect remotely into one of Artemis' **login nodes**. Login nodes are Artemis machines that don't perform any actual computing jobs, but simply provide users with an access gateway to Artemis' filesystems and the PBS Pro **job scheduler**.

You can thus connect to Artemis from _anywhere_, requiring only a **terminal emulator** with an **SSH client**. (If you're not on the USyd network (ie off-campus), you'll also need to connect to the University's **[VPN](http://staff.ask.sydney.edu.au/app/answers/detail/a_id/519/kw/vpn)**, or use Artemis' intermediate **_Jump server_**).

If you followed the [Setup]({{ page.root }}/setup) instructions, then you should already have the required software installed. If not, _please go do this now_!


<h2 data-toc-text="via SSH command line"> Connecting via SSH in a terminal (recommended)</h2>

Depending on your computer's operating system, there may be several ways to connect to Artemis. The simplest way is to open your **terminal emulator** application, and 'ssh' into the Artemis login-servers. This is our recommended method, as to use Artemis effectively you should get comfortable working on the **command line**.

Linux and Mac both have native terminal apps, so you only need to open them. You may also have installed one on your Windows machine.<sup id="a1">[1](#f1)</sup> Go ahead and do that now. The last line displayed in your terminal window should have some information about your computer's name, and you user name, followed by a **$** symbol. This is the **command prompt** -- you type your commands after the '$'.

<figure>
  <img src="{{ page.root }}/fig/01_bash.png" style="margin:10px;height:400px"/>
  <figcaption> An iTerm2 terminal window on Mac</figcaption>
</figure><br>

To connect to Artemis securely, we'll use the **SSH** (Secure Socket Shell) protocol; on most systems, any installed SSH client will be invoked by the command 'ssh'. Before you connect, make sure you know your **username** and **password**. When you use Artemis for your research, these will be your **Unikey** and **Unikey password**; however, for this training course we'll be using _training accounts_, which are:

* Username: **ict_hpctrain\<N\>**, with N from 1-20 (replace _**\<N\>**_ with your assigned number)
* Password: _will be written on the whiteboard!_

At your command prompt, execute the following (type it and press 'return/enter'):

~~~
ssh -X ict_hpctrain<N>@hpc.sydney.edu.au
~~~
{: .language-bash}

or, if using XQuartz on a Mac

~~~
ssh -Y ict_hpctrain<N>@hpc.sydney.edu.au
~~~
{: .language-bash}

The ```-X``` or ```-Y``` flags tell **ssh** to enable X-forwarding, which lets GUI programs on Artemis serve you graphical windows back on your local machine.

If connecting for the first time, you may get the following output, requesting authorisation to connect to a new **host** server:

~~~
The authenticity of host 'hpc.sydney.edu.au (10.250.96.203)' can't be established.
RSA key fingerprint is SHA256:qq9FPWBcyvvOWOMdFs8uZES0tF3SVzJsNx1cdn56GSE.
Are you sure you want to continue connecting (yes/no)?
~~~
{: .output}

Enter 'yes'. You will then be asked for your password; type it and press 'enter'. and you should then be logged in!

<figure>
  <img src="{{ page.root }}/fig/01_granted.png" style="margin:10px;height:420px"/>
  <figcaption> Access granted! </figcaption>
</figure><br>


<h2 data-toc-text="via SSH GUI apps"> Connecting via an SSH GUI (common for Windows users) </h2>

If you're on Windows, and followed the [Setup]({{ page.root }}/setup) guide, then you will likely be connecting through an X-window or shell client program, like 'X-Win32' or 'PuTTY'. Following the instructions in the [Setup]({{ page.root }}/setup) guide
* Open your installed program
* Select the "Artemis" session you configured earlier
* Click 'Launch' (X-Win32) or 'Open' (PuTTY)

If this is the first time connecting to Artemis, you will be asked to authorise it as a trusted **host** server; click 'Accept' (X-Win32) or 'Yes' (PuTTY).

<figure>
  <img src="{{ page.root }}/fig/01_xwinhosts.png" style="margin:10px;height:240px"/>
  <img src="{{ page.root }}/fig/01_puttyhosts.png" style="margin:10px;height:250px"/>
  <figcaption> Unknown host challenges: X-Win32 (top), PuTTY (bottom) </figcaption>
</figure><br>

* If using 'X-Win32', you'll then be asked for your **password** and once entered, you should be logged on to Artemis! A terminal window and command prompt on Artemis will appear.

* If using 'PuTTY', a terminal window will appear and prompt you for your **username**, and then your **password**. Once entered, you should be logged on to Artemis! A command prompt on Artemis will appear in that window.

<figure>
  <img src="{{ page.root }}/fig/01_xwin.png" style="margin:10px;height:220px"/>
  <img src="{{ page.root }}/fig/01_putty.png" style="margin:10px;height:350px"/>
  <figcaption> Access granted! X-Win32 (top) cuts the welcome messages, PuTTY (bottom) </figcaption>
</figure><br>


#Now let's compile on Artemis
copy or re-write your programs on Artemis.
The compiling method is the same, but we need to make sure we load the required programs, then the procedure is the same.

```
module load cuda/8.0.44
```

Now, if you have tried to run it, you will find that you cannot - that is because you are on a ***login node***, i.e. there is not GPU there. If you want to use a GPU you must run your code on a gpu node!
There is one on the training node we are using today to speed things up. And there are several more you can access normally.

Let's write a pbs script to get our code running, creat a new file called '''hello.pbs'''
```
#! /bin/bash

#PBS -P Training
#PBS -N hwGPU 
#PBS -l select=1:ncpus=1:mem=1gb:ngpus=1
#PBS -l walltime=00:01:00
#PBS -q defaultQ

cd $PBS_O_WORKDIR

module load cuda/8.0.44

./hello_gpu

```

Now check the output in hwGPU.o???
Is it what we expect! 
You can have a look at the hwGPU.e??? file to see if any messages were sent to the error log. These can be warnings, or if somehitng has gone wrong (like if you make a typo and Artemis can't find the files you are expecting) then hopefully a useful message has appear in this log. 
Finally, check out the hwGPU.o???_usage file for a detailed look at all the resources your code used.







{% include links.md %}

---
title: Installing PHP 5.4 on Centos 5.7
date: 2012-03-04
layout: post
---
I am not what one would consider a sys admin. I do enjoy running my own VPS and mucking about with things like installing the newest version of PHP, but my knowledge doesn't extend very far past yum and rpm. So using only those 2 tools I set out and succeeded in installing PHP 5.4.

After what seemed like too much time trying to find a Centos 5 compatible package I found <a href="http://rpms.famillecollet.com/enterprise/5/test/x86_64/repoview/">remi's repository</a> and installed the package
<code>
rpm -Uvh http://rpms.famillecollet.com/enterprise/5/test/x86_64/php-5.4.0-1.el5.remi.x86_64.rpm
</code>

Those of you following along will see that there are some dependencies involved here. You could add the repo and yum should handle all the dependencies 
<code>
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-5.rpm
yum --enablerepo=remi-test install php php-cli php-common php-gd php-pdo mysql ...
</code>
I chose to use the rpm command one at a time, using <a href="http://pkgs.org/">pkgs.org/</a> to locate all the packages in order to have a better handle on what exactly I had to rip out of my system in order to get 5.4 to work. It turns out I had to rip out a lot, including any remnants of php, mysql, and curl. Remi has all the updated replacements right in his repo, so I thought I would be adventurous and go for it. So, I worked my way down the dependency chain one package at a time - call me crazy, but it was kind of fun.

The bad news is that along the way I had to rip out curl and install an updated version from Remi's repo
<code>
rpm -Uvh http://rpms.famillecollet.com/enterprise/5/test/i386/libcurl-7.21.7-5.el5.remi.i386.rpm
</code>
and this resulted in <a href="http://www.modrails.com/">Phusion Passenger</a> as well as <a href="http://code.macournoyer.com/thin/">Thin</a> blowing up because of their reliance on libcurl.so.3. So I may just spin up another node on my VPS for rails-only (which I probably should be doing anyway). There may be other consequences as well - Drupal is throwing what appears to be benign errors, but who knows what other dangers are lurking. I sure wouldn't push this on any mission critical applications.

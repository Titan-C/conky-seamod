Conky Seamod theme
====================

Seamod theme was built by SeaJey. Maxiwell modified the original theme for conky 1.10 configuration. I tweaked it further with some major changes.


# Screenshot

![alt text](README-eg.png)


# New Features

## by Maxiwell

* Disk Read/Write
* Lan/Ext IP's


## by JPvRiel

Fixes
* `border_outer_margin` can be adjusted without breaking the alignment of rings.
* now runs on Ubuntu 16.04 LTS with Gnome 3.18 using `dock` or `normal` window type and hints.

Changes/enhancements
* gracefully accommodates switching between wired and wireless. NET section shows info for wired (eth0) else wireless (wlan0) info is shown.
* `own_window_argb_value` conifg option for background and semi-transparency settings.
* `conky_line` superceeds 'name' and 'arg' options to use more complex conkey objects and variables in `seamod_rings.lua`
* 'Free' text info moved to the bottom so changes avoid interfering with alignment of rings/gauges.
* Tweaked info per section, e.g. CPU temp, fan RPM, memory cache, etc.
* Added IO top info for disk / storage (matches top list for memory and processor).
* Added example script to feed last 5 warning or error messages from syslog.


# Install and run

Install within your home dir (should work in Gnome 3 at least)
```bash
sudo apt-get install conky-all
mkdir -p ~/.conky/seamod
git clone --depth=1 https://github.com/JPvRiel/conky-seamod ~/.conky/seamod
cp ~/.conky/seamod/conky.desktop ~/.config/autostart/
ln -s ~/.conky/seamod/conkyrc.lua ~/.conkyrc
```

Start (ad-hoc in shell, useful for debugging)
```
conky -c ~/.conky/seamod/conkyrc.lua
```

Stop
```
killall conky
```

Hints
* Install location assumes `~/.conky/seamod`. If not, correct script references in `conkyrc.lua`.
* For auto-start, `conky.desktop` may need other tweaks for auto-start with other desktop environments.


# Modifying

Hardware such as number of CPU cores, the place to get temperatures and even the way in which network devices are named varies, so at least one or two modificaitons will likely be needed. Herewith, the most likely changes that are typically needed.



Modify CPU rings in `seamod_rings.lua`'s `gauge` data structure list.
* Change the number of 'cpu' items  match the output of the `nproc` command. Simply comment out or remove `cpu` items in the list. Default is 8 'CPU' instances (cores and hyper threads).
* Change 'fs_used_perc' items to suite systems partitioning scheme. E.g. default has 'root', 'home' and 'var' separate.

Modify network to monitor
* simply find and replace names for `eth0` (typical for wired) and `wlan0` (typical for wireless) if your own device names differ.
* Needs to be done in both `seamod_rings.lua` and `conkyrc.lua`

E.g. fix.
```
sed -i -e 's/eth0/eth1/g' ~/.conky/seamod/conkyrc.lua  ~/.conky/seamod/seamod_rings.lua
```
CPU and fan temperature uses the `hwmon` conky variable. You'll need to find your hardware specific path and inputs somewhere in `/sys/class/hwmon/*`. Sadly, some systems might not consistently use hwmon1 vs hwmon0 between boots.

*N.B!* Alignment between rings and the text is painfully brittle. So avoid changing the number of lines in the text section that algin next to rings. Best place to add own text or info is under `# Extra info`. And to make room, you can remove some lines. E.g. 
* Entropy pool bar for crypto nerds may be arb and can be removed. Delete line with `entropy_bar` etc.
* You might prefer not to see how often errors and warnings are spat out by syslog. Delete line with `{texecpi 60 ~/.conky/seamod/syslog-err-feed.sh}`

Ring/gauge sections
* In `conkyrc.lua`
  * 3 lines of info are accommodated above the graph sections - substitute as you deem fit, but keep the spacing at 3 lines to avoid misalignment between rings and text. 
* In `seamod_rings.lua`
  * Fiddle with `graph_radius`, `graph_thickness` and if used, `txt_radius`, so adjust ring sizing.
  * In `gauges` items, use `conky_line` instead of `name` and `arg` if advanced objects are needed.

# Bugs / TODO

## Network changes

Conky's `if_up` object triggers a seemingly benign stream of `SIOCGIFADDR: Cannot assign requested address` errors when used with the `if_up_strictness = 'address'` config option.
* `${ip_up eth0}` is commented out and replaced.
* `${if_match "${addr eth0}" != "No Address"}` provides a workaround.

## Multiple screens

Conky always displays on the rightmost screen's edge, given many desktops and graphics drivers setup the display as one large X screen and resolution.
* The `xinerama_head` option is supposed to help pin/dock the window to the first screen, but requires a very recent version of conkey (and Ubuntu 16.04 LTS only packaged v1.10.1 without the fix) 
* Example issue [here](https://github.com/brndnmtthws/conky/issues/249) and [here](https://github.com/brndnmtthws/conky/issues/172).


# Related Work

Click [here](http://www.deviantart.com/art/Conky-Seamod-v0-1-283461046) to see the original theme and screenshots.
Click [here](https://github.com/maxiwell/conky-seamod) for repo with previous version

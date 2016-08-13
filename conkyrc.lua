-----------------------------------------------------------------------------
--                               conkyrc_seamod
-- Date    : 04/23/2016
-- Author  : SeaJey and Maxiwell
-- Conky   : >= 1.10
-- License : Distributed under the terms of GNU GPL version 2 or later
-----------------------------------------------------------------------------

conky.config = {

	background = true,
	update_interval = 1,

	cpu_avg_samples = 2,
	net_avg_samples = 2,
	temperature_unit = 'celsius',

	double_buffer = true,
	no_buffers = true,
	text_buffer_size = 2048,

	gap_x = 80,
	gap_y = 70,
	minimum_width = 340, minimum_height = 600,
	maximum_width = 360,
	own_window = true,
	own_window_type = 'desktop',
	own_window_transparent = false,
	own_window_argb_visual = true,
	own_window_argb_value = 192,

	--own_window_class = 'conky-semi',
	own_window_hints = 'undecorated,sticky,skip_taskbar,skip_pager,below',
	border_inner_margin = 0,
	border_outer_margin = 20,
	alignment = 'top_right',

	draw_shades = false,
	draw_outline = false,
	draw_borders = false,
	draw_graph_borders = false,

	override_utf8_locale = true,
	use_xft = true,
	font = 'caviar dreams:size=11',
	xftalpha = 0.5,
	uppercase = false,

-- Defining colors
	default_color = '#FFFFFF',
-- Shades of Gray
	color1 = '#DDDDDD',
	color2 = '#AAAAAA',
	color3 = '#888888',
-- Orange
	color4 = '#EF5A29',
-- Green
	color5 = '#77B753',
-- Loading lua script for drawning rings
	lua_load = '~/.conky/seamod/seamod_rings.lua',
	lua_draw_hook_post = 'main',
};

conky.text = [[
# Showing CPU Graph with TOP 5
${voffset -10}
${offset 180}${color1}${font Ubuntu:size=10:style=bold}CPU Temp: ${alignr}${font Ubuntu:size=10:style=normal}${color2}${hwmon 2 temp 1} C
${offset 180}${color1}${font Ubuntu:size=10:style=bold}CPU Fan: ${alignr}${font Ubuntu:size=10:style=normal}${color2}${hwmon 2 fan 1} RPM
${offset 135}${cpugraph cpu0 40,200 666666 666666}
${voffset -32}
${offset 82}${font Ubuntu:size=11:style=bold}${color5}PROC
# Showing TOP 5 CPU-consumers
${offset 105}${font Ubuntu:size=12:style=normal}${color4}${top name 1}${alignr}${top cpu 1}%
${offset 105}${font Ubuntu:size=11:style=normal}${color1}${top name 2}${alignr}${top cpu 2}%
${offset 105}${font Ubuntu:size=10:style=normal}${color2}${top name 3}${alignr}${top cpu 3}%
${offset 105}${font Ubuntu:size=10:style=normal}${color3}${top name 4}${alignr}${top cpu 4}%
${offset 105}${font Ubuntu:size=10:style=normal}${color3}${top name 5}${alignr}${top cpu 5}%


#Showing memory Graph with TOP 5
${offset 180}${color1}${font Ubuntu:size=10:style=bold}Page Cache: ${alignr}${font Ubuntu:size=10:style=normal}${color2}${cached}
${offset 180}${color1}${font Ubuntu:size=10:style=bold}Buffer Cache: ${alignr}${font Ubuntu:size=10:style=normal}${color2}${buffers}
${offset 135}${memgraph 40,200 666666 666666}
${voffset -32}
${offset 90}${font Ubuntu:size=11:style=bold}${color5}MEM
${offset 105}${font Ubuntu:size=12:style=normal}${color4}${top_mem name 1}${alignr}${top_mem mem_res 1}
${offset 105}${font Ubuntu:size=11:style=normal}${color1}${top_mem name 2}${alignr}${top_mem mem_res 2}
${offset 105}${font Ubuntu:size=10:style=normal}${color2}${top_mem name 3}${alignr}${top_mem mem_res 3}
${offset 105}${font Ubuntu:size=10:style=normal}${color3}${top_mem name 4}${alignr}${top_mem mem_res 4}
${offset 105}${font Ubuntu:size=10:style=normal}${color3}${top_mem name 4}${alignr}${top_mem mem_res 5}


# Showing disk partitions: root, home and files
${offset 180}${color1}${font Ubuntu:size=10:style=bold}Disk Read: ${alignr}${font Ubuntu:size=10:style=normal}${color2}${diskio_read}
${offset 180}${color1}${font Ubuntu:size=10:style=bold}Disk Write: ${alignr}${font Ubuntu:size=10:style=normal}${color2}${diskio_write}
${offset 135}${diskiograph 40,200 666666 666666}
${voffset -32}
${offset 75}${font Ubuntu:size=11:style=bold}${color5}STORE
${offset 105}${font Ubuntu:size=12:style=normal}${color4}${top_mem name 1}${alignr}${top_io io_perc 1}%
${offset 105}${font Ubuntu:size=11:style=normal}${color1}${top_mem name 2}${alignr}${top_io io_perc 2}%
${offset 105}${font Ubuntu:size=10:style=normal}${color2}${top_mem name 3}${alignr}${top_io io_perc 3}%
${offset 105}${font Ubuntu:size=10:style=normal}${color2}${top_mem name 3}${alignr}${top_io io_perc 4}%
${offset 105}${font Ubuntu:size=10:style=normal}${color2}${top_mem name 3}${alignr}${top_io io_perc 5}%


# Network data (assumes wireless info). NET ring is mostly useless but looks pretty, main info is in the graphs
${if_match "${addr wlan0}" == "No Address"}\

${offset 200}${font Ubuntu:size=10:style=bold}${color1}Wired IP: ${alignr}$color3${addr eth0}
${offset 200}${font Ubuntu:size=10:style=bold}${color1}Public IP: ${alignr}$color3${execi 3600 wget -q -O /dev/stdout http://checkip.dyndns.org/ | cut -d : -f 2- | cut -d \< -f -1}
${offset 135}${upspeedgraph eth0 25,200 4B1B0C FF5C2B 1280KiB -l}
${offset 135}${color1}${font Ubuntu:size=10:style=bold}Up: ${alignr}${font Ubuntu:size=10:style=normal}$color2${upspeed eth0} / ${totalup eth0}
${offset 135}${downspeedgraph eth0 25,200 324D23 77B753 1280KiB -l}
${offset 135}${color1}${font Ubuntu:size=10:style=bold}Down: ${alignr}${font Ubuntu:size=10:style=normal}$color2${downspeed eth0} / ${totaldown eth0}
${else}\
${offset 200}${font Ubuntu:size=10:style=bold}${color1}SSID: ${alignr}$color3${wireless_essid}
${offset 200}${font Ubuntu:size=10:style=bold}${color1}Wifi IP: ${alignr}$color3${addr wlan0}
${offset 200}${font Ubuntu:size=10:style=bold}${color1}Public IP: ${alignr}$color3${execi 3600 wget -q -O /dev/stdout http://checkip.dyndns.org/ | cut -d : -f 2- | cut -d \< -f -1}
${offset 135}${upspeedgraph wlan0 25,200 4B1B0C FF5C2B 1280KiB -l}
${offset 135}${color1}${font Ubuntu:size=10:style=bold}Up: ${alignr}${font Ubuntu:size=10:style=normal}$color2${upspeed wlan0} / ${totalup wlan0}
${offset 135}${downspeedgraph wlan0 25,200 324D23 77B753 1280KiB -l}
${offset 135}${color1}${font Ubuntu:size=10:style=bold}Down: ${alignr}${font Ubuntu:size=10:style=normal}$color2${downspeed wlan0} / ${totaldown wlan0}
${endif}\
${voffset -100}
${offset 95}${font Ubuntu:size=11:style=bold}${color5}NET

#### Modifications below HERE wont cause alignment problems with the gauges/rings ####

# Extra info
${voffset 60}
${offset 15}${font Ubuntu:size=11:style=normal}${color1}Entropy:${tab}${color3}${entropy_bar 5,150}  ${color3}${entropy_perc}% (${entropy_avail}/${entropy_poolsize})
${offset 15}${font Ubuntu:size=11:style=normal}${color1}Battery:${tab}${color3}${battery_bar 5,150}  ${if_match ${battery_percent BAT0} <= 33}${color4}${else}${color3}${endif}${battery_percent}% (${battery_short})
${offset 15}${font Ubuntu:size=11:style=normal}${color1}Uptime:${tab}${tab}${color3}$uptime

# Log feed
${offset 15}${font Ubuntu:size=11:style=normal}${color1}Syslog Err:
${voffset 3}${color3}${font LiberationSansNarrow-Regular:size=8:style=normal}${execpi 15 ~/.conky/seamod/conky-syslog-err-feed.sh }
]];
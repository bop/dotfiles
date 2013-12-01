-- default rc.lua for shifty
--
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")

-- Load Debian menu entries                                                        
require("debian.menu")

-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- shifty - dynamic tagging library
require("shifty")

-- widgets vicieux
require("vicious")

require('calendar2')

-- volume expérimental
-- require("obvious.volume_alsa")

-- useful for debugging, marks the beginning of rc.lua exec
print("Entered rc.lua: " .. os.time())

-- Variable definitions
-- Themes define colours, icons, and wallpapers
-- The default is a dark theme
theme_path = "/usr/share/awesome/themes/zenburn/theme.lua"
-- Uncommment this for a lighter theme
-- theme_path = "/usr/share/awesome/themes/sky/theme"

-- Actually load theme
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
browser = "chromium"
mail = "alpine"
terminal = "sakura"
editor = os.getenv("EDITOR") or "emacs"
editor_cmd = terminal .. " -e " .. editor
calendar = "orage"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key, I suggest you to remap
-- Mod4 to another key using xmodmap or other tools.  However, you can use
-- another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false

-- Shifty configured tags.
shifty.config.tags = {
   Debian = {
        layout    = awful.layout.suit.tile.left,
        mwfact    = 0.60,
        exclusive = false,
        position  = 1,
        init      = true,
        screen    = 1,
        slave     = true,
    },
    Zen = {
        layout    = awful.layout.suit.fair,
        mwfact    = 0.60,
        exclusive = false,
        position  = 2,
        init      = true,
        screen    = 1,
        slave     = true,
    },

    Web = {
        layout      = awful.layout.suit.tile.left,
        mwfact      = 0.65,
        exclusive   = true,
        max_clients = 1,
        position    = 4,
        spawn       = browser,
    },
    mail = {
        layout    = awful.layout.suit.tile,
        mwfact    = 0.55,
        exclusive = false,
        position  = 7,
        spawn     = mail,
        slave     = true,
    },
    media = {
        layout    = awful.layout.suit.max,
        exclusive = false,
        position  = 6,
    },
    Office = {
        layout   = awful.layout.suit.tile,
        position = 5,

    },

    Emacs = {
        layout   = awful.layout.suit.tile,
        position = 3,

    },
}

-- SHIFTY: application matching rules
-- order here matters, early rules will be applied first
shifty.config.apps = {
    {
        match = {
            "Navigator",
            "Chromium",
            "Gran Paradiso",
        },
        tag = "Web",
    },
    {
        match = {
	   "xterm",
	      "vlc",
            "Alpine",
	    "moc",
	   "gcalcli",
	    "cmus",
            "Thunderbird",
        },
        tag = "media",
    },
    {
        match = {
	"thunar",	
    "nautilus",
        },
        slave = true,
	tag = "Zen",
    },
    {
        match = {
	    "Geany",
            "Abiword",
            "Gnumeric",
	   "evince",
        },
        tag = "Office",
	slave = false,
    },


    {
	match = {
	"Emacs",
	},
	tag = "Emacs"

    },

    {
        match = {
            "MPlayer",
            "Gnuplot",
            "galculator",
        },
        float = true,
    },
    {
        match = {
	   "sakura",
        },
	tag = "Debian",
        honorsizehints = false,
        slave = true,
    },
    {
        match = {""},
        buttons = awful.util.table.join(
            awful.button({}, 1, function (c) client.focus = c; c:raise() end),
            awful.button({modkey}, 1, function(c)
                client.focus = c
                c:raise()
                awful.mouse.client.move(c)
                end),
            awful.button({modkey}, 3, awful.mouse.client.resize)
            )
    },
}

-- SHIFTY: default tag creation rules
-- parameter description
--  * floatBars : if floating clients should always have a titlebar
--  * guess_name : should shifty try and guess tag names when creating
--                 new (unconfigured) tags?
--  * guess_position: as above, but for position parameter
--  * run : function to exec when shifty creates a new tag
--  * all other parameters (e.g. layout, mwfact) follow awesome's tag API
shifty.config.defaults = {
    layout = awful.layout.suit.tile.left,
    ncol = 1,
    mwfact = 0.60,
    floatBars = true,
    guess_name = true,
    guess_position = true,
}


--  Wibox


-- Enable mocp control
function moc_control (action)
        local moc_info,moc_state
 
        if action == "next" then
	   io.popen("mocp --next")
        elseif action == "previous" then
	   io.popen("mocp --previous")
        elseif action == "stop" then
	   io.popen("mocp --stop")
        elseif action == "play_pause" then
	   moc_info = io.popen("mocp -i"):read("*all")
	   moc_state = string.gsub(string.match(moc_info, "State: %a*"),"State: ","")
 
                if moc_state == "PLAY" then
		   io.popen("mocp --pause")
                elseif moc_state == "PAUSE" then
		   io.popen("mocp --unpause")
                elseif moc_state == "STOP" then
		   io.popen("mocp --play")
                end
	     end
	  end
 
-- Moc Widget
tb_moc = widget({ type = "textbox", align = "right" })
 
function hook_moc()
   moc_info = io.popen("mocp -i"):read("*all")
   moc_state = string.gsub(string.match(moc_info, "State: %a*"),"State: ","")
        if moc_state == "PLAY" or moc_state == "PAUSE" then
	   moc_artist = string.gsub(string.match(moc_info, "Artist: %C*"), "Artist: ","")
	   moc_title = string.gsub(string.match(moc_info, "SongTitle: %C*"), "SongTitle: ","")
	   moc_curtime = string.gsub(string.match(moc_info, "CurrentTime: %d*:%d*"), "CurrentTime: ","")
	   moc_totaltime = string.gsub(string.match(moc_info, "TotalTime: %d*:%d*"), "TotalTime: ","")
                if moc_artist == "" then
                        moc_artist = "unknown artist"
                end
                if moc_title == "" then
                        moc_title = "unknown title"
                end
                moc_string = awful.util.escape(moc_artist .. " - " .. moc_title .. "(" .. moc_curtime .. "/" .. moc_totaltime .. ")")
                if moc_state == "PAUSE" then
                        moc_string = '<span color="orange">||</span> ' .. moc_string .. ''
                else
                        moc_string = '<span color="green">\></span> ' .. moc_string .. ''
                end
	     else
                moc_string = "--"
	     end
        return moc_string
	  end
 
-- refresh Moc widget
moc_timer = timer({timeout = 1})
moc_timer:add_signal("timeout", function() tb_moc.text = ' ' .. hook_moc() .. ' ' end)
moc_timer:start()

-- Separator                                                                      
                                                                                   
separator = widget({ type = "textbox" })
separator.text  = "  ::  "


 --  Network usage widget                                                          
 -- Initialize widget                                                              
netwidget = widget({ type = "textbox" })
 -- Register widget					                            
vicious.register(netwidget, vicious.widgets.net, 'Net: <span color="#FF5533">${eth0 down_kb}</span> / <span color="#7FFFD4">${eth0 up_kb}</span>', 3)

-- Initialize cpuwidget                                            
cpuwidget = widget({ type = "textbox" })
-- Register widget                                                         
vicious.register(cpuwidget, vicious.widgets.cpu, ":: cpu: <span foreground='#C6E2FF'>  $4% </span>")
-- cpuicon = widget({ type = "imagebox" })
-- cpuicon.image = image(beautiful.cpuwidget)



-- Create a textbox widget
os.setlocale("fr_CH.UTF-8") -- Français
mytextclock = awful.widget.textclock({align = "center"},"<span foreground='#FFFF00' font-family='TeXGyreAdventor'>  %A %d %B  %H:%M </span> ")
clockicon = widget({ type = "imagebox" })

clockicon.image = image("/home/bossip/.config/awesome/icons2/calendar2.png")
calendar2.addCalendarToWidget(clockicon, "<span color='#00BFFF'>%s</span>")


-- Create a laucher widget and a main menu
myawesomemenu = {
    {"manual", "xterm -e man awesome"},
    {"Web", "chromium-browser" },
    {"Alpine", "xterm -e alpine"},
    {"rtorrent", "xterm -e tor"},
    {"music on command", "xterm -e mocp"},
    {"edit config",
     editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua"},
    {"restart", awesome.restart},
    {"quit", awesome.quit}
}

mymainmenu = awful.menu(
    {
        items = {
            {"awesome", myawesomemenu, beautiful.awesome_icon},
	    { "Debian", debian.menu.Debian_menu.Debian },
              {"open terminal", terminal}}
          })

mylauncher = awful.widget.launcher({image = image(beautiful.awesome_icon),
                                     menu = mymainmenu})

-- Create a systray
mysystray = widget({type = "systray", align = "right"})

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({}, 1, awful.tag.viewonly),
    awful.button({modkey}, 1, awful.client.movetotag),
    awful.button({}, 3, function(tag) tag.selected = not tag.selected end),
    awful.button({modkey}, 3, awful.client.toggletag),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
    )

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
    awful.button({}, 1, function(c)
        if not c:isvisible() then
            awful.tag.viewonly(c:tags()[1])
        end
        client.focus = c
        c:raise()
        end),
    awful.button({}, 3, function()
        if instance then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({width=250})
        end
        end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
        end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
        end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] =
        awful.widget.prompt({layout = awful.widget.layout.leftright})
    -- Create an imagebox widget which will contains an icon indicating which
    -- layout we're using.  We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
            awful.button({}, 1, function() awful.layout.inc(layouts, 1) end),
            awful.button({}, 3, function() awful.layout.inc(layouts, -1) end),
            awful.button({}, 4, function() awful.layout.inc(layouts, 1) end),
            awful.button({}, 5, function() awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s,
                                            awful.widget.taglist.label.all,
                                            mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist.new(function(c)
                        return awful.widget.tasklist.label.currenttags(c, s)
                    end,
                                              mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({position = "top", height="25", screen = s})
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock, clockicon,
	separator, netwidget, 
	separator, cpuwidget,
	tb_moc,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
        }

    mywibox[s].screen = s
end

-- SHIFTY: initialize shifty
-- the assignment of shifty.taglist must always be after its actually
-- initialized with awful.widget.taglist.new()
shifty.taglist = mytaglist
shifty.init()

-- Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({}, 3, function() mymainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))


-- Key bindings
globalkeys = awful.util.table.join(
    -- Tags
    awful.key({modkey,}, "Left", awful.tag.viewprev),
    awful.key({modkey,}, "Right", awful.tag.viewnext),
    awful.key({modkey,}, "Escape", awful.tag.history.restore),
    -- raccourci emacs: "super + e"                                          
    awful.key({ modkey}, "e", function () awful.util.spawn("emacs") end),
    -- thunar file manager                                                         
    awful.key({ modkey}, "b", function () awful.util.spawn("thunar") end),
    -- chromium navigateur                                                         
    awful.key({ modkey}, "w", function () awful.util.spawn("chromium-browser") end),
    -- conky                                                                       
	 awful.key({ modkey,"Mod1"}, "c", function () awful.util.spawn("conky") end),
    -- music on command                                                            
	 awful.key({ modkey,}, "p", function () awful.util.spawn("xterm -e mocp") end),
  -- cmus
  	 awful.key({ modkey,}, "c", function () awful.util.spawn("xterm -e cmus") end),	 
    -- alpine                                                
	 awful.key({ modkey}, "g", function () awful.util.spawn("xterm -e alpine") end),
    -- iceweasel                                                                   
	 awful.key({ modkey}, "i", function () awful.util.spawn("iceweasel") end ),
    -- shutter
	 awful.key({ modkey}, "7", function () awful.util.spawn("shutter") end ),
    --multimedia keys

	 awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q sset Master 2dB-") end),
	 awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q sset Master 2dB+") end),

	 awful.key({           }, "XF86Music",   function () awful.util.spawn ("mocp --play") end),
	 awful.key({           }, "XF86AudioPlay",   function () awful.util.spawn ("mocp --toggle-pause") end),
	 awful.key({           }, "XF86AudioStop",   function () awful.util.spawn ("mocp --stop") end),
	 awful.key({           }, "XF86AudioNext",   function () awful.util.spawn ("mocp --next") end),
	 awful.key({           }, "XF86AudioPrev",   function () awful.util.spawn ("mocp --previous") end),

    -- Shifty: keybindings specific to shifty
    awful.key({modkey, "Shift"}, "d", shifty.del), -- delete a tag
    awful.key({modkey, "Shift"}, "n", shifty.send_prev), -- client to prev tag
    awful.key({modkey}, "n", shifty.send_next), -- client to next tag
    awful.key({modkey, "Control"},
              "n",
              function()
                  local t = awful.tag.selected()
                  local s = awful.util.cycle(screen.count(), t.screen + 1)
                  awful.tag.history.restore()
                  t = shifty.tagtoscr(s, t)
                  awful.tag.viewonly(t)
              end),
    awful.key({modkey}, "a", shifty.add), -- creat a new tag
    awful.key({modkey,}, "r", shifty.rename), -- rename a tag
--    awful.key({modkey, "Shift"}, "a", -- nopopup new tag
--    function()
--        shifty.add({nopopup = true})
--    end),

    awful.key({modkey,}, "j",
    function()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({modkey,}, "k",
    function()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({modkey,}, "F2", function() mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({modkey, "Shift"}, "j",
        function() awful.client.swap.byidx(1) end),
    awful.key({modkey, "Shift"}, "k",
        function() awful.client.swap.byidx(-1) end),
    awful.key({modkey, "Control"}, "j", function() awful.screen.focus(1) end),
    awful.key({modkey, "Control"}, "k", function() awful.screen.focus(-1) end),
    awful.key({modkey,}, "u", awful.client.urgent.jumpto),
    awful.key({modkey,}, "Tab",
    function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end),

    -- Standard program
    awful.key({modkey,}, "Return", function() awful.util.spawn(terminal) end),
    awful.key({modkey, "Control"}, "r", awesome.restart),
    awful.key({modkey, "Shift"}, "q", awesome.quit),

    awful.key({modkey,}, "l", function() awful.tag.incmwfact(0.05) end),
    awful.key({modkey,}, "h", function() awful.tag.incmwfact(-0.05) end),
    awful.key({modkey, "Shift"}, "h", function() awful.tag.incnmaster(1) end),
    awful.key({modkey, "Shift"}, "l", function() awful.tag.incnmaster(-1) end),
    awful.key({modkey, "Control"}, "h", function() awful.tag.incncol(1) end),
    awful.key({modkey, "Control"}, "l", function() awful.tag.incncol(-1) end),
    awful.key({modkey,}, "space", function() awful.layout.inc(layouts, 1) end),
    awful.key({modkey, "Shift"}, "space",
        function() awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({modkey}, "F1", function()
        awful.prompt.run({prompt = "Run: "},
        mypromptbox[mouse.screen].widget,
        awful.util.spawn, awful.completion.shell,
        awful.util.getdir("cache") .. "/history")
        end),

    awful.key({modkey}, "F4", function()
        awful.prompt.run({prompt = "Run Lua code: "},
        mypromptbox[mouse.screen].widget,
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval")
        end)


    )


-- Client awful tagging: this is useful to tag some clients and then do stuff
-- like move to tag on them
clientkeys = awful.util.table.join(
    awful.key({modkey,}, "f", function(c) c.fullscreen = not c.fullscreen  end),
    awful.key({modkey, "Shift"}, "c", function(c) c:kill() end),
    awful.key({modkey, "Control"}, "space", awful.client.floating.toggle),
    awful.key({modkey, "Control"}, "Return",
        function(c) c:swap(awful.client.getmaster()) end),
    awful.key({modkey,}, "o", awful.client.movetoscreen),
    awful.key({modkey, "Shift"}, "r", function(c) c:redraw() end),
    awful.key({modkey}, "t", awful.client.togglemarked),
    awful.key({modkey,}, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- SHIFTY: assign client keys to shifty for use in
-- match() function(manage hook)
shifty.config.clientkeys = clientkeys
shifty.config.modkey = modkey

-- Compute the maximum number of digit we need, limited to 9
for i = 1, (shifty.config.maxtags or 9) do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({modkey}, i, function()
            local t =  awful.tag.viewonly(shifty.getpos(i))
            end),
        awful.key({modkey, "Control"}, i, function()
            local t = shifty.getpos(i)
            t.selected = not t.selected
            end),
        awful.key({modkey, "Control", "Shift"}, i, function()
            if client.focus then
                awful.client.toggletag(shifty.getpos(i))
            end
            end),
        -- move clients to other tags
        awful.key({modkey, "Shift"}, i, function()
            if client.focus then
                t = shifty.getpos(i)
                awful.client.movetotag(t)
                awful.tag.viewonly(t)
            end
        end))
    end

-- Set keys
root.keys(globalkeys)

-- Hook function to execute when focusing a client.
client.add_signal("focus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Hook function to execute when unfocusing a client.
client.add_signal("unfocus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)


-- {{{ Signals                                                                                          
-- Signal function to execute when a new client appears.                                                
client.add_signal("manage", function (c, startup)
    -- Add a titlebar                                                                                   
			       -- awful.titlebar.add(c, { modkey = modkey })                                                       

    -- Enable sloppy focus                                                                              
			       c:add_signal("mouse::enter", function(c)
							       if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
							       and awful.client.focus.filter(c) then
            client.focus = c
							    end
							 end)

    if not startup then
        -- Set the windows at the slave,                                                                
       -- i.e. put it at the end of others instead of setting it master.                               
       -- awful.client.setslave(c)                                                                     

        -- Put windows in a smart way, only if they does not set an initial position.                   
        if not c.size_hints.user_position and not c.size_hints.program_position then
	   awful.placement.no_overlap(c)
	   awful.placement.no_offscreen(c)
        end
     end
  end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}                                                                                                  


-- programmes lancés au démarrage de la session                                                         


-- volume
awful.util.spawn_with_shell("sleep 1s && gnome-sound-applet ")



-- gcal
--awful.util.spawn_with_shell("sleep 1s && terminator")


-- ssh agent
awful.util.spawn_with_shell("sleep 1s && ssh-agent $SHELL;")
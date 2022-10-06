# color codes:
# https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
# 	$([char]0x1b)[0m => Reset
#
# 	8bit color:
# 		$([char]0x1b)[38;5;<color_code>m => foreground
# 		$([char]0x1b)[48;5;<color_code>m => background
#
# 	24bit color:
# 		$([char]0x1b)[38;2;<r>;<g>:<b>m => foreground
# 		$([char]0x1b)[48;2;<r>;<g>:<b>m => background

# format directory as ~/path/to/folder/ = $(([string]$pwd).replace($home, '~').replace('\', '/'))

function global:prompt
{
	$len  = 40 # maximum length of the path before you begin truncating
	$path = $executionContext.SessionState.Path.CurrentLocation.path
	$host.ui.RawUI.WindowTitle = $path # display in the title bar

	# ANSI codes
	$fg    = "$([char]0x1b)[38;2" # foreground
	$bg    = "$([char]0x1b)[48;2" # background
	$reset = "$([char]0x1b)[0m"   # resets the colors

	# colors (in RGB format; the m at the end is ANSI code format which are to be concatenated with $fg and/or $bg)
	# usage: $fg;$red
	$red    = "196;101;92m"
	$green  = "184;197;113m"
	$blue   = "132;162;196m"
	$orange = "196;161;132m"

	$gitBranch = git rev-parse --abbrev-ref HEAD
	$isAdmin   = (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

	# ref: https://jdhitsolutions.com/blog/powershell/7149/friday-fun-taking-a-shortcut-path-in-your-powershell-prompt/
	if ($path.length -gt $len) 
	{
		#escape the separator character to treat it as a literal
		#filter out any blank entries which might happen if the path ends with the delimiter
		$split = $path -split "\\" | Where-Object { $_ -match "\S+" }
		#reconstruct a shorted path
		$path = "…\$($split[-3])\$($split[-2])\$($split[-1])"
	}

	# prompt display format
	$admin     = "$fg;$red$(if ($isAdmin){ "[  Admin ] " })"
	$directory = "$fg;$blue $path"
	$gitBranch = "$fg;$green$(if ($gitBranch) { "  $gitBranch" })"
	$end       = "$fg;$orange >$reset"

	return "$admin$directory$gitBranch$end "
}
